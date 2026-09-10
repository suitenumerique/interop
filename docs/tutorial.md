# Tutorial

The aim of this tutorial is to drive you through the process of integrating
your service in the LaSuite development stack, ensuring people from LaSuite
will be able to work on interoperabilities with your service.

## Integrate core services

Auxiliary services are meant to be handled by the `interop` repository and
integrated in your service. Hence, to fetch configuration files, you need to
add the following example rule to your `Makefile`:

```Makefile
# -- Interop
INTEROP_URL = https://github.com/suitenumerique/interop/archive/refs/heads/main.tar.gz

interop:
	mkdir -p interop
	curl -sL $(INTEROP_URL) | tar -xzf - --strip-components=1 -C interop
	cd interop && make bootstrap
```

Alternatively you can Git-pull the repository if `curl` is not installed nor
usable in your system:

```Makefile
# -- Interop
INTEROP_REPO = git@github.com:suitenumerique/interop.git
# or if you are not using SSH to clone repositories
INTEROP_REPO = https://github.com/suitenumerique/interop.git

interop:
	git clone --depth 1 $(INTEROP_REPO)
	cd interop && make bootstrap
```

Running `make interop` now creates the `interop` folder in your project.

Next, you will need to remove auxiliary services from your Docker compose
configuration and include the `interop` configuration:

```yaml
# compose.yaml
name: lasuite

include:
  - interop/compose.yml
```

Note that the name of your compose configuration should be `lasuite`. This
ensure that all services belong to the same namespace.

Service definitions that need to be removed are:

- `crowdin`
- `mailcatcher`
- `minio`
- `keycloak`
- `keycloak-postgresql`
- `redis`

The `interop` compose configuration also creates a dedicated network for
LaSuite services (named `lasuite`). If your service has already defined such
service, you will need to delete it (and eventually also remove the Makefile
rules that may create it).

## Update services exposed ports (and URLs)

To avoid conflicts between exposed service ports (from the host), we've
pre-defined a recommended list of ports (and URLs) for every service from
LaSuite projects. You will find their definition in the
[implementation](./implementation.md) section.

This means that you will need to update the Docker compose configuration of
your project, but also services local configuration for development (think of
environment variables such as `DJANGO_ALLOWED_HOSTS`).

And finally, your CI configuration will also need to be updated.
