FROM 172.19.32.40:5000/cms_base:latest

EXPOSE 9180 9987

RUN mkdir /app
RUN mkdir -p /external/logs

WORKDIR /app
RUN git clone https://github.com/conquernos/cms_proxy.git

WORKDIR /app/dh_cms_proxy
ARG project
RUN ./build $project

WORKDIR /app
RUN rm -rf /app/dh_cms_proxy

CMD /app/cms-proxy/bin/server start
