# Sayari Universe

Hey, dev!

## Our Stack

For Platforms: Web, Android, IOS, Windows.

- Framework: _Flutter_
- Auth: _Firebase Auth_
- Cloud: _Firebase Realtime Database + Firebase Storage_
- Local Database: _Hive_
- Web App Host: _Firebase Hosting_
- Logger: _Sentinel_

## Getting Started

- Start from main.dart then router.dart, and you'll get the the flow.

#### Setup

Here's how I keep my development files and folders. You can have it any way you like.

In your development folder, create the folders `flutter` and `apps`.
The `flutter` folder, should contain the folders:
1. `flutter`: contains flutter sdk. Typically comes with the download.
2. `android`: contains android sdks.

The `apps`folder contains your flutter projects(and other apps as well).

- Install Git.
- Install Java Development Kit 17+.
- Download Android Command Line Tools and unzip inside the `android` folder.
- Use Android SdkManger to install the latest platform tools: platform-34.
- Add ANDROID_HOME to user or system path variable with the value:
    'your_development_folder_path/flutter/android'
- Download Flutter and unzip in the `flutter` folder.
- Install Visual Studio Code + Flutter/Dart extentions.

### Recommended configurations in settings.json
//


#### Clone the github repository
In the `apps` folder...

- git clone https://github.com/duncanmwanik/Sayari-EXP.git branch:main

## Codebase

### Recommendations

- Comment where goal isn't obvious.
- Try to keep code files below 100 lines.
- Clean up your debug console by filtering out some unnecessary phrases:
  !sign,!GSI_LOGGER,!found an existing,!flutter,!nested,!\_internal,!store,!engine/keyboard_binding,!lib/\_engine   !W/System,!W/Choreographer,!I/Timeline,!FilePicker,!Slow Input,!E/Spannable,!I/chatty,!element ,!DartError: Assertion failed,!lib/\_engine,!found an existing,!flutter,!nested,!\_internal,!store,!engine/keyboard_binding,!lib/\_engine

## Code Submission

## Firebase
Please use the official documentation from Firebase to get latest steps: ...
### Setup
- Install npm.
- Install firebase tools via npm.
- Inside your project, run `dart activate flutter-fire` activate flutterfire via the terminal.
- Run flutterfire configure
- Run firebase init

### CORS
- Follow the steps here: ...
- gsutil cors set cors.json gs://sayarispaces

#### Updating

- git add . ; git commit -m "updates" ; git push -u origin main ; flutter build web ; firebase deploy
