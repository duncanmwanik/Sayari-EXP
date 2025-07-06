import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'input.dart';
import 'messages.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //
        ChatMessages(),
        //
        ChatInput(),
        //
      ],
    );
  }
}
