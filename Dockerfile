FROM ubuntu:latest

# PARAMETERS
ENV CYTOSCAPE_VERSION 3.9.1

# Prevent prompts during installation
ENV DEBIAN_FRONTEND noninteractive

# CHANGE USER
USER root

RUN apt-get -y update 
RUN apt-get -y upgrade

# INSTALL XFCE4
RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin

# INSTALL UTILITIES
RUN apt-get install -y \
    sudo \
    wget \
    xorgxrdp \
    xrdp \
    dos2unix \
    default-jdk && \
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

COPY ./run.sh /usr/bin/
RUN dos2unix /usr/bin/run.sh && \
    chmod +x /usr/bin/run.sh

# Set JAVA_HOME From sudo update-alternatives --config java
RUN echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' >> /etc/environment

# INSTALL CYTOSCAPE
RUN wget https://github.com/cytoscape/cytoscape/releases/download/${CYTOSCAPE_VERSION}/cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && \
    tar xf cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && rm cytoscape-unix-${CYTOSCAPE_VERSION}.tar.gz && \
    mv cytoscape-unix-${CYTOSCAPE_VERSION} cytoscape

# Set cytoscape install dir in supervisord
#COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3389
#CMD ["/usr/bin/supervisord"]
ENTRYPOINT ["/usr/bin/run.sh"]