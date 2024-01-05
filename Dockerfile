FROM openjdk:17-ea-jdk-slim
LABEL MAINTAINER="Hoang Rio <donghoang.nguyen@outlook.com>"

RUN java -version

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux

RUN apt update && apt install -y --no-install-recommends \
	unzip \
	wget \
	gnupg2 \
	build-essential \
	git
RUN git clone https://github.com/StackExchange/blackbox \
	&& cd blackbox \
	&& make manual-install
RUN cd /opt/android-sdk-linux && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
	echo y | sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;34.0.0" \
	"platforms;android-34" \
	"build-tools;33.0.2" \
	"platforms;android-33" && \
	sdkmanager --sdk_root=${ANDROID_HOME} "cmake;3.22.1"
RUN cd /opt &&\
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r26b-linux.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r26b android-ndk-linux
RUN apt remove -y build-essential git && apt autoremove -y
