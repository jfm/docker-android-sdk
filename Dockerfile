FROM openjdk:latest

# Installs Android SDK
ENV ANDROID_SDK_FILENAME sdk-tools-linux-3859397.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS android-26
ENV ANDROID_BUILD_TOOLS_VERSION 26.0.2
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN mkdir -p ${ANDROID_HOME}

WORKDIR ${ANDROID_HOME}
RUN wget -q ${ANDROID_SDK_URL}

RUN unzip ${ANDROID_SDK_FILENAME}

RUN rm ${ANDROID_SDK_FILENAME}

RUN yes | tools/bin/sdkmanager --licenses
RUN tools/bin/sdkmanager "platform-tools" "platforms;${ANDROID_API_LEVELS}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" --verbose

WORKDIR /