FROM localhost:5000/dh_cms_base:latest

# client port (2181/tcp), peer connection port (2888/tcp), leader election port (3888/tcp)
EXPOSE 2181 2888 3888

RUN mkdir /app
RUN mkdir -p /external/logs
RUN mkdir -p /external/data

WORKDIR /app
RUN git clone https://github.com/conquernos/dh_cms_zookeeper.git

WORKDIR /app/cms_zookeeper
ARG project
RUN ./build $project

WORKDIR /app
RUN rm -rf /app/cms_zookeeper

CMD /app/cms-zookeeper/bin/server start
