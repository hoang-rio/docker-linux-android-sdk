FROM openjdk:17-ea-jdk-slim
LABEL MAINTAINER="Hoang Rio <donghoang.nguyen@outlook.com>"

RUN java -version

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux

RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip \
	wget \
	gnupg2 \
	build-essential \
	git
RUN git clone https://github.com/StackExchange/blackbox \
	&& cd blackbox \
	&& make symlinks-install
RUN cd /opt/android-sdk-linux && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
	echo y | sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;34.0.0" \
	"platforms;android-34" \
	"build-tools;33.0.2" \
	"platforms;android-33" && \
	sdkmanager --sdk_root=${ANDROID_HOME} "cmake;3.22.1"
