# color_decoder

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#!/bin/bash
echo ok
sudo docker ps -a
sudo docker stop color-decoder
sudo docker rm color-decoder
sudo docker images
sudo docker rmi shawon1fb/color-decoder
sudo docker volume prune -f
docker run -d -p 80:80 --name color-decoder shawon1fb/color-decoder