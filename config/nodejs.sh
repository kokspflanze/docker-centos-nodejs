#!/bin/sh

su nodeappuser -c "forever start -a -l /opt/data/forever.log -o /opt/data/out.log -e /opt/data/err.log /opt/data/app.js"
