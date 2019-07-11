# Installation
A brief of what install script will do:

* Install **smartcd** if not installed (will be prompted for configuration. Just leave all options by default).
* Installs a traefik service (at `/usr/local/bin/dk_traefik`).  
* Installs `dk` cli.

To install dockerizer run ( depending on your system configuration):
```bash

bash <(curl -s https://raw.githubusercontent.com/frontid/dockerizer/master/install.sh)

OR

bash <(wget -O - https://raw.githubusercontent.com/frontid/dockerizer/master/install.sh)

dk start traefik
```

# Configure a new project
Dockerizer works on a high level of your project and the first step is to clone it on your projects dir:

```bash
dk new myproject_dockerized
cd myproject_dockerized
git clone git@github.com:YOU/YOUR-PROJECT.git web
```

Next you need "dockerize" a project. To accomplish that the only thing you need to do is  create `.docker.env` and commit the preferences on the file.  
Dockerizer provides you an example. Copy `example.docker.env` as `.docker.env` at your "web" dir and configure it (See **[.docker.env](/dockerenv)** documentation for a more detailed explanation). 
We provide a basic.docker.env for impatient people, where you only have to change PROJECT_NAME to suit your needs.
That's all, now run `dk start` and happy coding!

# Run a configured project
If your project already has `.docker.env` pushed on your project follow these steps.

```bash
dk new myproject_dockerized
cd myproject_dockerized
git clone git@github.com:YOU/YOUR-PROJECT.git web
dk start
```

