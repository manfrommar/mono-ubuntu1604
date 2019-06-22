# mono-ubuntu1604
mono with screen based on ubuntu 16.04 (for run opensim on mono 4.6.2.7). mono 4.6.2.7 works for opensim and https ssl , as other higher versions are not working anymore. 

it will put opensim to screen as setup in /opt/opensim/bin/autostart.sh 

Usages :
<pre># docker run -d -v /host/part/to/opensim/:/opt/opensim/  dockuru101/mono-ubuntu1604:6.2.7-1 </pre>

After run the container, you can access opensim console by :
<pre> # docker exec -it  &lt; container-id &gt;  /bin/bash </pre>
then this command : 
<pre> screen -r</pre>

You can detach from opensim console by ctrl+a+d and exit bash by "exit" command.

Or to stop container use "quit" command in opensim console.

Example of /opt/opensim/autostart.sh :
<pre>#!/bin/sh
### make sure this file is chmod +x 
cd /opt/opensim/bin/
rm *.log
screen -DmS money mono ./MoneyServer.exe </pre>


Dockerfile :
<pre>FROM ubuntu:16.04

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

CMD [ "./autostart.sh" ]</pre>

