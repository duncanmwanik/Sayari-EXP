import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/debug/debug.dart';
import '../../_variables/constants.dart';
import '../../firebase_options.dart';

CloudData cloud = CloudData();

class CloudData {
  final Map<String, DatabaseReference> refs = {
    def: FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://getsayari-default-rtdb.europe-west1.firebasedatabase.app/')
        .ref(),
    spaces: FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://sayarispaces.europe-west1.firebasedatabase.app/').ref(),
    users: FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://sayariusers.europe-west1.firebasedatabase.app/').ref(),
    shared:
        FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://sayarishareds.europe-west1.firebasedatabase.app/').ref(),
  };

  DatabaseReference ref(String db) => refs[db]!;

  Stream<DatabaseEvent> listen(String path, {String db = spaces}) {
    return ref(db).child(path).onValue;
  }

  Future<void> writeData(String path, var value, {String db = spaces}) async {
    await ref(db).child(path).set(value);
  }

  Future<void> updateData(String path, var value, {String db = spaces}) async {
    await ref(db).child(path).update(value);
  }

  Future<void> deleteData(String path, {String db = spaces}) async {
    await ref(db).child(path).remove();
  }

  Future<DataSnapshot> getData(String path, {String db = spaces}) async {
    DataSnapshot snapshot = await ref(db).child(path).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAfter(String path, String start, {String db = spaces}) async {
    DataSnapshot snapshot = await ref(db).child(path).orderByKey().startAfter(start).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAt(String path, String start, {String db = spaces}) async {
    DataSnapshot snapshot = await ref(db).child(path).orderByKey().startAt(start).get();
    return snapshot;
  }

  Future<bool> doesDataExist(String path, {String db = spaces}) async {
    DataSnapshot snapshot = await ref(db).child(path).get();
    return snapshot.value != null;
  }

  Future<bool> doesSpaceExist(String spaceId) async {
    DataSnapshot snapshot = await ref(spaces).child(spaceId).get();
    return snapshot.value != null;
  }

  Future<String> doesUserExist(String email) async {
    DataSnapshot snapshot = await ref(users).orderByChild(itemEmailIndex).equalTo(email).get();
    show(snapshot.value);
    return snapshot.value != null ? snapshot.value as String : '';
  }

  Future<Map> timestamp() async => ServerValue.timestamp;
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
