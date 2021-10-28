#!/usr/bin/env sh

set -e

RED="\033[0;31m"
CYAN="\033[0;36m"
BBLUE="\033[1;34m"
BYELLOW="\033[1;33m"
NC="\033[0m" #NO COLOR

start_services() {
    printf "${BBLUE}Starting development services...${NC}\n\n"
    docker-compose up -d
    docker-compose logs -f
}

stop_services() {
    printf "${BYELLOW}Stopping services...${NC}\n\n"
    docker-compose stop
}

teardown_services() {
    if [ -n "$2" ] && [ "$(echo "$2" | sed 's/RMI=//')" = "true" ]; then
        printf "${BYELLOW}Tearing down all services (containers, networks, volumes, built images)...${NC}\n\n"
        docker-compose down --rmi 'local' -v --remove-orphans
    else
        printf "${BYELLOW}Tearing down all services (containers, networks, volumes)...${NC}\n\n"
        docker-compose down -v --remove-orphans
    fi
}

stop_service() {
    if [ -z "$1" ]; then
        printf "${BYELLOW}Specify the service name.${NC}\n"
    else
        printf "${BYELLOW}Stopping $1 service...${NC}\n\n"
        docker-compose stop "$1"
        if [ -n "$2" ] && [ "$(echo "$2" | sed 's/RM=//')" = "true" ]; then
            printf "${BYELLOW}Removing $1 service...${NC}\n\n"
            docker-compose rm -v --force "$1"
        fi
    fi
}

rebuild_service() {
    if [ -z "$1" ]; then
        printf "${BYELLOW}Specify the service name.${NC}\n"
    else
        stop_service "$1"
        printf "${BBLUE}Rebuilding and starting $1 service...${NC}\n\n"
        docker-compose up --build -d --no-deps --renew-anon-volumes "$1"
        docker-compose logs -f
    fi
}

list_services() {
    printf "${BBLUE}Listing all services...${NC}\n\n"
    docker-compose ps -a
}

build_services() {
    teardown_services RMI=true
    printf "${BBLUE}Creating and starting production services...${NC}\n\n"
    docker-compose -f docker-compose.yml docker-compose.prod.yml up --build -d
    docker-compose logs -f
}

pause() {
    if [ -n "$1" ]; then
        printf "${BYELLOW}Pausing $1 service...${NC}\n\n"
        docker-compose pause "$1"
    else
        printf "${BYELLOW}Pausing all services...${NC}\n\n"
        docker-compose pause
    fi
}

exec_into() {
    if [ -z "$1" ]; then
        printf "${BYELLOW}Specify at least the container name you want to run the command on.${NC}\n\n"
        printf "${BYELLOW}Example:${NC} ./run.sh exec_into ${CYAN}express_backend${NC}\n"
    else
        printf "${BYELLOW}Executing into the specified container...${NC}\n\n"
        docker exec -it "$@" /usr/bin/env sh
    fi
}

case $1 in
ls)
    list_services
    exit
    ;;
start)
    export COMPOSE_DOCKER_CLI_BUILD=1
    export DOCKER_BUILDKIT=1
    start_services
    exit
    ;;
stop)
    stop_services
    exit
    ;;
teardown)
    teardown_services "$@"
    exit
    ;;
stop_service)
    "$@"
    exit
    ;;
rebuild_service)
    export COMPOSE_DOCKER_CLI_BUILD=1
    export DOCKER_BUILDKIT=1
    "$@"
    exit
    ;;
build)
    export COMPOSE_DOCKER_CLI_BUILD=1
    export DOCKER_BUILDKIT=1
    build_services
    exit
    ;;
pause)
    "$@"
    exit
    ;;
exec_into)
    "$@"
    exit
    ;;
*)
    if [ -n "$1" ]; then
        printf "${CYAN}$1${NC} ${RED}is not a supported command.${NC}\n"
    else
        printf "${RED}Please specify a command.${NC}\n"
    fi
    exit 1
    ;;
esac