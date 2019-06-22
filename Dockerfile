FROM ubuntu:16.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates
RUN echo "deb http://download.mono-project.com/repo/ubuntu stable-wheezy/snapshots/4.6.2.7 main" | tee /etc/apt/sources.list.d/mono-official.list
RUN apt-get update && apt-get install -y -q screen tzdata mono-complete ca-certificates-mono  \
           && rm -rf /var/lib/apt/lists/* /tmp/*
RUN echo America/Los_Angeles > /etc/timezone \
    && rm -f /etc/localtime \
    && ln -snf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

EXPOSE 8002/tcp 8008/tcp 9000/tcp 9001/tcp 9002/tcp 9003/tcp
EXPOSE 9000/udp 9001/udp 9002/udp 9003/udp
WORKDIR /opt/opensim/bin

CMD [ "./autostart.sh" ]
