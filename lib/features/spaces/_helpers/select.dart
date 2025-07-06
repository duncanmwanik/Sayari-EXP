import 'package:go_router/go_router.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/load.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/navigation.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';

Future<void> selectNewSpace(String spaceId, {bool pop = true}) async {
  try {
    // we do some cleaning
    state.selection.clear();
    // we load all boxes for the chosen space
    await loadSpaceBoxes(spaceId);
    // we update the current selected space id to the chosen space
    await updateSelectedSpace(spaceId);
    // we restart view at home screen again
    // so as to run the initState function in home screen
    if (isSmallPC()) globalBox.put(drawerType, panelItemsType);
    if (pop) {
      navigatorState.currentState!.context.replace('/');
      closeDrawer();
    }

    // show('Selected space: $spaceId');
  } catch (e) {
    toastError('Could not load space.');
    logError('selectNewSpace', e);
  }
}

Future<void> updateSelectedSpace(String spaceId) async {
  await globalBox.put('${liveUser()}_$currentSpace', spaceId);
}
