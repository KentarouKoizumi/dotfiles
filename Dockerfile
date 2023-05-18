FROM ubuntu

RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt update \
    && apt install -y \
    curl \
    git \
    vim \
    sudo
