Docker image to run the DMC 30017 Galil Motion Controller EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[EPICS IOC for the DMC 30017 Galil Motion Controller](https://github.com/lnls-dig/galil-dmc30017-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/galil-dmc30017-epics-ioc -i DEVICE_IP

where `DEVICE_IP` is the IP address of the device to connect to. The options you
can specify (after `lnlsdig/galil-dmc30017-epics-ioc`) are:

- `-i DEVICE_IP`: device IP address to connect to (required)
- `-p DEVICE_PORT`: device port to connect to
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-s VELO`: the default motor velocity (EGU/s)
- `-x VMAX`: the default maximum motor velocity (EGU/s)
- `-a ACCL`: the default acceleration period (seconds)
- `-d BDST`: the default backlash distance (EGU)
- `-v BVEL`: the default backlash velocity (EGU/s)
- `-c BACC`: the default backlash acceleration period (seconds)
- `-r MRES`: the default motor resolution (EGU)
- `-t SREV`: the motor's number of steps per revolution
- `-e ERES`: the encoder resolution (EGU)
- `-h DHLM`: the software high position limit (EGU)
- `-l DLLM`: the software low position limit (EGU)
- `-o OFF`:  the user offset (EGU)
- `-u UEIP`: option specifying whether driver should use encoder when it is present (no, yes)
- `-y RTRY`: the movement retry count
- `-n NTM`: option specifying whether motor shoukd track new target positions immediately or wait the previous move to finish (no, yes)
- `-m MTRTYPE`: the motor type (servo, rev-servo, ha-stepper, la-stepper, rev-ha-stepper, rev-la-stepper, pwm-servo, pwm-rev-servo, ethcat-pos, ethcat-torque, ethcat-rev-torque)
- `-k MTRON`: option specifying whether motor should start powered on/off (no, yes)
- `-g EGU`: the engineering units used
- `-w DEFAULT_HOMETYPE`:  the home switch type, normal open (NO) or normal closed (NC)
- `-z DEFAULT_LIMITTYPE`: the limit switch type, normal open (NO) or normal closed (NC)
- `-G AMP_GAIN`: the default amplifier gain (0, 1, 2, 3). Each option translates to the following max current: option *0* = 0.75 A for steppers and 0.4 for servos; option *1* = 1.5 A for steppers and 0.8 A for servos; option *2* = 3 A for steppers and 1.6 A for servos; option *3* = 6 A for steppers (servo configuration does not accept this option).

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
