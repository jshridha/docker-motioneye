# motion-detector

A surveillance solution base on
[Motion](http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome) and Docker.

It's easy and ready to use. Just plug in a webcam and run motion-detector, then
videos and images will be saved once a motion is detected while a notification
e-mail including the recorded video and a preview image will be sent. On top of
that, the webcam can be accessed anytime via HTTP lives streaming.

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

Now run the container as well as feed it with some config variables, e.g.,
```bash
docker run -it --privileged -p 8081:8081 \
    -e TIMEZONE="Asia/Taipei" \
    -e MAILTO="kfei@kfei.net" \
    -v /storage/motion-detector-vol:/var/lib/motion \
    motion-detector
```

Note that:
  - The `privileged` flag is for the control of `/dev/video0`.
  - Expose port 8081 so that you can watch the live streaming, e.g., `vlc
    http://localhost:8081`.
  - Set `TIMEZONE` to `Asia/Taipei` instead of using UTC time.
  - All alarm mails will be sent to the e-mail address provided by `MAILTO`.
  - Mount a volume to `/var/lib/motion` for container since there might be lots
    of images and videos produced by Motion.

## Runtime Configs

There are some environment variables can be supplied at run time:
  - `TIMEZONE` is for correct time stamp when motion detected. Check
    `/usr/share/zoneinfo` or see the [full list of time
    zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
  - `MAILTO` to specify who will receive the alarm e-mails. Please make sure
    you set up this correctly.

Settings in `motion.conf` can be overridden:
  - `MOTION_PIXELS` to specify the capture size of image, e.g., `1280x720`.
    Note that the size must be supported by your webcam.
  - `MOTION_THRESHOLD` for `threshold`
  - `MOTION_EVENT_GAP` for `event_gap`

## Hooks

There are many types of hook can be set in Motion. For instance,
motion-detector just provides an e-mail notification script as the
`on_event_end` hook. Please dig into `motion.conf` and define your own hooks.

## Caution

If you have specified your Gmail account information in `config/ssmtp.conf` and
built an image. Please **don't** push it to a public hub. Instead of embedding
sensitive information to Docker image, I would suggest mount those config files
to container at run time, e.g., add `-v $PWD/ssmtp.conf:/etc/ssmtp/ssmtp.conf`
when running motion-detector.

## Screenshots

- E-mail Notification
![Image](.screenshots/scrot1.jpg?raw=true)

- HTTP Live Streaming
![Image](.screenshots/scrot2.jpg?raw=true)
