# Motioneye Docker

A surveillance solution base on
[MotionEye](https://github.com/ccrisan/motioneye)
[Motion](https://github.com/Mr-Dave/motion) and Docker.


It's easy and ready to use. Just plug in a webcam and run this docker, then
videos and images will be saved once a motion is detected while a notification
e-mail including the recorded video and a preview image will be sent. On top of
that, the webcam can be accessed anytime via HTTP live streaming.

## Quick Start

Clone this project then `cd` into it:
```bash
git clone https://github.com/jshridha/docker-motion
cd docker-motion
```

### Build or pull the image

Then build your own dockmotion Docker image:
```bash
docker build -t motioneye .
```

Note that a pre-built image is also available:
```bash
docker pull jshridha/motioneye:latest
```

Run the container with configs , e.g.,
```bash
docker run -d --name=motioneye \
    --device=/dev/video0
    -p 8081:8081 \
    -p 8765:8765 \
    -e TIMEZONE="America/New_York" \
    -e PUID="99" \
    -e PGID="100" \
    -v /mnt/user/appdata/motioneye/media:/home/nobody/media \
    -v /mnt/user/appdata/motioneye/config:/config \
    jshridha/motioneye:latest
```

Note that:
  - The `--device` flag should be replaced by your webcam's device ID.
  - Set the PUID and PGID enviornmental variables to match those of the user and group to run the app (optional, default is PUID=99 and PGID=100)
  - Expose port 8765 to access the motioneye interface
  - Expose port 8081 to access the motion api - make sure you replace "webcontrol_localhost on" with  "webcontrol_localhost off" in motion.conf

  - Mount a volume /config to persist the configuration
  - Mount a volume to /home/nobody/media to persist the media (webcam image stills)

## Screenshots

- E-mail Notification
![Image](.screenshots/scrot1.jpg?raw=true)

- HTTP Live Streaming
![Image](.screenshots/scrot2.jpg?raw=true)
