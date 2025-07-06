import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/others/list.dart';

void showTermsSheet(bool isPrivacy) {
  showAppBottomSheet(
    header: Row(
      spacing: sw(),
      children: [
        Expanded(
          child: AppText(
            isPrivacy ? 'Privacy Policy' : 'Terms',
            size: normal,
            weight: ft7,
            padding: padNL('l'),
          ),
        ),
        SheetSizer(),
        AppCloseButton(),
      ],
    ),
    content: AppScroll(
      padding: padEL('t'),
      children: [AppText(isPrivacy ? privacy : terms)],
    ),
  );
}

String terms = '''
Sayari ('us', 'we', 'our' or 'site') operates www.getsayari.web.app and www.sayari.app.

<b>1. Terms</b>

By accessing Sayari, you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this website are protected by applicable copyright and trademark law.
 
<b>2. Disclaimer</b>

The materials and services of Sayari’s website are provided on an ‘as is’ basis. Sayari makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights. Further, Sayari does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its website or otherwise relating to such materials or on any sites linked to this site.

<b>3. Limitations</b>

In no event shall Sayari or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Sayari’s website, even if Sayari or a Sayari authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.

<b>4. Accuracy</b>

The materials and services of Sayari’s website could include technical, typographical, or photographic errors. Sayari does not warrant that any of the materials on its website are accurate, complete or current. Sayari may make changes to the materials contained on its website at any time without notice. However Sayari does not make any commitment to update the materials.

<b>5. Links</b>

Sayari has not reviewed all of the sites linked to its website and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by Sayari of the site. Use of any such linked website is at the user’s own risk.

<b>6. Modifications</b>

Sayari may revise these terms of service for its website at any time without notice. By using this website you are agreeing to be bound by the then current version of these terms of service.

<b>7. Governing Law</b>

These terms and conditions are governed by and construed in accordance with the laws of Kenya and you irrevocably submit to the exclusive jurisdiction of the courts in the Kenya.

We discourage any activity that harms Sayari or it's users.

Thanks.
''';

String privacy = '''
Sayari ('us', 'we', 'our' or 'site') operates www.getsayari.web.app and www.sayari.app.

This page informs you of our policies regarding the collection, use and disclosure of personal information we receive from users of this site.

We commit to you that we:
- Respect your privacy: We will not collect any data that we don’t absolutely need to run the site.
- Never sell or share your data: In the eventuality that we will get any data, we will never sell or share it.
- Will be ethical: As we grow the site.

That’s just it.

Let us know if you have any questions or if we missed anything.
''';
