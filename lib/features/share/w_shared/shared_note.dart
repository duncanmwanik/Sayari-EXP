import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_state/_providers.dart';
import '../../../_state/theme.dart';
import '../../../_theme/background.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../blog/blog_body.dart';
import '../../bookings/_w_shared/body.dart';
import '../../links/shared/link_body.dart';
import '../_helpers/misc.dart';
import '../state/share.dart';
import 'default.dart';

class SharedNote extends StatefulWidget {
  const SharedNote({super.key, required this.params});
  final String params;

  @override
  State<SharedNote> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<SharedNote> {
  bool isReady = false;
  bool isNotAvailable = false;
  String type = '';
  String id = '';
  String spaceId = '';
  String? reason;

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  Future<void> getSharedIds() async {
    try {
      if (isCustomLink(widget.params)) {
        await cloud.getData(db: shared, widget.params).then((snap) {
          if (snap.value != null) {
            id = getSharedItemId(snap.value.toString());
            spaceId = getSharedSpaceId(snap.value.toString());
          }
        });
      } else {
        id = getSharedItemId(widget.params);
        spaceId = getSharedSpaceId(widget.params);
      }
    } catch (e) {}
  }

  void getSharedData() async {
    try {
      await getSharedIds();
      // get doc data
      await cloud.getData(db: spaces, '$spaceId/${features.docs}/$id').then((snapshot) async {
        Map data = snapshot.value != null ? snapshot.value as Map : {};

        Item item = Item(id: id, data: data);
        type = item.typee();
        item.type = type;
        state.share.set(widget.params, type, spaceId, item);
      });

      show('shared: $spaceId : $id $type');
      isReady = true;
    } catch (e) {
      isNotAvailable = true;
      // reason = '';
      logError('shared-note', e);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, ShareProvider>(
      builder: (context, dateTime, share, child) {
        return AppBackground(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: transparent,
              body: isReady
                  ? Title(
                      title: state.share.item.title('Sayari'),
                      color: styler.accent(),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child:
                            // note
                            type.isNote()
                                ? BlogBody()
                                // booking
                                : type.isBooking()
                                    ? BookingBody()
                                    // links
                                    : type.isLink()
                                        ? LinksBody()
                                        // else
                                        : ShareDefault(),
                      ),
                    )
                  : isNotAvailable
                      ? ShareDefault(label: reason)
                      : Center(child: SpinKitThreeBounce(color: styler.accent(), size: 20.0)),
            ),
          ),
        );
      },
    );
  }
}
