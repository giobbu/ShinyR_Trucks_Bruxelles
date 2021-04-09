# Shiny apps for trucks movements visualizations

## Docker Image
Docker is a software container platform, which allows to isolate OS environments. 

* Get started with Docker tutorial: https://docs.docker.com/get-started

### 0. Pull Image
The image is called ```mobitrucks ``` and is available from DockerHub.
To install the image, use the standard ```docker pull``` command 
```
docker pull giobbu/mobitrucks
```

### 1. Start Container
Start the container with
```
docker run -p 3838:3838 -it giobbu/mobitrucks bash

```
```
shiny-server

```
open shiny apps in browser at http://localhost:3838 
