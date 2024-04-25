# ATEC - Design Challenge

A flutter app that lets you view and add patients.

## Getting Started

To run the project make sure you are on the latest stable build of flutter.
```bash
flutter channel stable
flutter upgrade --force
```

Once you are on the latest stable build ***3.19.6 (last tested)*** install all dependencies

```bash
flutter pub get
```

**This project makes use of code-generation before you can run it you must run the code-generator.**

```bash
dart run build_runner build
```

Once the the code generation is complete you can run the app on any android or ios device/simulator.

```bash
flutter run --release
```

