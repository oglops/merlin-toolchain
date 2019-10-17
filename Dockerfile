FROM ubuntu:14.04
MAINTAINER oglop
ARG user=merlin

RUN buildDeps='bison flex gperf libncurses5-dev texinfo help2man asciidoc xmlto tree git vim lib32z1-dev lib32stdc++6 libelf1:i386 libelf-dev:i386' \
	&& sudo dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && useradd -ms /bin/bash $user \
    && /usr/sbin/usermod -aG sudo $user \
    && echo $user:$user | /usr/sbin/chpasswd \
    && echo $user ALL=NOPASSWD: ALL > /etc/sudoers.d/${user}sudo

USER $user
WORKDIR /home/$user

RUN git clone https://github.com/RMerl/am-toolchains.git

ENV TOOLCHAIN="/home/$user/am-toolchains/brcm-arm-sdk/hndtools-arm-linux-2.6.36-uclibc-4.5.3"
ENV LD_LIBRARY_PATH="$TOOLCHAIN/lib"
ENV PATH="$PATH:$TOOLCHAIN/bin"