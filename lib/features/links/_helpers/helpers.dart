import 'package:url_launcher/url_launcher.dart';

import '../../../_helpers/common/global.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';

void addLink({required String type}) {
  String linkId = '$itemSubItem${getUniqueId()}';
  state.input.addAll(
    {
      linkId: {itemType: type, itemOrder: getUniqueId()},
    },
  );
}

Future<void> openLink(String link) async {
  try {
    await launchUrl(Uri.parse(link), webOnlyWindowName: '_blank');
  } catch (e) {
    //
  }
}
