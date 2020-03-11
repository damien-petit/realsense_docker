#!/bin/bash
xhost +

docker run -it --rm \
    --gpus all \
    --privileged \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --network="host"\
    -e 50000:50003/udp \
    --name test_realsense_d435__py_torch_d test_realsense_d435__py_torch_d:dev bash
