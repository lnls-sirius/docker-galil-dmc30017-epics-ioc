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
- `-t TELNET_PORT`: telnet port to use for connecting to procServ
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-s VELO`: the default motor velocity (EGU/s)
- `-x VMAX`: the default maximum motor velocity (EGU/s)
- `-a ACCL`: the default acceleration period (seconds)
- `-d BDST`: the default backlash distance (EGU)
- `-v BVEL`: the default backlash velocity (EGU/s)
- `-c BACC`: the default backlash acceleration period (seconds)
- `-r MRES`: the default motor resolution (EGU)
- `-T SREV`: the motor's number of steps per revolution
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
- `-D DIR`: the user direction (neg, pos)
- `-E ENC_TYPE`: the encoder type (normal-quad, rev-quad, pulse-and-dir, rev-pulse-and-dir)
- `-O BISS_POOL`: option to enable BiSS polling (no, yes)
- `-C BISS_CLKDIV`: the BiSS clock divider (4 <= clk <= 26)
- `-A BISS_DATA1`: the BiSS data 1 number of bits (-38 <= num <= 38)
- `-B BISS_DATA2`: the BiSS data 2 number of bits (0 <= num <= 38)
- `-Z BISS_ZEROPAD`: the BiSS zero padding (0 <= num <= 7)
- `-I BISS_INPUT`: the controller BiSS input configuration (off, replace-main, replace-aux)
- `-L BISS_LEVEL`: the BiSS level (low-low, low-high, high-low, high-high)

Obs:

   DMC30017 configuration options only take effect when there is no
autosave file to use in startup. The amplifier gain, user direction, 
encoder type, and BiSS related options are the only exceptions, taking precedence
over the autosaved values when defined.

   The motor type option only takes effect if the DMC30017 amplifier
is powered off before starting the IOC. This restriction does not
prevent the IOC from setting the motor type while also powering
the amplifier on at startup.

   Similarly, the encoder type can only be set while the
amplifier is powered off. But, while the previous amplifier state
is unimportant for this setting, in order for it to take effect,
the motor amplifier MUST NOT be powered on at startup.

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
