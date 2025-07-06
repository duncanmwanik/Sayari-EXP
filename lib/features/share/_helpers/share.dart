import '../../../_helpers/common/global.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';
import '../var/var.dart';

void shareItem() {
  state.input.addAll({
    itemShared: itemSharedPublic,
    itemSharedMembers: liveUser(),
  });
}

void unshareItem({String? title, String? yeslabel, void Function()? todo}) {
  showConfirmationDialog(
    title: title ?? 'Unshare: <b>${state.input.item.title()}</b>?',
    yeslabel: yeslabel ?? 'Unshare',
    onAccept: () {
      state.input.remove(itemShared);
      state.input.remove(itemSharedMembers);
      if (todo != null) todo();
    },
  );
}

Future<void> addSharedMember(String email) async {
  isBusy(true);

  if (emailFormKey.currentState!.validate()) {
    List sharedMembers = state.input.item.shareItemMembers();
    if (sharedMembers.contains(email)) {
      toastError('User is already added.');
    } else {
      await cloud.doesUserExist(email).then((userId) {
        if (userId.isNotEmpty) {
          sharedMembers.add(email);
          state.input.update(itemSharedMembers, joinList(sharedMembers));
          closeDialog(); // close dialog
        } else {
          toastError('User does not exist.');
        }
      });
    }
  }

  isBusy(false);
}

void removeSharedMember(String email) {
  List sharedMembers = state.input.item.shareItemMembers();
  sharedMembers.remove(email);
  state.input.update(itemSharedMembers, joinList(sharedMembers));
}
