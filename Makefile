# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ancolmen <ancolmen@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/21 14:38:30 by ancolmen          #+#    #+#              #
#    Updated: 2024/02/21 17:55:29 by ancolmen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#######	VARIABLES #######

USER = ancolmen
NAME = Inception

SRCS_PATH = ./srcs/
VOLUMES_PATH = /home/$(USER)/data

MDB_NAME = mariadb
WP_NAME = wordpress
#OTHERSERVICES_NAME bonus

#######	COLORS #######

WHITE = \033[97;4m
GREEN = \033[32;1m
YELLOW = \033[33;1m
RED = \033[31;1m
CEND = \033[0m

#######	RULES #######

all : volumes up
	@ echo "\n$(GREEN)★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★$(CEND)\n"
	@ echo "\n$(GREEN)★ Welcome to $(NAME) ★$(CEND)\n"
	@ echo "\n$(WHITE)	nginx set $(CEND)\n"
	@ echo "\n$(WHITE)	mariadb set $(CEND)\n"
	@ echo "\n$(WHITE)	wordpress is running at $(NAME).42.fr$(CEND)\n"
	@ echo "$(GREEN)★ Everything is running smoothly ★$(CEND)\n"
	@ echo "\n$(GREEN)★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★$(CEND)\n"

volumes :
	@ echo "\n$(YELLOW)★ Creating Docker Volumes ★$(CEND)\n"
	sudo mkdir -p $(VOLUMES_PATH)/$(MDB_NAME)
	sudo chmod 755 $(VOLUMES_PATH)/$(MDB_NAME)
	sudo mkdir -p $(VOLUMES_PATH)/$(WP_NAME)
	sudo chmod 755 $(VOLUMES_PATH)/$(WP_NAME)
	@ echo "$(GREEN)★ Volumes OK ★$(CEND)\n"

up :
	@ echo "\n$(YELLOW)★ Launching Docker ★$(CEND)\n"
	@ sudo docker --version
	@ echo "\n$(WHITE) A self-sufficient runtime for containers$(CEND)\n"
	sudo docker compose -f $(SRCS_PATH)docker-compose.yml up -d --build
	@ echo "\n$(GREEN)★ Images Ready ★$(CEND)\n"

down :
	@ echo "\n$(YELLOW)★ Stopping Docker ★$(CEND)\n"
	sudo docker compose -f $(SRCS_PATH)docker-compose.yml down
	@ echo "\n$(GREEN)★ Docker stopped ★$(CEND)\n"

clean : stop
	@ echo "\n$(YELLOW)★ Cleaning Volumes ★$(CEND)\n"
	sudo docker volume rm $(WP_NAME) $(MDB_NAME)
	sudo rm -rf $(VOLUMES_PATH)
	sudo docker system prune -af
	sudo docker volume prune -af
#	sudo docker volume rm bonus
	@ echo "\n$(GREEN)★ Volumes cleaned ★$(CEND)\n"

re : clean all

.PHONY: all volumes up stop clean re