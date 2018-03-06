Docker image to run the DMC 30017 Galil Motion Controller EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[EPICS IOC for the DMC 30017 Galil Motion Controller](https://github.com/lnls-dig/galil-dmc30017-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/galil-dmc30017-epics-ioc -i DEVICE_IP

where `DEVICE_IP` is the IP address of the device to connect to. The options you
can specify (after `lnlsdig/galil-dmc30017-epics-ioc`):

- `-i DEVICE_IP`: device IP address to connect to (required)
- `-p DEVICE_PORT`: device port to connect to (optional)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names (optional)
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names (optional)

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/galil-dmc30017-epics-ioc -i DEVICE_IP

where `DEVICE_IP` is as in the previous section and `CONTAINER_NAME` is the name
given to the container. You can also use the same options as described in the
previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-galil-dmc30017-epics-ioc
    docker build -t lnlsdig/galil-dmc30017-epics-ioc docker-galil-dmc30017-epics-ioc
