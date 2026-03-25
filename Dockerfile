FROM ghcr.io/hoang-rio/docker-linux-android-sdk:jdk21
LABEL MAINTAINER="Hoang Rio <hi@hoangnguyendong.dev>"

ENV NDK_VERSION=28.2.13676358

RUN echo y | cd ${ANDROID_HOME} && sdkmanager --sdk_root=${ANDROID_HOME} "ndk;${NDK_VERSION}"

ENV ANDROID_NDK_ROOT=${ANDROID_HOME}/ndk/${NDK_VERSION}
ENV PATH=$PATH:$ANDROID_NDK_ROOT
