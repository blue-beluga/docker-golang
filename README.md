
# [<img src=".bluebeluga.png" height="100" width="200" style="border-radius: 50%;"/>](https://github.com/blue-beluga/docker-golang) bluebeluga/golang

The Go programming language, on Docker.

## Installation and Usage

```
docker pull bluebeluga/golang
docker run bluebeluga/golang [options]
```

## Available Tags

* `latest`: Currently Go 1.6.2
* `1.5.4` (aliased as `go-1.5.4`): go version go1.6.2 linux/amd64
* `1.6` (aliased as `go-1.6`): go version go1.6.2 linux/amd64
* `1.6.1` (aliased as `go-1.6.1`):   go version go1.6.2 linux/amd64
* `1.6.2` (aliased as `go-1.6.2`):   go version go1.6.2 linux/amd64

## Tests

Tests are run as part of the `Dockerfile` build. To execute them separately within a container, run:

```
bats test
```

Or during the build process using the following command:

```
make test
```

## Deployment

To push the Docker image to the registry, run the following command:

```
make push
```
