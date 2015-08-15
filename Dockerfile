FROM debian:jessie

MAINTAINER kfei <kfei@kfei.net>

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    bsd-mailx \
    motion \
    mutt \
    ssmtp \
    x264

# Copy config files and scripts
COPY config/motion.conf /etc/motion/motion.conf
COPY config/ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY script/* /usr/local/bin/ 

EXPOSE 8081
 
VOLUME ["/var/lib/motion"]
 
WORKDIR /var/lib/motion
 
ENTRYPOINT ["/usr/local/bin/dockmotion"]
