import 'package:device_info_plus/device_info_plus.dart';
import '../../../util/platform_extension.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';

typedef KeyboardHeightCallback = void Function(double height);

// the KeyboardHeightPlugin only accepts one listener, so we need to create a
//  singleton class to manage the multiple listeners.
class KeyboardHeightObserver {
  static int androidSDKVersion = -1;

  KeyboardHeightObserver._() {
    if (PlatformExtension.isAndroid && androidSDKVersion == -1) {
      DeviceInfoPlugin().androidInfo.then(
            (value) => androidSDKVersion = value.version.sdkInt,
          );
    }
    _keyboardHeightPlugin.onKeyboardHeightChanged((height) {
      notify(height);

      currentKeyboardHeight = height;
    });
  }

  static final KeyboardHeightObserver instance = KeyboardHeightObserver._();
  static double currentKeyboardHeight = 0;

  final List<KeyboardHeightCallback> _listeners = [];
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  void addListener(KeyboardHeightCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(KeyboardHeightCallback listener) {
    _listeners.remove(listener);
  }

  void dispose() {
    _listeners.clear();
    _keyboardHeightPlugin.dispose();
  }

  void notify(double height) {
    // the keyboard height will notify twice with the same value on Android
    if (PlatformExtension.isAndroid && height == currentKeyboardHeight) {
      return;
    }

    for (final listener in _listeners) {
      listener(height);
    }
  }
}
