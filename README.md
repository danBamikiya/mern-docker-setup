<h1 id="header">HOW TO USE</h1>

*This setup has Docker BuildX enabled that means faster builds (using parallel builds) than the default and better caching of your builds!*

Easy!

#### Clone the app

```
git clone https://github.com/danBamikiya/mern-docker-setup.git
```

#### Navigate to the cloned directory

```
cd mern-docker-setup
```

1. Just put the contents of your react folder into the `frontend` folder.
2. Put the content of your express folder into the `backend` folder.
3. Then replace the [database name](https://github.com/danBamikiya/mern-docker-setup/blob/b26f7ef819c1e448f99af6c29827329dbf441cba/docker-compose.yml#L39) with your preferred name.
4. Then use the MongoDB connection URI in your backend as `mongodb://mongo:27017/databasename`

<h1>HOW TO RUN</h1>

<h3> 🌱 Prerequisites </h3>

- [Docker with Docker Compose](https://docs.docker.com/get-docker/)

Has been tested on Windows 10 and Linux (Ubuntu 20.04.2 LTS).

You can either work with this project either in Windows, Linux or MacOS. I'll differentiate each environment's working commands in the README with a table like this one:

| Action          | Windows               | Linux/MacOS               |
| :-------------- | :-------------------- | :------------------------ |
| _action to run_ | _command for windows_ | _command for linux/macOS_ |

## 🏁 Getting started

#### Commands

All commands are run from the root of the project, from a terminal:

🛎️ **IMPORTANT**: For Windows users, make sure to run the following command in your terminal before running any of the windows commands:

```ps1
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

> The command above will [enable](https://go.microsoft.com/fwlink/?LinkID=135170) the PowerShell script to run in your **current** PowerShell terminal without your terminal throwing a security error.

For Linux/MacOS users, you might need to enable the Shell script run like so:

```sh
chmod +x ./run.sh
```

| Action                                                                                                                 | Windows                                                                                       | Linux/MacOS                                                                                  |
| :--------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- |
| Build and start all development services                                                                      | `.\run.ps1 Start`                                                                             | `./run.sh start`                                                                             |
| List all services                                                                                             | `.\run.ps1 LS`                                                                                | `./run.sh ls`                                                                                |
| Stop all services without removing them                                                                       | `.\run.ps1 Stop`                                                                              | `./run.sh stop`                                                                              |
| Stop a service without removing it                                                                            | `.\run.ps1 Stop-Service *name_of_service*`                                                    | `./run.sh stop_service *name_of_service*`                                                    |
| Stop a service and remove it                                                                                  | `.\run.ps1 Stop-Service *name_of_service* -RM`                                                | `./run.sh stop_service *name_of_service* RM=true`                                            |
| Pause all services                                                                                            | `.\run.ps1 Pause`                                                                             | `./run.sh pause`                                                                             |
| Pause a service                                                                                               | `.\run.ps1 Pause *name_of_service*`                                                           | `./run.sh pause *name_of_service*`                                                           |
| Teardown(stop & remove containers, networks & volumes) all services without removing the built images         | `.\run.ps1 Teardown`                                                                          | `./run.sh teardown`                                                                          |
| Teardown(stop & remove containers, networks, volumes & built images) all services and remove the built images | `.\run.ps1 Teardown -RMI`                                                                     | `./run.sh teardown RMI=true`                                                                 |
| Rebuild and restart a service                                                                                 | `.\run.ps1 Rebuild-Service *name_of_service*`                                                 | `./run.sh rebuild_service *name_of_service*`                                                 |
| Build and start all production services                                                                       | `.\run.ps1 Build`                                                                             | `./run.sh build`                                                                             |
| Execute into a service(container)                                                                             | `.\run.ps1 Exec-Into *container_name_of_the_service* *other options you may want to provide*` | `./run.sh exec_into *container_name_of_the_service* *other options you may want to provide*` |

### 📑 NOTE:

> When executing into a service, you provide the [container name of the service](./docker-compose.yml) not the service's name.

> Also the execute command is executed as:
> | Windows | Linux/MacOS |
> | :-------------------------------------- | :----------------------------------- |
> | `docker exec -it $Args /usr/bin/env sh` | `docker exec -it "$@" /usr/bin/env sh` |
>
> So you don't need to provide the shell to run the command in. Just the [container name of the service](./docker-compose.yml) and any other [options](https://docs.docker.com/compose/reference/exec/) you need.


<div align="right">
    <b><a href="#header">↥ Back To Top</a></b>
</div>
