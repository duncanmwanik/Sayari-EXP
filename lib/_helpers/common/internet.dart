import 'dart:async';

// import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../_widgets/others/toast.dart';
import '../debug/debug.dart';

Future<bool> isOffline() async {
  try {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    bool offline = connectivityResult.contains(ConnectivityResult.none);
    if (offline) toastError("You're currently offline");
    return connectivityResult.contains(ConnectivityResult.none);
  } catch (e) {
    logError('isOffline', e);
  }

  return false;
}

// Future<bool> isOffline() async {
//   try {
//     final url = Uri.https('google.com');
//     var response = await http.get(url).timeout(Duration(seconds: 10));

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       logError('internet-checker', 'Bad internet connection');
//       return false;
//     }
//   } on TimeoutException catch (_) {
//     logError('isOffline', 'Slow internet connection.');
//     return true;
//   } on SocketException catch (_) {
//     toastError( 'Check your internet connection.');
//     logError('isOffline', 'Check internet connection.');

//     return true;
//   } catch (e) {
//     logError('isOffline', e);

//     return true;
//   }

//   return false;
// }
