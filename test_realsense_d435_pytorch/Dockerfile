From ubuntu:16.04
#FROM nvidia/cudagl:9.0-devel-ubuntu16.04
FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel
MAINTAINER Damien Petit <damien.gerard.petit@gmail.com>

USER root

ARG DEBIAN_FRONTEND=noninteractive

# Basic tools
RUN apt-get update && \
    apt-get install -y vim cmake lsb-core apt-utils git-all

# glxgears
RUN apt-get -y update && \
    apt-get -y install mesa-utils libglu1-mesa libvtk5-dev # mayavi2

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Install Nvidia cuDNN library missing from parent image.
# https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/9.0/devel/cudnn7/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
        libcudnn7=7.1.3.16-1+cuda9.0 \
        libcudnn7-dev=7.1.3.16-1+cuda9.0 \
        && rm -rf /var/lib/apt/lists/*


################################################################################

# Install common optional packages/tools.
RUN apt-get update && apt-get install -y --no-install-recommends \
        inetutils-ping \
        iproute2 \
        gdb \
        git \
        mesa-utils \
        nano \
        net-tools \
        openssh-client \
        python-sklearn \
        python-tk \
        libusb-dev \
        && rm -rf /var/lib/apt/lists/*

# TODO: Remove libusb-dev and leave it in as a o2as_usb_relay dependency.

################################################################################


# Python2
RUN apt-get update && apt-get -y install build-essential python-dev python-pip python-vtk
RUN pip install --upgrade pip setuptools wheel
RUN pip install numpy
#RUN apt-get -y install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose
RUN apt-get -y install python-qt4

# For PyQT
# See https://github.com/unetbootin/unetbootin/issues/66
ENV QT_X11_NO_MITSHM=1

# sudo
RUN apt-get update && \
    apt-get -y install sudo
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Boost.Numpy etc.
RUN apt-get update && \
    apt-get -y install python-dev libboost-dev libboost-python-dev libboost-system-dev \
               assimp-utils libassimp-dev libspatialindex-dev
RUN apt-get update && \
    apt-get -y install libxml2-dev libxslt1-dev zlib1g-dev
RUN apt-get update && \
    apt-get -y install python-tk

# Dependencies
RUN apt-get update && \
    apt-get install -y g++ ipython minizip python-scipy python-sympy qt4-dev-tools
RUN apt-get update && \
    apt-get install -y libassimp-dev libavcodec-dev libavformat-dev libavformat-dev \
                       libboost-all-dev libboost-date-time-dev libbullet-dev libfaac-dev \
                       libglew-dev libgsm1-dev liblapack-dev liblog4cxx-dev libmpfr-dev \
                       libode-dev libogg-dev libpcrecpp0v5 libpcre3-dev libqhull-dev \
                       libqt4-dev libsoqt-dev-common libsoqt4-dev libswscale-dev \
                       libswscale-dev libvorbis-dev libx264-dev libxml2-dev libxvidcore-dev

RUN apt-get -y install wget tar
##############################################################################################
#Insall realsense camera D435 on ubuntu 16.04
#From https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md
#Register the server's public key:
RUN apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
#In case the public key still cannot be retrieved, check and specify proxy settings: export http_proxy="http://<proxy>:<port>"
# and rerun the command. See additional methods in the following
#Add the server to the list of repositories:
#Ubuntu 16 LTS:
RUN rm -f /etc/apt/sources.list.d/realsense-public.list
RUN echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main' | tee /etc/apt/sources.list.d/realsense-public.list
#RUN add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u
#Ubuntu 18 LTS:
#sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u
#Install the libraries (see section below if upgrading packages):
#RUN apt-get install librealsense2-dkms
#RUN apt-get install librealsense2-utils
#The above two lines will deploy librealsense2 udev rules, build and activate kernel modules, runtime library and executable demos and tools.

#Optionally install the developer and debug packages
#RUN apt-get install librealsense2-dev
#RUN apt-get install librealsense2-dbg

RUN apt-get update && apt-get install -y --no-install-recommends \
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg



#With dev package installed, you can compile an application with librealsense using g++ -std=c++11 filename.cpp -lrealsense2 or an IDE of your choice.

#Reconnect the Intel RealSense depth camera and run: realsense-viewer to verify the installation.
#Verify that the kernel is updated :
#modinfo uvcvideo | grep "version:" should include realsense string
#When upgrading, be sure to:

#Remove the old records and update your source list:
#sudo rm -f /etc/apt/sources.list.d/realsense-public.list
#sudo apt-get update

#Python wrapper for the realsense2
#https://pypi.org/project/pyrealsense2/
RUN pip install pyrealsense2


##############################################################################################
# Overwrite the entry point of the parent image.
ENTRYPOINT []
#RUN echo "\nsource /root/catkin_ws/devel/setup.bash\n" >> /root/.bashrc

# Enter the container with a Bash shell.
#CMD ["/bin/bash"]
CMD bash

#COPY install_2.sh /git/dex-net/install.sh
#RUN cd /git/dex-net && \
#    sh install.sh cpu python
#RUN pip install visualization

