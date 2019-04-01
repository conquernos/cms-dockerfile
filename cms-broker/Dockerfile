FROM localhost:5000/cms_base:latest

EXPOSE 9092 9984

RUN mkdir /app
RUN mkdir -p /external/logs
RUN mkdir -p /external/data

WORKDIR /app
RUN git clone https://github.com/conquernos/cms_broker.git

WORKDIR /app/cms_broker
ARG project
RUN ./build $project

WORKDIR /app
RUN rm -rf /app/cms_broker

CMD /app/cms-broker/bin/server start
