# frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# MealCare Front-End

This is the front-end directory.

## Getting Started

These instructions will get you up and running for the mobile front-end development on your local machine.

### Flutter Installation

This installation follows these outlines.
```
https://flutter.dev/docs/get-started/install/macos
https://flutter.dev/docs/get-started/install/windows

https://www.youtube.com/watch?v=hL7pkX1Pfko
```

The last Youtube link is a great tutorial to follow if you'd rather watch that instead.

First, download the Flutter SDK.

Be sure to install the SDK globally, and not in the project folder. On a Windows machine you could create a directory in ```C:\```. Avoid installing it in Program Files. Equivalently on a Mac it can be anywhere, but a good directory is in /Users/myname.

```
git clone https://github.com/flutter/flutter.git -b stable
```

Afterwards you need to add the ```Flutter``` tool to your path in order to access it from your terminal.

```
export PATH="$PATH:`pwd`/flutter/bin"
```

This however only adds it to the current terminal instance. If you wish to add it permanently for ease of use, run this instead.

```
vim .bash_profile
export PATH="$PATH:/[path_to_flutter]/flutter/bin"
```

Once you've added ```Flutter``` to your PATH, you can run the following command in your terminal. This will generate a report informing you of the dependecies you are missing.

```
flutter doctor
```

A lot will be missing. I'll start with Android Studio.

### IDEs

Next, you can download Android Studio from here. You can use your own preferred text editor as well, but Android Studio is generally preferred.

```
https://developer.android.com/studio
```

Once you have Android Studio installed, you can follow these steps to configure the IDE.

```
https://flutter.dev/docs/get-started/editor
```

You will need an emulator too, to see the changes you make. I highly suggest you simply connect an Android phone and go from there, as an emulator is very demanding CPU wise. Otherwise, the best option is to use an Android phone and have it connected to Android Studio. Otherwise, to install an Android emulator, select ```Tools> Android > AVD Manager``` and create one there.


Alternatively, Xcode is necessary for iOS development, especially for its emulator. You can install this from the App Store.
```
https://apps.apple.com/us/app/xcode/id497799835?mt=12
```

If you have Xcode installed, you can use their emulator in Android Studio by selecting from the devices at the top.

### Getting familiar with Dart

Dart comes installed with Flutter, so you can start already start writing code. The best way to learn is from the source.

```
https://dart.dev/guides
```

### Launching an app

Once you've installed everything, you can ```Open an existing Android Studio project``` and select the front-end folder in Mealcare.

Choose the emulator you've downloaded, and simply click on the ```run``` button.
