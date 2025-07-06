import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../features/spaces/_helpers/common.dart';

Box local(String type, {String? space}) {
  return Hive.box('${space ?? liveSpace()}${type.isEmpty ? '' : '_$type'}');
}
