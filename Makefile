# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: luide-so <luide-so@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/21 14:46:46 by luide-so          #+#    #+#              #
#    Updated: 2023/06/22 02:24:19 by luide-so         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex
SRC = pipex.c
SRC_BONUS = pipex_bonus.c pipex_utils_bonus.c
OBJS = ${SRC:.c=.o}
OBJS_BONUS = ${SRC_BONUS:.c=.o}
HEADER = pipex.h
HEADER_BONUS = pipex_bonus.h
INCLUDE = -I .
CC = cc
RM = rm -f
CFLAGS = -Wall -Wextra -Werror -g -fsanitize=address

all: ${NAME}

${NAME}: ${OBJS} ${HEADER}
	@make -s -C Libft
	@${CC} ${CFLAGS} ${INCLUDE} -o ${NAME} ${OBJS} -L Libft_obj -lft
	@echo "\n${NAME} created"

%.o: %.c
	@${CC} ${CFLAGS} ${INCLUDE} -c $< -o $@
	@echo "\nObject files created"

clean:
	@${RM} ${OBJS} ${OBJS_BONUS}
	@echo "\nObject files removed"
	@make fclean -s -C Libft

fclean: clean
	@${RM} ${NAME}
	@echo "\n${NAME} removed"

bonus: ${OBJS_BONUS} ${HEADER_BONUS}
	@make -s -C Libft
	${CC} ${CFLAGS} ${INCLUDE} -o ${NAME} ${OBJS_BONUS} -L Libft_obj -lft
	@echo "\n${NAME} created"

re: fclean all

.PHONY: all clean fclean re bonus
