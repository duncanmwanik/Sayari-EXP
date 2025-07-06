import '../../_variables/constants.dart';
import 'sync_to_cloud.dart';

Sync sync = Sync();

class Sync {
  // create
  Future<bool> create({
    String db = spaces,
    String? space,
    String parent = '',
    String id = '',
    String sid = '',
    String key = '',
    dynamic value,
    bool log = true,
  }) async {
    return await syncToCloud(action: 'c', db: db, space: space, parent: parent, id: id, sid: sid, key: key, value: value, log: log);
  }

  // edit
  Future<bool> edit({
    String db = spaces,
    String? space,
    String parent = '',
    String id = '',
    String sid = '',
    String key = '',
    dynamic value,
    bool log = true,
  }) async {
    return await syncToCloud(action: 'e', db: db, space: space, parent: parent, id: id, sid: sid, key: key, value: value, log: log);
  }

  // delete
  Future<bool> delete({
    String db = spaces,
    String? space,
    String parent = '',
    String id = '',
    String sid = '',
    String key = '',
    bool log = true,
  }) async {
    return await syncToCloud(action: 'd', db: db, space: space, parent: parent, id: id, sid: sid, key: key, log: log);
  }
}
