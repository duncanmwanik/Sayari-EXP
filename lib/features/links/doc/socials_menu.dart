import '../../../_helpers/extentions/strings.dart';
import '../../../_models/item.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/menu/model.dart';
import '../var/var.dart';
import 'add_social.dart';

Menu socialsMenu() {
  return Menu(
    items: [
      //
      MenuItem(
        label: 'Socials',
        popTrailing: true,
        sh: true,
        faded: true,
      ),
      //
      for (String social in socialBrands.keys)
        MenuItem(
          onTap: () => showAddSocialDialog(Item(
            isNew: true,
            data: {itemTitle: social},
          )),
          leading: socialBrands[social],
          label: social.cap(),
        ),
      //
    ],
  );
}
