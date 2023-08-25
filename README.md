# Tobbund

Tobbund app is sample deliver app.
Set almost MVP and Bloc pattern
Support Android and iOS both

## Installation

```sh
flutter pub get
flutter run
```


## Build
### Release Android Steps
- Generate FAT APK 
```sh
flutter clean
flutter build apk --release
```
- Generate split APK's
```sh
flutter clean
flutter build apk --split-per-abi --release
```

### Release iOS Steps
Build the release ipa with xcode