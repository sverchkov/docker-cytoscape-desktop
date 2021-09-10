# Cytoscape Desktop in a Docker Image

Cytoscape Desktop in Docker image with GUI running using xvfb and VNC server

![cytoscape_desktop](cytoscape_desktop.png)

This Docker image is built on top of the ubuntu:20.04 image.

https://hub.docker.com/_/ubuntu

Cytoscape content at DockerHub can be found here:

https://hub.docker.com/u/cytoscape

# Build
Clone this repo, cd into it and build the container yourself
```
docker build -t cytoscape/cytoscape-desktop .
```

# Run
## Launch Cytoscape in Docker
In a local terminal window, issue the following commands to run this docker container and launch Cytoscape:
```
docker run -p 1234:1234 -p 5900:5900 cytoscape/cytoscape-desktop
```

### VNC
#### RealVNC
Connect with VNC (https://www.realvnc.com/download/viewer/) using the URL below:

* URL: localhost:5900

No password is required.
