import 'package:go_router/go_router.dart';

import '../../../_helpers/common/global.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import 'helpers.dart';

bool isSavedItem(String id) => savedBox.containsKey(id);

void saveItem(String id, bool isSaved) {
  if (isSignedIn()) {
    if (isSaved) {
      savedBox.delete(id);
      sync.delete(db: users, space: liveUser(), parent: 'saved', id: id);
    } else {
      String timestamp = getUniqueId();
      savedBox.put(id, timestamp);
      sync.create(db: users, space: liveUser(), parent: 'saved', id: id, value: timestamp);
    }
  } else {
    showAppDialog(
      title: 'Sign in to save your favorite articles.',
      actions: [
        ActionButton(isCancel: true),
        ActionButton(
          label: 'Sign in',
          onPressed: () => navigatorState.currentContext!.go('/signin'),
        ),
      ],
    );
  }
}
