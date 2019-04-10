# TheRealWorld Vapor
A Real World REST API Example in Vapor
## Development Machine Specs
* MacOS Mojave 10.14.*
* [Vapor](https://docs.vapor.codes/3.0/install/macos/)
* [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
* [Kitura](https://www.kitura.io/app.html)

## Setup Project
### Setup Database
`docker pull postgres `

and start the server with

```
docker run --name therealworld_vapor -e POSTGRES_DB=therealworld_vapor \
  -e POSTGRES_USER=vapor -e POSTGRES_PASSWORD=password \
  -p 5432:5432 -d postgres
```
