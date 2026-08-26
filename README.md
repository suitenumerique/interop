# Interop: interoperability resources for LaSuite

A repository dedicated to interoperabilities for LaSuite (docs, development
resources, tools, etc.)

## Local Development (for contributors)

Run services locally for development and testing.

> [!WARNING]
> This setup is intended **for development and testing only**.

### Prerequisites

- Docker
- Docker Compose
- GNU Make

Verify installation:

```bash
docker -v
docker compose version
```

> If you encounter permission errors, you may need to use `sudo`, or add your
> user to the `docker` group.

### Bootstrap the project

The easiest way to start is using GNU Make:

```bash
make bootstrap
```

Start services:

```bash
make run
```

All services should be up and running. You can test services with development
credentials by opening the following links with your favorite browser:

| service         | URL                                    | field    | value      |
| --------------- | -------------------------------------- | -------- | ---------- |
| Keycloak        | http://keycloak.lasuite.localhost:8004 | username | `admin`    |
|                 |                                        | password | `admin`    |
| Minio (console) | http://minio.lasuite.localhost:8002    | username | `lasuite`  |
|                 |                                        | password | `password` |

You can stop running services using:

```bash
make stop
```

… and remove containers and networks using:

```bash
make down
```

## License 📝

This work is released under the MIT License (see
[LICENSE](https://github.com/suitenumerique/interop/blob/main/LICENSE)).

While this project is a public-driven initiative, our license choice is an
invitation for private sector actors to use, sell and contribute to it.
