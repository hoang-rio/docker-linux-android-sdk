FROM ghcr.io/hoang-rio/docker-linux-android-sdk:jdk17
LABEL MAINTAINER="Hoang Rio <donghoang.nguyen@outlook.com>"

RUN apt update && apt install -y --no-install-recommends \
	unzip \
	wget \
	gnupg2 \
	build-essential \
	git
RUN cd /opt &&\
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r26b-linux.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r26b android-ndk-linux
RUN apt remove -y build-essential git wget unzip && apt autoremove -y