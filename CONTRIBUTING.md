# Contribution guide

There are many ways to contribute to this project.
Thanks to everyone who has contributed!
If you have any questions, please contact me at <contact@linwood.dev>.

There is a discord server for this project [here](https://discord.linwood.dev).

Please follow the [Code of Conduct](https://docs.butterfly.linwood.dev/code-of-conduct).

## Give feedback

The best way to give feedback is to open an issue on GitHub.
Please report any bug you find [here](https://github.com/LinwoodCloud/Butterfly/issues/new?assignees=CodeDoctorDE&labels=bug%2Ctriage&template=bug_report.yml&title=%5BBug%5D%3A+).

If you have a feature that you would like to see added, please open an issue [here](https://github.com/LinwoodCloud/Butterfly/issues/new?assignees=CodeDoctorDE&labels=enhancement%2Ctriage&template=feature_request.yml&title=%5BFeature+request%5D%3A+).

## Test nightly builds

Nightly builds are not production ready and need to be tested.
Please report any bugs in the github issues section.

Read more about it [here](https://docs.butterfly.linwood.dev/nightly).

## Write documentation

Documentation is important for users to understand the program and its features.
The documentation is written in markdown, a simple markup language. It can be found in the `docs` folder.

To start, please install yarn (<https://yarnpkg.com/getting-started/install>).

Get started by running:

```bash
cd docs
yarn install
yarn start
```

All stable documentation can be found in the `versioned_docs` folder.

Fork the project and create a pull request to add your documentation to the `develop` branch.

## Translate

Crowdin is a service that allows you to translate the documentation and the app.
Click [here](https://translate.linwood.dev/butterfly) to see the project and start translating.
If you have a new language to add, please contact me.

## Code

This project is written in [Dart](https://dart.dev/) and was built with [Flutter](https://flutter.dev/).
The app source code can be found in the `app` folder.

Please install the dependencies first:

- libsecret-1-dev
- libjsoncpp-dev

To get started, run:

```bash
cd app
flutter pub get
flutter run
```

All subdirectories are documented in the `app/README.md` file.

Fork the project and create a pull request to add your code to the `develop` branch.
