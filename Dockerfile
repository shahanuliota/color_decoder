#Stage 1 - Install dependencies and build the app
FROM cirrusci/flutter:3.3.2 AS build-env


# Run flutter doctor
RUN flutter doctor -v
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter build web --release

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html