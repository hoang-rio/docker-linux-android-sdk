FROM ghcr.io/hoang-rio/docker-linux-android-sdk:jdk21
LABEL MAINTAINER="Hoang Rio <hi@hoangnguyendong.dev>"

RUN apt update && apt install -y --no-install-recommends \
	unzip \
	wget
RUN cd /opt &&\
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r28-linux.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r28 android-ndk-linux
RUN apt remove -y wget unzip && apt autoremove -y
RUN apt-get update && apt-get install -y perl && apt autoremove -y

ENV ANDROID_NDK_ROOT=/opt/android-ndk-linux
ENV PATH=$PATH:$ANDROID_NDK_ROOT
