/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex_utils_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: luide-so <luide-so@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/21 23:09:53 by luide-so          #+#    #+#             */
/*   Updated: 2023/06/21 23:10:29 by luide-so         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex_bonus.h"

void	ft_here_doc(int fd, char *eof)
{
	char	*line;

	ft_printf("> ");
	line = get_next_line(0);
	while (ft_strncmp(line, eof, ft_strlen(eof))
		|| ft_strclen(line, '\n') != ft_strlen(eof))
	{
		ft_putstr_fd(line, fd);
		free(line);
		ft_printf("> ");
		line = get_next_line(0);
	}
	free(line);
	close(fd);
}
