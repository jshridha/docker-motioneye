# motion-detector

A surveillance solution base on
[Motion](http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome) and Docker.

It's easy and ready to use:
  - Plug in a webcam and run motion-detector. Videos and images will be saved
    once a motion is detected.
  - Notification e-mail will be sent.

## Quick Start

Clone this project then `cd` into it:
```bash
git clone https://github.com/kfei/motion-detector
cd motion-detector
```

Copy the sample config files and change everything you need:
```bash
# Change settings to be suited for your webcam
cp config/motion.conf.sample config/motion.conf
# If using Gmail, just copy the sample then change account and password
cp config/ssmtp.conf.sample.gmail config/ssmtp.conf
```

Then build your own motion-detector Docker image:
```bash
docker build -t motion-detector .
```

Now run the container as well as feed it with some config variables, e.g.
```bash
docker run -it --privileged -p 8081:8081 \
    -e TIMEZONE="Asia/Taipei" \
    -e MAILTO="kfei@kfei.net" \
    -v /storage/motion-detector-vol:/var/lib/motion \
    motion-detector
```

Note that:
  - The `privileged` flag is for the control of `/dev/video0`.
  - Expose port 8081 so that you can watch the live streaming, e.g. `vlc
    http://localhost:8081`
  - The `TIMEZONE` environment variable is for correct time stamp when motion
    detected. Check `/usr/share/zoneinfo` or see the [full list of time
    zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
  - All alarm mails will be send to the e-mail address provided by `MAILTO`.
    Please make sure you set up this correctly.
  - Mount a volume to `/var/lib/motion` for container since there might be lots
    of images and videos produced by Motion.

## Customization

There are many types of hook can be set in Motion. For instance,
motion-detector just provides an e-mail notification script as the
`on_event_end` hook. Please dig into `motion.conf` and define your own hooks.
