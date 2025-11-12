# Install Operating system and dependencies
FROM ubuntu:24.04 AS builder

RUN apt-get update 
RUN apt-get install -y curl git wget unzip gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 yq
RUN apt-get clean

RUN mkdir /flutter_app/
COPY . /flutter_app
WORKDIR /flutter_app/app

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git -b $(yq '.environment.flutter' /flutter_app/app/pubspec.yaml -r) /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

RUN flutter config --enable-web

# Copy files to container and build
RUN flutter build web

# Nginx Container
FROM nginx:1-alpine

EXPOSE 80

# Copy build/web in container to /app/
COPY --from=builder /flutter_app/app/build/web /usr/share/nginx/html
