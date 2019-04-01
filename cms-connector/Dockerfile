FROM localhost:5000/dh_cms_base:latest

EXPOSE 9183 9986

RUN mkdir /app
RUN mkdir -p /external/logs

WORKDIR /app
RUN git clone https://github.com/conquernos/cms_connector.git

WORKDIR /app/cms_connector
ARG project
RUN ./build $project

ARG user
RUN useradd $user

WORKDIR /app
RUN rm -rf /app/cms_connector

CMD /app/cms-connector/bin/server start
