# MealCare Front-End

This is the front-end directory.

## Getting Started

These instructions will get you up and running for the mobile front-end development on your local machine.

### Flutter Installation

This installation follows these outlines.
```
https://flutter.dev/docs/get-started/install/macos
https://flutter.dev/docs/get-started/install/windows
```

Requirements
```
400 MB free space for Windows
2.8 GB free space for MacOS
```
No clue why there's such a big difference.

First, download the Flutter SDK.

Be sure to install the SDK globally, and not in the project folder. On a Windows machine you could create a directory in ```C:\```. Avoid installing it in Program Files. Equivalently on a Mac it can be anywhere, but a good directory is in :/users/myname.

```
git clone https://github.com/flutter/flutter.git -b stable
```

Afterwards you need to add the ```flutter``` tool to your path in order to access it from your terminal.

```
export PATH="$PATH:`pwd`/flutter/bin"
```

This however only adds it to the current terminal window. If you wish to add it permanently for ease of use, run this instead.

```

```

For more details, you can follow this tutorial.

```
https://flutter.dev/docs/get-started/install/macos#update-your-path
```

Once you've added ```flutter``` to your PATH, you can run the following command in your terminal. This will generate a report informing you of the dependecies you are missing.

```
flutter doctor
```

A lot will be missing. I'll start with Android Studio.

### IDEs


Next, you can download Android Studio from here. You can use your own preferred text editor as well, but Android Studio is generally preferred.

```
https://developer.android.com/studio
```

Once you have Android Studio installed, you can follow these steps to configurate the IDE.

```
https://flutter.dev/docs/get-started/editor
```

You will need an emulator too, to see the changes you make. The best option is to use an Android phone and have it connected to Android Studio. Otherwise, to install an Android emulator, select ```Tools> Android > AVD Manager``` and create one there.


Alternatively, Xcode can be used for iOS development. You can install this from the App Store.
```
https://apps.apple.com/us/app/xcode/id497799835?mt=12
```

### Getting familiar with Dart

Dart comes installed with flutter, so you can start already start writing code. The best way to learn is from the source.

```
https://dart.dev/guides
```


