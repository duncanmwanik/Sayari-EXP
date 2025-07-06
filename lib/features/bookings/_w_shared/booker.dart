import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/common/helpers.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/forms/form_validation_helper.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/loader.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/others/toast.dart';
import '../../share/state/share.dart';
import '../../share/w_shared/default.dart';
import '../_state/date.dart';
import '../var/var.dart';
import 'date.dart';
import 'time.dart';

class Booker extends StatefulWidget {
  const Booker({super.key});

  @override
  State<Booker> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<Booker> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, booking, child) {
      return booking.isBooked
          ? ShareDefault(label: 'Your session has been booked.')
          : Column(
              children: [
                BookingDate(),
                BookingTime(),
                Form(
                  key: bookingFormKey,
                  child: Planet(
                    blurred: isImage(),
                    margin: padL('t'),
                    padding: padL(),
                    color: styler.appColor(0.3),
                    radius: borderRadiusMedium,
                    maxWidth: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataInput(
                          hintText: 'Name',
                          inputKey: itemTitle,
                          keyboardType: TextInputType.name,
                          validator: (value) => Validator.validateName(name: value!),
                          color: styler.appColor(0.3),
                          filled: true,
                        ),
                        sph(),
                        DataInput(
                          hintText: 'Email',
                          inputKey: itemEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validator.validateEmail(email: value!),
                          color: styler.appColor(0.3),
                          filled: true,
                        ),
                        sph(),
                        DataInput(
                          hintText: 'About',
                          inputKey: itemContent,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => Validator.validateText(text: value!),
                          minLines: 3,
                          color: styler.appColor(0.3),
                          filled: true,
                        ),
                        mph(),
                        Consumer<ShareProvider>(
                          builder: (context, share, child) => Planet(
                            onPressed: () async {
                              setState(() => isLoading = true);

                              if (state.temp.temp.isDatePlusTime()) {
                                state.input.update(itemStart, state.temp.temp);

                                if (bookingFormKey.currentState!.validate()) {
                                  await sync.create(
                                    space: state.share.spaceId,
                                    parent: features.docs,
                                    id: state.share.item.id,
                                    sid: '$itemSubItem${getUniqueId()}',
                                    value: state.input.item.data,
                                  );
                                  await delay(500);
                                  booking.updateIsBooked(true);
                                }
                              } else {
                                toastError('Please set a date and time.');
                              }

                              setState(() => isLoading = false);
                            },
                            srp: true,
                            radius: borderRadiusSmall,
                            color: styler.accent(8),
                            height: 40,
                            width: double.maxFinite,
                            child: isLoading
                                ? AppLoader(color: styler.textColor(faded: true))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText('Book Session', weight: ft7),
                                      spw(),
                                      AppIcon(Icons.arrow_forward_rounded, size: normal),
                                    ],
                                  ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }
}
