import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import 'prepare.dart';

void duplicateSession({required Item item, required bool move}) async {
  popWhatsOnTop();
  editSession(item);
}
