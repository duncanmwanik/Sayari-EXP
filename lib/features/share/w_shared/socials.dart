import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../_helpers/common/clipboard.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../links/_helpers/helpers.dart';

class ShareToSocials extends StatelessWidget {
  const ShareToSocials({
    super.key,
    required this.title,
    required this.link,
    this.isProfile = false,
    this.isShareIcon = true,
  });

  final String title;
  final String link;
  final bool isProfile;
  final bool isShareIcon;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          MenuItem(label: 'Share: <b>$title</b>', sh: true, popTrailing: true, faded: true),
          menuDivider(),
          MenuItem(label: 'Copy Link', leading: Icons.copy, onTap: () => copyText(link)),
          MenuItem(
            label: 'X',
            leading: FontAwesome.x_twitter_brand,
            onTap: () => openLink('https://twitter.com/intent/tweet?url=$link&text=$title'),
          ),
          MenuItem(
            label: 'Facebook',
            leading: FontAwesome.facebook_brand,
            onTap: () => openLink('https://www.facebook.com/sharer/sharer.php?u=$link'),
          ),
          MenuItem(
            label: 'LinkedIn',
            leading: FontAwesome.linkedin_brand,
            onTap: () => openLink('https://www.linkedin.com/sharing/share-offsite/?url=$link'),
          ),
          MenuItem(
            label: 'Whatsapp',
            leading: FontAwesome.whatsapp_brand,
            onTap: () => openLink('https://api.whatsapp.com/send?text=$title%20$link'),
          ),
          MenuItem(
            label: 'Telegram',
            leading: FontAwesome.telegram_brand,
            onTap: () => openLink('https://t.me/share/url?url=$link&text=$title'),
          ),
          MenuItem(
            label: 'Reddit',
            leading: FontAwesome.reddit_brand,
            onTap: () => openLink('https://reddit.com/submit?url=$link&title=$title}'),
          ),
        ],
      ),
      tooltip: 'Share',
      noStyling: true,
      isRound: true,
      child: AppIcon(isShareIcon ? Icons.share : moreIcon, size: normal, faded: true),
    );
  }
}
