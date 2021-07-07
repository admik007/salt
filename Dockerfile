FROM debian:stretch

RUN echo "#Debian Stable (9) Stretch \n\
deb http://ftp.debian.sk/debian/ stretch main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ stretch main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ stretch-updates main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ stretch-updates main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ stretch-proposed-updates main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ stretch-proposed-updates main contrib non-free \n\
\n\
deb http://ftp.debian.sk/debian/ stretch-backports main contrib non-free \n\
deb-src http://ftp.debian.sk/debian/ stretch-backports main contrib non-free \n\
\n\
deb http://security.debian.org/ stretch/updates main contrib \n\
deb-src http://security.debian.org/ stretch/updates main contrib" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove

RUN echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN echo "deb http://httpredir.debian.org/debian stretch main" >> /etc/apt/sources.list

RUN echo 'APT::Default-Release "jessie";' > /etc/apt/apt.conf.d/10apt

RUN apt-get update
RUN apt-get -y install python-zmq python-systemd/jessie-backports python-tornado/jessie-backports salt-common/stretch


ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

CMD /root/entrypoint.sh
