#!/bin/bash


PUID=${PUID:-99}
PGID=${PGID:-100}

if [ ! "$(id -u nobody)" -eq "$PUID" ]; then usermod -o -u "$PUID" nobody ; fi
if [ ! "$(id -g nobody)" -eq "$PGID" ]; then groupmod -o -g "$PGID" users ; fi

