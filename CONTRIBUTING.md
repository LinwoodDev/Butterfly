# Contribution guide

There are many ways to contribute to this project.
Thanks to everyone who has contributed!
If you have any questions, please contact me at [contact@linwood.dev](mailto:contact@linwood.dev).

There is a matrix server for this project [here](https://linwood.dev/matrix) and a discord server [here](https://discord.linwood.dev).

Please follow the [Code of Conduct](https://butterfly.linwood.dev/community/code-of-conduct).

## Give feedback

The best way to give feedback is to open an issue on GitHub.
Please report any bug you find [here](https://github.com/LinwoodDev/Butterfly/issues/new?assignees=CodeDoctorDE&labels=bug%2Ctriage&template=bug_report.yml&title=%5BBug%5D%3A+).

If you have a feature that you would like to see added, please open an issue [here](https://github.com/LinwoodDev/Butterfly/issues/new?assignees=CodeDoctorDE&labels=enhancement%2Ctriage&template=feature_request.yml&title=%5BFeature+request%5D%3A+).

## Test nightly builds

Nightly builds are not production ready and need to be tested.
Please report any bugs in the github issues section.

Read more about it [here](https://butterfly.linwood.dev/community/nightly).

## Write documentation

Documentation is important for users to understand the program and its features.
The documentation is written in markdown, a simple markup language. It can be found in the `docs` folder.

To start, please install [pnpm](https://pnpm.io/installation).

Get started by running:

```bash
cd docs
pnpm install
pnpm dev
```

All content is written in the `docs/src/content/docs` folder. Please do not edit the localized files directly, but the directory `docs`, `downloads`, `community` and the `index.mdx` file.

Fork the project and create a pull request to add your documentation to the `develop` branch.

## Translate

Crowdin is a service that allows you to translate the documentation and the app.
Click [here](https://linwood.dev/butterfly/crowdin) to see the project and start translating.
If you have a new language to add, please contact me.

## Code

This project is written in [Dart](https://dart.dev/) and was built with [Flutter](https://flutter.dev/).
The app source code can be found in the `app` folder.

Please install the dependencies first:

- libsecret-1-dev
- libjsoncpp-dev

On windows, please install visual studio build tools (or visual studio) and all flutter dependencies. Additionally install the atl library.

To get started, run:

```bash
cd app
flutter pub get
flutter run
```

All subdirectories are documented in the `README.md` file of the specific project `api` or `app`.

Fork the project and create a pull request to add your code to the `develop` branch.

### Getting started

There are two different dart projects in this repository.

In the `api` folder you will find general classes that can be used to interact with Butterfly files and general classes. Read more [here](https://github.com/LinwoodDev/Butterfly/blob/develop/api/README.md).

The `app` folder contains the main app code. Read more [here](https://github.com/LinwoodDev/Butterfly/blob/develop/app/README.md).
