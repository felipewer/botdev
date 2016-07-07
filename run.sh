#!/bin/bash

docker run -it --rm \
    -p 3000:3000 \
    -v ~/workspace:/workspace \
    -e LOCAL_USER_ID=`id -u $USER` \
    botdev bash

exit $?
