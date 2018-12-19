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
docker rm -f cy; docker run --name cy -v /Users/user/output:/home/seluser/cytoscape/output -p 5900:5900 -p 1234:1234 -e no_proxy=localhost -e HUB_ENV_no_proxy=localhost -e SCREEN_WIDTH=1280 -e SCREEN_HEIGHT=800 cannin/cytoscape-desktop sh -c '/opt/bin/entry_point.sh & sh /home/seluser/cytoscape/start.sh'
```

Files saved in '/home/seluser/cytoscape/output' are accessible on the host system at '/Users/user/output'

### Run interactive session
```
docker exec -it cy bash
```

## VNC

Connect with VNC (https://www.realvnc.com/download/viewer/) using the URL below:

* URL: localhost:5900
* Default password: secret

Additionally, the VNC viewer is available as a Chrome extension:

https://chrome.google.com/webstore/detail/vnc%C2%AE-viewer-for-google-ch/iabmpiboiopbgfabjmgeedhcmjenhbla?hl=en

and accessible via this link in Chrome:

chrome://apps/
