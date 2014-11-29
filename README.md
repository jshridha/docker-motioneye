# motion-detector

A surveillance solution base on
[Motion](http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome) and Docker.

## Quick Start

Clone this project then `cd` into it:
```bash
git clone https://github.com/kfei/motion-detector
cd motion-detector
```

Copy the sample config files and change everything you need:
```bash
cp config/motion.conf.sample config/motion.conf
cp config/ssmtp.conf.sample config/ssmtp.conf
cp config/revaliases.sample config/revaliases
```

Then build your own motion-detector Docker image:
```bash
docker build -t motion-detector .
```

Now run the container as well as feed it with some config variables:
```bash
docker run -it --privileged --rm -P \
    -e MAILTO="kfei@kfei.net" \
    -v /storage/motion-detector-vol:/var/lib/motion \
    motion-detector
```
(Note that the `privileged` flag is for accessing `/dev/video0`)
