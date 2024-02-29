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
NG_NAME = nginx

MDB_IMG = $(shell docker images | grep mariadb | wc -l)
WP_IMG = $(shell docker images | grep wordpress | wc -l)
NG_IMG = $(shell docker images | grep nginx | wc -l)

MDB_VOL = $(shell docker volume ls | grep mariadb | wc -l)
WP_VOL = $(shell docker volume ls | grep wordpress | wc -l)

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
	@ echo "\n$(GREEN)★ Welcome to $(NAME) ★$(CEND)"
	@ echo "\n$(WHITE)	nginx set $(CEND)"
	@ echo "\n$(WHITE)	mariadb set $(CEND)"
	@ echo "\n$(WHITE)	wordpress is running at ancolmen.42.fr$(CEND)"
	@ echo "$(GREEN)★ Everything is running smoothly ★$(CEND)\n"
	@ echo "\n$(GREEN)★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★$(CEND)"

volumes :
	@ echo "\n$(YELLOW)★ Creating Docker Volumes ★$(CEND)"
	@ if [ ! -d "/home/ancolmen/data" ]; \
	then \
		sudo mkdir -p $(VOLUMES_PATH)/$(MDB_NAME); \
		sudo chmod 777 $(VOLUMES_PATH)/$(MDB_NAME); \
		sudo mkdir -p $(VOLUMES_PATH)/$(WP_NAME); \
		sudo chmod 777 $(VOLUMES_PATH)/$(WP_NAME); \
	else \
		echo "	Volumes already created"; \
	fi;
	@ echo "$(GREEN)★ Volumes OK ★$(CEND)\n"

up :
	@ echo "\n$(YELLOW)★ Launching Docker ★$(CEND)"
	@ sudo docker --version
	@ echo "$(WHITE) A self-sufficient runtime for containers$(CEND)"
	sudo docker compose -f $(SRCS_PATH)docker-compose.yml up -d --pull never
	@ echo "$(GREEN)★ Images Ready ★$(CEND)\n"

down :
	@ echo "\n$(YELLOW)★ Stopping Docker ★$(CEND)"
	sudo docker compose -f $(SRCS_PATH)docker-compose.yml down
	@ echo "$(GREEN)★ Docker stopped ★$(CEND)\n"

re_mdb: down volumes
	@ sudo docker rmi $(MDB_NAME):42
	@ sudo docker volume rm $(MDB_NAME)
	@ sudo docker compose -f $(SRCS_PATH)docker-compose.yml up -d --pull never

re_wp: down volumes
	@ sudo docker rmi $(WP_NAME):42
	@ sudo docker volume rm $(WP_NAME)
	@ sudo docker compose -f $(SRCS_PATH)docker-compose.yml up -d --pull never

re_ng: down volumes
	@ sudo docker rmi $(NG_NAME):42
	@ sudo docker compose -f $(SRCS_PATH)docker-compose.yml up -d --pull never

clean : down
	@ echo "\n$(YELLOW)★ Cleaning Volumes ★$(CEND)"

	@ if [ $(MDB_IMG) = "1" ]; then sudo docker rmi $(MDB_NAME):42; \
	else echo "	MDB Image already deleted"; fi;
	@ if [ $(WP_IMG) = "1" ]; then sudo docker rmi $(WP_NAME):42; \
	else echo "	WP Image already deleted"; fi;
	@ if [ $(NG_IMG) = "1" ]; then sudo docker rmi $(NG_NAME):42; \
	else echo "	NG Image already deleted"; fi;

	@ if [ $(MDB_VOL) = "1" ]; then sudo docker volume rm $(MDB_NAME); \
	else echo "	MDB Volume already deleted"; fi;
	@ if [ $(WP_VOL) = "1" ]; then sudo docker volume rm $(WP_NAME); \
	else echo "	WP Volume already deleted"; fi;

	sudo docker system prune -af
	sudo docker volume prune -f

	@ echo "$(GREEN)★ Volumes cleaned ★$(CEND)\n"

fclean : clean
	sudo rm -rf $(VOLUMES_PATH)
	
re : fclean all

.PHONY: all volumes up down clean fclean re re_mdb re_ng re_wp