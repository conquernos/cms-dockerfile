FROM openjdk:8

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y software-properties-common apt-utils locales tzdata

RUN echo "tzdata tzdata/Areas select Asia" > timezone.txt
RUN echo "tzdata tzdata/Zones/Asia select Seoul" >> timezone.txt
RUN debconf-set-selections timezone.txt
RUN rm /etc/timezone
RUN rm /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
