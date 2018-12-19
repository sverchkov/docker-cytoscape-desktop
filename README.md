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
### Run container
```
docker rm -f cy; docker run --name cy \
  -v /Users/user/output:/home/seluser/cytoscape/output \
  -p 5900:5900 -p 1234:1234 -p 8080:8080 -p 6080:6080 \
  -e no_proxy=localhost \
  -e HUB_ENV_no_proxy=localhost \
  -e SCREEN_WIDTH=1270 -e SCREEN_HEIGHT=700 \
  -e VNC_NO_PASSWORD=1 \
  cannin/cytoscape-desktop \
  sh -c '/opt/bin/entry_point.sh & sh /home/seluser/cytoscape/start.sh & /home/seluser/noVNC/utils/launch.sh --vnc localhost:5900'
```

Files saved in '/home/seluser/cytoscape/output' are accessible on the host system at '/Users/user/output'

### Run interactive session
```
docker exec -it cy bash
```

## VNC
### RealVNC
Connect with VNC (https://www.realvnc.com/download/viewer/) using the URL below:

* URL: localhost:5900
* Default password: secret

Additionally, the VNC viewer is available as a Chrome extension:

https://chrome.google.com/webstore/detail/vnc%C2%AE-viewer-for-google-ch/iabmpiboiopbgfabjmgeedhcmjenhbla?hl=en

and accessible via this link in Chrome:

chrome://apps/

### noVNC
Built-in web-based VNC accessible at: http://localhost:6080/vnc.html?host=localhost&port=6080

### TightVNC
Use TightVNC if having problems with right click on MacOS with noVNC and RealVNC: https://www.tightvnc.com/download.php

#### Running Java-Based TightVNC Client
```
java VncViewer HOST localhost PORT 5900
```
