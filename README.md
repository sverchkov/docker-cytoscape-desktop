# Cytoscape Desktop in a Docker Image

Cytoscape Desktop in Docker image with GUI running using xvfb and VNC server

![cytoscape_desktop](cytoscape_desktop.png)

## Notes

This Docker image is built on top of the selenium/standalone-chrome-debug image.

https://hub.docker.com/r/selenium/standalone-chrome-debug/

# Build
```
docker build -t cannin/cytoscape-desktop .
```

# Run

## Docker
```
docker rm -f cy; docker run --name cy -p 5900:5900 -p 1234:1234 -e no_proxy=localhost -e HUB_ENV_no_proxy=localhost cannin/cytoscape-desktop sh -c '/opt/bin/entry_point.sh & sh /home/seluser/cytoscape/start.sh'
```

## VNC

Connect with VNC (https://www.realvnc.com/download/viewer/) at localhost:5900

* Default password: secret
