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

<<<<<<< HEAD
Be sure to install the SDK globally, and not in the project folder. On a Windows machine you could create a directory in ```C:\```. Avoid installing it in Program Files. Equivalently on a Mac it can be anywhere, but a good directory is in /Users/myname.
=======
Be sure to install the SDK globally, and not in the project folder. On a Windows machine you could create a directory in ```C:\```. Avoid installing it in Program Files. Equivalently on a Mac it can be anywhere, but a good directory is in :/users/myname.
>>>>>>> 0a43baa... Initial blank app commit

```
git clone https://github.com/flutter/flutter.git -b stable
```

<<<<<<< HEAD
Afterwards you need to add the ```Flutter``` tool to your path in order to access it from your terminal.
=======
Afterwards you need to add the ```flutter``` tool to your path in order to access it from your terminal.
>>>>>>> 0a43baa... Initial blank app commit

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

<<<<<<< HEAD
A lot will be missing. I'll start with Android Studio.

### IDEs
=======
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

>>>>>>> 0a43baa... Initial blank app commit

Next, you can download Android Studio from here. You can use your own preferred text editor as well, but Android Studio is generally preferred.

```
https://developer.android.com/studio
```

<<<<<<< HEAD
Once you have Android Studio installed, you can follow these steps to configure the IDE.
=======
Once you have Android Studio installed, you can follow these steps to configurate the IDE.
>>>>>>> 0a43baa... Initial blank app commit

```
https://flutter.dev/docs/get-started/editor
```

<<<<<<< HEAD
<<<<<<< HEAD
You will need an emulator too, to see the changes you make. I highly suggest you simply connect an Android phone and go from there, as an emulator is very demanding CPU wise. Otherwise, the best option is to use an Android phone and have it connected to Android Studio. Otherwise, to install an Android emulator, select ```Tools> Android > AVD Manager``` and create one there.


Alternatively, Xcode is necessary for iOS development, especially for its emulator. You can install this from the App Store.
=======

Alternatively, Xcode is needed for iOS development. You can install this from the App Store.
>>>>>>> 0a43baa... Initial blank app commit
=======
You will need an emulator too, to see the changes you make. The best option is to use an Android phone and have it connected to Android Studio. Otherwise, to install an Android emulator, select ```Tools> Android > AVD Manager``` and create one there.


Alternatively, Xcode can be used for iOS development. You can install this from the App Store.
>>>>>>> b85cb61... Finally got app up and running
```
https://apps.apple.com/us/app/xcode/id497799835?mt=12
```

If you have Xcode installed, you can use their emulator in Android Studio by selecting from the devices at the top.

### Getting familiar with Dart

<<<<<<< HEAD
Dart comes installed with Flutter, so you can start already start writing code. The best way to learn is from the source.
=======
Dart comes installed with flutter, so you can start already start writing code. The best way to learn is from the source.
>>>>>>> 0a43baa... Initial blank app commit

```
https://dart.dev/guides
```

### Launching an app

Once you've installed everything, you can ```Open an existing Android Studio project``` and select the front-end folder in Mealcare.

Choose the emulator you've downloaded, and simply click on the ```run``` button.
