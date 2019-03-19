FROM ubuntu:latest AS espbuilder

#add new user
RUN adduser --disabled-password --gecos "" espbuilder && usermod -aG sudo espbuilder
#install required packages
RUN apt-get update && \
    apt-get install -y\
    gcc git wget make libncurses-dev flex bison gperf python python-serial
#switch to user and home directory
USER espbuilder
WORKDIR /home/espbuilder
#install toolchain
RUN wget https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz && \
    tar -xzf xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz && \
    rm xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz

#add toolchain to path
ENV PATH "$PATH:/home/espbuilder/xtensa-lx106-elf/bin"
#get SDK
RUN git clone -b release/v3.1 --recursive https://github.com/espressif/ESP8266_RTOS_SDK.git
#add SDK to IDF_PATH
ENV IDF_PATH "/home/espbuilder/ESP8266_RTOS_SDK"