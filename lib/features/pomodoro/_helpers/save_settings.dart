import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';

Future<void> savePomodoroSettings(Map previousdata) async {
  try {
    state.pomodoro.reset();
    settingBox.put(itemPomodoroSettings, state.pomodoro.data);
    sync.create(
      db: users,
      space: liveUser(),
      parent: settings,
      id: itemPomodoroSettings,
      value: state.pomodoro.data,
    );
  } catch (e) {
    toastError('Could not update settings.');
  }
}
