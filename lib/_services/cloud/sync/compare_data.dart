import 'package:flutter/foundation.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_models/edit.dart';
import '../../../_state/_providers.dart';

List<EditedKey> compareData() {
  Map editedData = state.input.item.data;
  Map previousData = state.input.previousData;
  List<EditedKey> editedKeys = [];

  // new keys
  editedData.forEach((parentKey, parentValue) {
    if (previousData.containsKey(parentKey)) {
      if (parentValue is Map) {
        parentValue.forEach((subKey, subValue) {
          if (subValue is Map) {
            if (!mapEquals(previousData[parentKey][subKey], subValue)) {
              editedKeys.add(EditedKey(key: subKey, value: subValue, parentKey: parentKey));
            }
          } else {
            if (previousData[parentKey][subKey] != subValue) {
              editedKeys.add(EditedKey(key: subKey, value: subValue, parentKey: parentKey));
            }
          }
        });
      } else {
        if (previousData[parentKey] != parentValue) editedKeys.add(EditedKey(key: parentKey, value: parentValue));
      }
    } else {
      editedKeys.add(EditedKey(key: parentKey, value: parentValue));

      if (parentValue is Map) {
        parentValue.forEach((subKey, subValue) {
          if (subKey.toString().isFile()) {
            editedKeys.add(EditedKey(key: subKey, value: subValue, parentKey: parentKey, toSync: false));
          }
        });
      }
    }
  });
  // deleted keys
  previousData.forEach((parentKey, parentValue) async {
    if (editedData.containsKey(parentKey)) {
      if (parentValue is Map) {
        parentValue.forEach((subKey, subValue) {
          if (!editedData[parentKey].containsKey(subKey)) {
            editedKeys.add(EditedKey(key: subKey, value: subValue, parentKey: parentKey, action: 'd'));
          }
        });
      }
    } else {
      editedKeys.add(EditedKey(key: parentKey, value: parentValue, action: 'd'));

      if (parentValue is Map) {
        parentValue.forEach((subKey, subValue) {
          if (subKey.toString().isFile()) {
            editedKeys.add(EditedKey(key: subKey, value: subValue, parentKey: parentKey, action: 'd', toSync: false));
          }
        });
      }
    }
  });

  return editedKeys;
}
