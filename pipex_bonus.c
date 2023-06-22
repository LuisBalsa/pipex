/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex_bonus.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: luide-so <luide-so@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/21 18:35:56 by luide-so          #+#    #+#             */
/*   Updated: 2023/06/22 04:02:19 by luide-so         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex_bonus.h"

void	check(int result, char *msg)
{
	if (result == -1)
	{
		ft_putstr_fd("pipex: ", STDERR_FILENO);
		perror(msg);
		exit(EXIT_FAILURE);
	}
}

char	*get_path(char *cmd, char **envp)
{
	char	*path;
	char	*aux;
	int		i;

	i = 0;
	while (envp[i] && ft_strncmp(envp[i], "PATH=", 5))
		i++;
	if (!envp[i])
		return (cmd);
	envp[i] += 5;
	while (*envp[i])
	{
		path = ft_substr(envp[i], 0, ft_strclen(envp[i], ':'));
		aux = ft_strjoin(path, "/");
		free(path);
		path = ft_strjoin(aux, cmd);
		free(aux);
		if (!access(path, F_OK))
			return (path);
		free(path);
		envp[i] += ft_strclen(envp[i], ':')
			+ (ft_strclen(envp[i], ':') != ft_strlen(envp[i]));
	}
	return (cmd);
}

void	exec_cmd(char *cmd, char **envp)
{
	char	**args;
	char	*path;

	args = ft_split(cmd, ' ');
	if (ft_strchr(args[0], '/'))
		path = ft_strdup(args[0]);
	else
		path = get_path(args[0], envp);
	execve(path, args, envp);
	ft_putstr_fd("pipex: ", STDERR_FILENO);
	perror(path);
	ft_free_array(args);
	free(path);
	exit(EXIT_FAILURE);
}

void	redirect(int *fd, char *cmd, char **envp, int here_doc)
{
	pid_t	pid;

	if (!here_doc)
		check(pipe(fd), "pipe");
	pid = fork();
	check(pid, "fork");
	if (pid)
	{
		close(fd[1]);
		dup2(fd[0], STDIN_FILENO);
		waitpid(pid, NULL, 0);
		if (here_doc)
		{
			check(unlink("here_doc"), "here_doc");
			here_doc = 0;
		}
	}
	else
	{
		dup2(fd[1], STDOUT_FILENO);
		exec_cmd(cmd, envp);
		close(fd[0]);
	}
}

int	main(int argc, char **argv, char **envp)
{
	int	i;
	int	here_doc;
	int	fd_file[2];

	if (argc >= 5)
	{
		here_doc = (argc == 6 && !ft_strncmp(argv[1], "here_doc", 8));
		fd_file[0] = open(argv[1], O_RDWR
				| O_TRUNC * here_doc | O_CREAT * here_doc, 0644);
		check(fd_file[0], argv[1]);
		fd_file[1] = open(argv[argc - 1], O_RDWR | O_TRUNC * !here_doc
				| O_APPEND * here_doc | O_CREAT, 0644);
		check(fd_file[1], argv[argc - 1]);
		if (here_doc)
			ft_here_doc(fd_file[0], argv[2]);
		dup2(fd_file[0], STDIN_FILENO);
		dup2(fd_file[1], STDOUT_FILENO);
		i = 2 + here_doc;
		while (i < argc - 2)
			redirect(fd_file, argv[i++], envp, here_doc);
		exec_cmd(argv[argc - 2], envp);
	}
	else
		ft_printf("Usage:./pipex file1/(here_doc LIMITER) cmd1 .. cmdx file2\n");
	return (0);
}
