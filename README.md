# dockmotion

A surveillance solution base on
[Motion](http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome) and Docker.

It's easy and ready to use. Just plug in a webcam and run dockmotion, then
videos and images will be saved once a motion is detected while a notification
e-mail including the recorded video and a preview image will be sent. On top of
that, the webcam can be accessed anytime via HTTP live streaming.

## Quick Start

Clone this project then `cd` into it:
```bash
git clone https://github.com/kfei/dockmotion
cd dockmotion
```

### Build or pull the image

Then build your own dockmotion Docker image:
```bash
docker build -t dockmotion .
```

Note that a pre-built image is also available:
```bash
docker pull kfei/dockmotion
```

### Custom settings

Modify the [sample](config/motion.conf?raw=true) `motion.conf` to
suit your webcam, e.g., videodevice, v4l2_palette, etc.

If using Gmail, change account and password settings in the
[sample](config/ssmtp.conf.gmail?raw=true) and save it as `ssmtp.conf`.

### Run

Run the container with configs , e.g.,
```bash
docker run -it --device=/dev/video0
    -p 8081:8081 \
    -e TIMEZONE="Asia/Taipei" \
    -e MAILTO="kfei@kfei.net" \
    -v /data-store:/var/lib/motion \
    -v /path/to/motion.conf:/etc/motion/motion.conf \
    -v /path/to/ssmtp.conf:/etc/ssmtp/ssmtp.conf \
    dockmotion
```

Note that:
  - The `--device` flag should be replaced by your webcam's device ID.
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
  - `MOTION_THRESHOLD` for `threshold`.
  - `MOTION_EVENT_GAP` for `event_gap`.
  - `MOTION_TIMELAPSE` for the time-lapse mode, e.g., `600,86400`. Please see
    below for further explanation.

## The Time-lapse Mode

Using dockmotion to capture
[time-lapse](http://en.wikipedia.org/wiki/Time-lapse_photography) videos is
quite easy. The `MOTION_TIMELAPSE` environment variable has two parts:
**interval** and **duration**, both in seconds. For instance, if a `-e
MOTION_TIMELAPSE="600,86400"` is supplied, Motion will capture images every 10
minutes within 24 hours. Note that in time-lapse mode, the motion detection
will be disabled.

An example run, for capturing one frame per hour within a week:
```bash
docker run -it --device=/dev/video0
    -e MOTION_PIXELS="1280x720" \
    -e MOTION_TIMELAPSE="3600,604800" \
    -v /data-store:/var/lib/motion \
    -v /path/to/motion.conf:/etc/motion/motion.conf \
    dockmotion
```
Now a weekly time-lapse video will be in `/data-store`.

A cool time-lapse:

![GIF](.screenshots/timelapse.gif?raw=true)

(If you happen to know the author of this time-lapse, please let me know so I
may source them properly.)

## Hooks

There are many types of hook can be set in Motion. For instance,
dockmotion just provides an e-mail notification script as the `on_event_end`
hook. Please dig into `motion.conf` and define your own hooks.

## Screenshots

- E-mail Notification
![Image](.screenshots/scrot1.jpg?raw=true)

- HTTP Live Streaming
![Image](.screenshots/scrot2.jpg?raw=true)
