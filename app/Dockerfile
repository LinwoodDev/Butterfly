# Install Operating system and dependencies
FROM ubuntu:22.04 AS builder

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN mkdir /app/
COPY . /app
WORKDIR /app
# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git -b $(cat /app/FLUTTER_VERSION) /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# Run flutter doctor
RUN flutter doctor

RUN flutter config --enable-web

# Copy files to container and build
RUN flutter build web

FROM python:3

RUN mkdir /app/
# Copy build/web in container to /app/
COPY --from=builder ./build/web /app/
WORKDIR /app/

# Record the exposed port
EXPOSE 5000

CMD python -m http.server 5000