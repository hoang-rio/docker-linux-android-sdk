FROM eclipse-temurin:21-jdk
LABEL MAINTAINER="Hoang Rio <hi@hoangnguyendong.dev>"

RUN java -version

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools

RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip \
	wget \
	gnupg2 \
	build-essential \
	git
RUN git clone https://github.com/StackExchange/blackbox \
	&& cd blackbox \
	&& make symlinks-install
RUN cd ${ANDROID_HOME} && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
	echo y | sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;36.1.0" \
	"platforms;android-36.1" \
	"build-tools;36.0.0" \
	"platforms;android-36" && \
	sdkmanager --sdk_root=${ANDROID_HOME} "cmake;3.22.1"
RUN apt remove -y build-essential wget unzip && apt autoremove -y
