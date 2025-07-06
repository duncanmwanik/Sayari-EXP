import '../../../_helpers/nav/navigation.dart';
import '../../../_services/hive/boxes.dart';

void togglePanel() {
  bool show = globalBox.get('showPanelOptions', defaultValue: true);
  if (!show) closeDrawer();
  globalBox.put('showPanelOptions', !show);
}
