# Docker Commands

Here are some useful example ways to run this application inside a docker container. Mainly used for running the Web API project locally to debug.

## Building the Container

``` bash
docker build -t postgrekeyrotation:v1 ../../PostGreKeyRotation
```

## Getting the Logs from the Application

``` bash
docker logs --follow postgrekeyrotation
```

## Removing the Running Docker Image

``` bash
docker rm postgrekeyrotation
```

## Running the Container Locally

``` bash
docker run -d -p 8080:80 --name postgrekeyrotation postgrekeyrotation:v1
```

## Stopping a Running Container

``` bash
docker stop postgrekeyrotation
```
