/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex_utils_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: luide-so <luide-so@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/21 23:09:53 by luide-so          #+#    #+#             */
/*   Updated: 2023/06/29 18:08:24 by luide-so         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex_bonus.h"

void	ft_here_doc(char *eof)
{
	char	*line;
	int		fd_here_doc;

	fd_here_doc = open("here_doc", O_RDWR | O_TRUNC | O_CREAT, 0644);
	ft_printf("> ");
	line = get_next_line(0);
	while (line && (ft_strncmp(line, eof, ft_strlen(eof))
		|| ft_strclen(line, '\n') != ft_strlen(eof)))
	{
		ft_putstr_fd(line, fd_here_doc);
		free(line);
		ft_printf("> ");
		line = get_next_line(0);
	}
	free(line);
	close(fd_here_doc);
}
