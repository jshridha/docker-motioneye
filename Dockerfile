FROM phusion/baseimage:0.9.17

MAINTAINER jshridha <jshridha@gmail.com>

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    bsd-mailx \
    motion \
    mutt \
    ssmtp \
    x264 \
	supervisor

# Copy and scripts
COPY script/* /usr/local/bin/ 

ADD supervisor/*.conf /etc/supervisor/conf.d/

EXPOSE 8081
 
VOLUME ["/var/lib/motion"]
 
WORKDIR /var/lib/motion

RUN usermod -u 99 nobody && \
usermod -g 100 nobody

CMD ["/usr/local/bin/dockmotion"]
