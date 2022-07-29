SRC = ./srcs/docker-compose.yml
NAME = Inception

all: $(NAME)

$(NAME):
	mkdir -p /home/lberrada/data/website
	mkdir -p /home/lberrada/data/mariadb
	#mkdir -p /home/lberrada/data/data_2
	docker-compose -f ${SRC} up --build -d 

clean:
	docker-compose -f ${SRC} stop

fclean: clean
	docker-compose -f ${SRC} down


prune: fclean
	docker image prune -a
	docker volume rm srcs_mariadb
	docker volume rm srcs_website

data:
	sudo rm -rf /home/lberrada/data

re: fclean all

setup:
	sudo chmod 777 /var/run/docker.sock
	echo "127.0.0.1 lberrada.42.fr" | sudo tee -a /etc/hosts

.PHONY: all clean flcean re data setup
