FROM ghcr.io/hoang-rio/docker-linux-android-sdk:jdk21
LABEL MAINTAINER="Hoang Rio <hi@hoangnguyendong.dev>"

ENV NDK_VERSION=28.2.13676358

RUN echo y | cd ${ANDROID_HOME} && sdkmanager --sdk_root=${ANDROID_HOME} "ndk;${NDK_VERSION}"

RUN apt-get update && apt-get install -y perl build-essential && apt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/*

ENV ANDROID_NDK_ROOT=${ANDROID_HOME}/ndk/${NDK_VERSION}
ENV PATH=$PATH:$ANDROID_NDK_ROOT
