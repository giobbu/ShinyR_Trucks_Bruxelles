# Shiny apps for trucks movements visualizations

## MOBIAID DEMO Dashboard

<!-- Add a horizontal line before the image -->
<hr>

<!-- Insert the image with a specified width using HTML -->
<img src="visualizations/vis.png" alt="Image Alt Text" width="1000px">

<!-- Add a horizontal line after the image -->
<hr>
<!-- Add a horizontal line before the image -->
<hr>

<!-- Insert the image with a specified width using HTML -->
<img src="visualizations/vis1.png" alt="Image Alt Text" width="1000px">

<!-- Add a horizontal line after the image -->
<hr>
<!-- Add a horizontal line before the image -->
<hr>

<!-- Insert the image with a specified width using HTML -->
<img src="visualizations/vis2.png" alt="Image Alt Text" width="1000px">

<!-- Add a horizontal line after the image -->
<hr>

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
