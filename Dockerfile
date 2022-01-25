FROM ubuntu:20.04

# PARAMETERS
ENV CYTOSCAPE_VERSION 3.9.1

# Prevent prompts during installation
ENV DEBIAN_FRONTEND noninteractive

# CHANGE USER
USER root

# INSTALL DEPENDENCIES
RUN apt-get update -y && \
    apt-get -y install default-jdk libxcursor1 xvfb supervisor wget x11vnc xrdp

# Tweak XRDP configuration
RUN sed -i 's/3389/5900/g' /etc/xrdp/xrdp.ini && \
    sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini && \
    sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini

# INSTALL CYTOSCAPE
RUN wget https://github.com/cytoscape/cytoscape/releases/download/${CYTOSCAPE_VERSION}/cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && \
    tar xf cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && rm cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && \
    mv cytoscape-unix-${CYTOSCAPE_VERSION} cytoscape

# Set JAVA_HOME From sudo update-alternatives --config java
RUN echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' >> /etc/environment

# Set cytoscape install dir in supervisord
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 1234 5900
CMD ["/usr/bin/supervisord"]
