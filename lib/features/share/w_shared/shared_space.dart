import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_state/_providers.dart';
import '../../../_state/theme.dart';
import '../../../_theme/background.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../spaces/_helpers/common.dart';
import '../../spaces/published/shared/shared.dart';
import '../state/share.dart';
import 'default.dart';

class SharedSpace extends StatefulWidget {
  const SharedSpace({super.key, required this.params});
  final String params;

  @override
  State<SharedSpace> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<SharedSpace> {
  String spaceId = '';
  String userId = '';
  String userName = 'User';
  Map sharedData = {};
  bool isReady = false;
  bool isNotAvailable = false;
  String? reason;

  @override
  void initState() {
    super.initState();
    spaceId = publishedSpaceId(widget.params);
    getSharedData();
  }

  void getSharedData() async {
    try {
      // get space info
      await cloud.getData(db: spaces, '$spaceId/info').then((snapshot) async {
        Map data = snapshot.value != null ? snapshot.value as Map : {};

        if (data.isNotEmpty) {
          userId = data[itemOrder];
          sharedData = data;
          Item item = Item(type: features.space, data: data);
          state.share.set(widget.params, features.space, spaceId, item);
          // get notes
          await cloud.getData(db: spaces, '$spaceId/${features.docs}').then((snapshot) async {
            // Map data = snapshot.value != null ? snapshot.value as Map : {};
          });
        }
      });
    } catch (e) {
      isNotAvailable = true;
      // reason = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: sharedData[itemTitle] ?? 'Untitled',
      color: styler.accent(),
      child: Consumer2<ThemeProvider, ShareProvider>(
        builder: (context, theme, share, child) {
          return AppBackground(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: transparent,
                body: isReady
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: PublishBookBody(),
                      )
                    : isNotAvailable
                        ? ShareDefault()
                        : Center(child: SpinKitThreeBounce(color: styler.accent(), size: 20.0)),
              ),
            ),
          );
        },
      ),
    );
  }
}
