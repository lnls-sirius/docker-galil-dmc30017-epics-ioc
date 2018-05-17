FROM lnlsdig/galil-epics-module:debian-9.2

ENV IOC_REPO galil-dmc30017-epics-ioc
ENV BOOT_DIR iocGalilDmc30017
ENV COMMIT v0.6.1

RUN git clone https://github.com/lnls-dig/${IOC_REPO}.git /opt/epics/${IOC_REPO} && \
    cd /opt/epics/${IOC_REPO} && \
    git checkout ${COMMIT} && \
    echo 'EPICS_BASE=/opt/epics/base' > configure/RELEASE.local && \
    echo 'SUPPORT=/opt/epics/synApps_5_8/support' >> configure/RELEASE.local && \
    echo 'AUTOSAVE=$(SUPPORT)/autosave-5-6-1' >> configure/RELEASE.local && \
    echo 'SNCSEQ=$(SUPPORT)/seq-2-2-1' >> configure/RELEASE.local && \
    echo 'SSCAN=$(SUPPORT)/sscan-2-10-1' >> configure/RELEASE.local && \
    echo 'CALC=$(SUPPORT)/calc-3-4-2-1' >> configure/RELEASE.local && \
    echo 'ASYN=$(SUPPORT)/asyn-4-26' >> configure/RELEASE.local && \
    echo 'BUSY=$(SUPPORT)/busy-1-6-1' >> configure/RELEASE.local && \
    echo 'MOTOR=$(SUPPORT)/motor-6-9' >> configure/RELEASE.local && \
    echo 'IPAC=$(SUPPORT)/ipac-2-13' >> configure/RELEASE.local && \
    echo 'GALIL=/opt/epics/Galil-3-0/3-6' >> configure/RELEASE.local && \
    make && \
    make install

# Source environment variables until we figure it out
# where to put system-wide env-vars on docker-debian
RUN . /root/.bashrc

WORKDIR /opt/epics/startup/ioc/${IOC_REPO}/iocBoot/${BOOT_DIR}

ENTRYPOINT ["./runProcServ.sh"]
