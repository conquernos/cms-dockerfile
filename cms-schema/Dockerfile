FROM localhost:5000/dh_cms_base:latest

EXPOSE 9181 9985

RUN mkdir /app
RUN mkdir -p /external/logs

WORKDIR /app
RUN git clone https://github.com/conquernos/cms_schema.git

WORKDIR /app/cms_schema
ARG project
RUN ./build $project

WORKDIR /app
RUN rm -rf /app/cms_schema

CMD /app/cms-schema/bin/server start
