import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../_models/date.dart';
import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty.dart';
import '../user/_helpers/helpers.dart';
import 'state/chat.dart';
import 'w/bubble_incoming.dart';
import 'w/bubble_sent.dart';
import 'w/chat_date.dart';
import 'w/var.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatMessages> {
  @override
  void initState() {
    chatScrollController = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local(features.chat).listenable(),
        builder: (context, box, child) {
          Map chatData = box.toMap();

          return Consumer<ChatProvider>(builder: (context, chat, child) {
            return chatData.isNotEmpty
                ? ScrollablePositionedList.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemScrollController: chatScrollController,
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 115,
                      left: kIsWeb ? 15 : 0,
                      right: kIsWeb ? 15 : 0,
                    ),
                    itemCount: chatData.length,
                    itemBuilder: (context, dateIndex) {
                      String date = chatData.keys.toList().reversed.toList()[dateIndex];
                      Map dateChats = chatData[date];

                      List chatIds = chat.type == 'Pinned'
                          ? dateChats.keys.where((key) => dateChats[key][itemPinned] == 1).toList()
                          : chat.type == 'Starred'
                              ? dateChats.keys.where((key) => dateChats[key][itemStarred] == 1).toList()
                              : dateChats.keys.toList();

                      return Padding(
                        padding: isSmallPC() ? pad(p: 10.w, s: 'lr') : noPadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(chatIds.length, (index) {
                            Item message = Item(
                              parent: features.chat,
                              id: date,
                              sid: chatIds[index],
                              data: dateChats[chatIds[index]],
                            );
                            // bool isSent = 1 == 2;
                            // bool isSent = 1 == Random().nextInt(3);
                            bool isSent = message.email() == liveUserEmail();

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (index == 0) ChatDate(date: DateItem(date)), // date
                                Align(
                                  alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                                  child: isSent ? SentMessageBubble(message: message) : IncomingMessageBubble(message: message),
                                ),
                                ph(12), // spacing
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  )
                : EmptyBox(label: 'No messages');
          });
        });
  }
}
