FROM selenium/standalone-chrome-debug:3.13.0

# Install Java
USER root
RUN apt-get update
RUN apt-get -yqq install default-jdk

# Set JAVA_HOME From sudo update-alternatives --config java
RUN echo '/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java' >> /etc/environment

# Cytoscape Retrieval
USER seluser

RUN mkdir /home/seluser/cytoscape
WORKDIR /home/seluser/cytoscape
RUN wget -nv http://chianti.ucsd.edu/cytoscape-3.6.1/cytoscape-3.6.1.tar.gz -O cytoscape-3.6.1.tar.gz

RUN tar -zxvf cytoscape-3.6.1.tar.gz
RUN rm cytoscape-3.6.1.tar.gz

# To launch it:
RUN echo '/home/seluser/cytoscape/cytoscape-unix-3.6.1/cytoscape.sh - R 1234' > /home/seluser/cytoscape/start.sh

CMD /home/seluser/cytoscape/start.sh
