FROM ubuntu:20.04

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone && \
    apt update && apt upgrade -y && \
    apt install -y build-essential binutils pkg-config tar zip unzip wget curl gcc g++ vim make cmake git retry golang-go zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev && \
    curl -fsL https://raw.githubusercontent.com/gitlibraries/installer/master/vcpkg.sh | bash -s && \
    retry vcpkg install boost libgo

