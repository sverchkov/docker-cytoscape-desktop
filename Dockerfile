FROM ubuntu:latest AS stage_packages

# Prevent prompts during installation
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y \
        # Utilities
        wget \
        dos2unix \
        # Java
        default-jdk \
        # XRDP
        xorgxrdp \
        xrdp \
        # Supervisor
        supervisor \
        # XFCE4
        xfce4 \
        xfce4-clipman-plugin \
        xfce4-cpugraph-plugin \
        xfce4-netload-plugin \
        xfce4-screenshooter \
        xfce4-taskmanager \
        xfce4-terminal \
        xfce4-xkb-plugin && \
    # Package cleanup
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists


FROM stage_packages AS stage_cytoscape

# PARAMETERS
ENV CYTOSCAPE_VERSION 3.9.1
# TODO: figure out correct way to infer from CYTOSCAPE_VERSION
ENV CYV 3_9_1
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

RUN wget https://github.com/cytoscape/cytoscape/releases/download/${CYTOSCAPE_VERSION}/Cytoscape_${CYV}_unix.sh && \
    chmod +x Cytoscape_${CYV}_unix.sh && \
    ./Cytoscape_${CYV}_unix.sh -q

FROM stage_cytoscape AS stage_user

# Configure supervisor
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure XRDP
RUN mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

# Create user
RUN useradd --create-home --shell /bin/bash user
RUN echo user:pwd | chpasswd

# Expose port for RDP
EXPOSE 3389

# Start services
CMD ["/usr/bin/supervisord"]
