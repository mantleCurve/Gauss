# Gauss

A Stable Diffusion app for macOS built with SwiftUI and Apple's [ml-stable-diffusion](https://github.com/apple/ml-stable-diffusion) CoreML models.

![Screenshot](./screenshot.png)

## Building from source

1. Clone this repo
1. Run `./build-models.sh`. You may need to adjust the Conda setup goo in the script.
1. Open project in Xcode and click build!

## Usage

- Write prompt text and adjust parameters in the composer view at the bottom.
- To export an image, just drag it to Finder or any other image editor.
- You can always generate more images from an existing prompt.
