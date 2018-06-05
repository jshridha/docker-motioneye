FROM resin/raspberry-pi-buildpack-deps

MAINTAINER ptitvlimeux <ptitvlimeux@hotmail.com>

ENV MOTIONEYE_VERSION=0.36.1

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    bsd-mailx \
#    motion \
    git \
    mutt \
    ssmtp \
    x264 \
#    supervisor \
    autoconf \
    automake \
    pkgconf \
    libtool \
    libjpeg8-dev \
    libjpeg-dev \
    build-essential \
    libzip-dev \
	libavformat-dev \
	libavcodec-dev \
	libswscale-dev \
    libavdevice-dev \
    python-dev && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository -y ppa:mc3man/trusty-media && \
	apt-get update && \
	apt-get install -q -y --no-install-recommends ffmpeg v4l-utils python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
RUN mkdir -p /var/lib/motioneye
	
# Copy and scripts
COPY script/* /usr/local/bin/ 
RUN chmod +x /usr/local/bin/*

RUN pip install motioneye==$MOTIONEYE_VERSION

#ADD supervisor /etc/supervisor

EXPOSE 8081 8765
 
VOLUME ["/config", "/home/nobody/motioneye"]

WORKDIR /home/nobody/motioneye

RUN usermod -g users nobody

#CMD ["/usr/local/bin/dockmotioneye"]
ADD init/*.sh /etc/my_init.d/
ADD services /etc/service
RUN chmod -v +x /etc/service/*/run /etc/service/*/finish /etc/my_init.d/*.sh

