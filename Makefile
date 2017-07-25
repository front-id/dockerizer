# This Makefile is aimed to help start quickly preparing a development sandbox to run drupal under docker4drupal 
# transparently.
#
# Make sure an html folder exists in the root folder before running the create task
#
# It is recommended to install smartcd (https://github.com/cxreg/smartcd) for this purpose.
# Check README for usage

# Drupal project name used to create the URLs for the project (NAME.docker.localhost:8000)
NAME=drupal

CACHE_FILE=.project

ifeq ($(shell test -e $(CACHE_FILE) && echo -n yes),yes)
	NAME=$$(grep '^NAME=' .project | cut -d= -f2-)
else
	NAME=drupal
endif

export NAME

CURRENT_USER=$(shell id -u)

# Saves the project name into a file so it can be reloaded without specifying it everytime
cache-set:
	@echo "NAME=${NAME}" > .project

# The site will need to be running under the NAME specified by parameter. 
# Modify the docker-compose so the new url will look like NAME.docker.localhost:8000
prepare-docker:
	sed -i "s/projectname/$(NAME)/g" docker/docker-compose.yml && sed -i "s/projectname/$(NAME)/g" docker/.env

# Prepare the docker installation with the boilerplate branch
clone-docker:
	@echo "Creating docker repo" && git clone git@github.com:nicobot/docker4drupal.git --branch boilerplate --single-branch docker

update-docker:
	@echo "Updating docker" && cd docker && git checkout -f && git pull origin boilerplate

# Storage folder will save the mysql data
# mariadb-init will store dump files
create-storage:
	mkdir -p storage && mkdir -p mariadb-init

# The project needs to have the drupal code under html folder
# if it doesn't exist we'll create it
create-html-folder:
	mkdir -p html

# Bring up docker
docker-start:
	./bin/dc up -d

# Stop docker instances
docker-stop:
	./bin/dc stop

update-permissions:
	setfacl -dRm u:$(CURRENT_USER):rwX -dRm u:21:rX -dRm u:82:rwX . && setfacl -Rm u:$(CURRENT_USER):rwX -Rm u:21:rX -Rm u:82:rwX .

prepare-smartcd-if-available:
	if [ -f ~/.smartcd_config ]; then echo "autostash PATH=$(PWD)/bin:\$$PATH" | ~/.smartcd/bin/smartcd edit enter; fi

# Changing directory will trigger smartcd to load new PATH
change-dir:
	cd .

create: cache-set prepare-smartcd-if-available change-dir clone-docker prepare-docker create-storage create-html-folder update-permissions docker-start

update: cache-set docker-stop change-dir update-docker prepare-docker create-storage create-html-folder update-permissions docker-start

up: docker-stop docker-start

stop: docker-stop

mount-drupal-project:
	git clone git@github.com:nicobot/drupal-project.git --branch master --single-branch drupal && ln -s drupal/web html
