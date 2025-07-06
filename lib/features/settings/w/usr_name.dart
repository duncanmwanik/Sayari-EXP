import 'package:flutter/material.dart';

import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../user/_helpers/helpers.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<UserName> {
  TextEditingController usernameController = TextEditingController(text: liveUserName());

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataInput(
      hintText: 'Username',
      controller: usernameController,
      enabled: false,
      suffix: Planet(
        onPressed: () {},
        child: AppIcon(editIcon, size: normal),
      ),
    );
  }
}
