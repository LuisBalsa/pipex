# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: luide-so <luide-so@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/21 14:46:46 by luide-so          #+#    #+#              #
#    Updated: 2023/06/30 02:20:42 by luide-so         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex
RULE = .all
RULE_BONUS = .bonus
SRC = pipex.c
SRC_BONUS = pipex_bonus.c pipex_utils_bonus.c
OBJS = ${SRC:.c=.o}
OBJS_BONUS = ${SRC_BONUS:.c=.o}
HEADER = pipex.h
HEADER_BONUS = pipex_bonus.h
INCLUDE = -I .
CC = cc
RM = rm -f
CFLAGS = -Wall -Wextra -Werror -g #-fsanitize=address

GREEN = \033[0;32m
YELLOW = \033[0;33m
END = \033[0m

all: ${NAME}

${NAME}: ${RULE} ${OBJS} ${HEADER}
	@make -s -C Libft
	@${CC} ${CFLAGS} ${INCLUDE} -o ${NAME} ${OBJS} -L Libft_obj -lft
	@echo "\n${NAME} created"

${RULE}:
	@touch ${RULE}
	@${RM} ${RULE_BONUS}

bonus: ${RULE_BONUS}

${RULE_BONUS}: ${OBJS_BONUS} ${HEADER_BONUS}
	@touch ${RULE_BONUS}
	@${RM} ${RULE}
	@make -s -C Libft
	${CC} ${CFLAGS} ${INCLUDE} -o ${NAME} ${OBJS_BONUS} -L Libft_obj -lft
	@echo "\n${NAME} created"

%.o: %.c
	@${CC} ${CFLAGS} ${INCLUDE} -c $< -o $@
	@echo "\nObject files created"

clean:
	@${RM} ${OBJS} ${OBJS_BONUS} ${RULE} ${RULE_BONUS}
	@echo "\nObject files removed"
	@make fclean -s -C Libft

fclean: clean
	@${RM} ${NAME} here_doc
	@echo "\n${NAME} removed"

re: fclean all

tests:
	@rm -f infile infile.txt outfile outfile.txt no_permissions.txt
	@echo "\n\n$(GREEN)------NORM ERRORS------$(END)"
	@norminette | grep Error
	@echo "\n\n$(GREEN)------WITHOUT FILE PERMISSIONS------$(END)\n"
	@echo "a a a" > no_permissions.txt
	@chmod 000 no_permissions.txt
	@echo "./pipex no_permissions.txt \"grep a\" \"wc -w\" outfile.txt"
	@echo "\n Shell result:"
	@< no_permissions.txt grep a | wc -w > outfile.txt
	@rm -f no_permissions.txt outfile.txt
	@echo "a a a" > no_permissions.txt
	@chmod 000 no_permissions.txt
	@echo "\n Your result:"
	@./pipex no_permissions.txt "grep a" "wc -w" outfile.txt
	@echo "\n\n$(GREEN)------WITH FILE PERMISSIONS------$(END)\n"
	@echo "a a a" > permissions.txt
	@chmod 777 permissions.txt
	@echo "./pipex permissions.txt \"grep a\" \"wc -w\" outfile.txt"
	@echo "\n Shell result:"
	@< permissions.txt grep a | wc -w > outfile.txt
	@cat outfile.txt | cat -e
	@rm -f permissions.txt outfile.txt
	@echo "a a a" > permissions.txt
	@chmod 777 permissions.txt
	@echo "\n Your result:"
	@./pipex permissions.txt "grep a" "wc -w" outfile.txt
	@cat outfile.txt | cat -e
	@rm -f permissions.txt outfile.txt
	@echo "\n\n$(GREEN)------TEST N1------$(END)\n"
	@echo "./pipex infile.txt \"cat\" \"wc -l\" outfile.txt"
	@echo "\n$(YELLOW)WITHOUT INFILE$(END)\n"
	@echo "Shell result:"
	@< infile.txt cat | wc -l > outfile.txt
	@cat outfile.txt | cat -e
	@echo "Your result:"
	@./pipex infile.txt "cat" "wc -l" outfile.txt
	@cat outfile.txt | cat -e
	@echo "\n$(YELLOW)WITH INFILE$(END)\n"
	@echo "ola" > infile.txt
	@echo "Shell result:"
	@< infile.txt cat | wc -l > outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt
	@echo "Your result:"
	@./pipex infile.txt "cat" "wc -l" outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt
	@echo "\n\n$(GREEN)------TEST N2------$(END)\n"
	@echo "./pipex infile.txt \"grep a1\" \"wc -w\" outfile.txt\n"
	@echo "Shell result:"
	@< infile.txt grep a1 | wc -w > outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt
	@echo "Your result:"
	@./pipex infile.txt "grep a1" "wc -w" outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt infile.txt
	@echo "\n\n$(GREEN)------TEST N3------$(END)\n"
	@echo "./pipex infile.txt \"grep a1\" \"LOL -w\" outfile.txt\n"
	@echo "Shell result:"
	@< infile.txt grep a1 | LOL -w > outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt
	@echo "Your result:"
	@./pipex infile.txt "grep a1" "LOL -w" outfile.txt
	@cat outfile.txt | cat -e
	@rm -f outfile.txt

.PHONY: all clean fclean re bonus unit_tests

.IGNORE:

.SILENT:
