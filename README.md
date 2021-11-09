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
git clone https://github.com/cytoscape/docker-cytoscape-desktop
cd docker-cytoscape-desktop
git checkout -t origin/simplify
docker build -t cytoscape/cytoscape-desktop .
```

# Run
## Launch Cytoscape in Docker
In a local terminal window, issue the following commands to run this docker container and launch Cytoscape:
```
docker run -p 1234:1234 -p 5900:5900 cytoscape/cytoscape-desktop
```

### VNC
#### UltraVNC viewer
Connect with UltraVNC viewer (http://www.uvnc.com/) using the URL below:

* URL: localhost:5900

No password is required.

https://user-images.githubusercontent.com/12192/133522202-d2be5f77-488a-436e-a981-71b69a20398e.mp4

