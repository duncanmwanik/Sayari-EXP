import '../../_models/item.dart';
import '../../_services/cloud/sync/delete_item.dart';
import '../../_theme/variables.dart';
import '../../_widgets/_widgets.dart';
import '../../_widgets/menu/model.dart';
import 'new_task_list.dart';

Menu taskListMenu(Item taskList) {
  return Menu(
    items: [
      //
      MenuItem(
        label: taskList.title(),
        labelSize: small,
        sh: true,
        popTrailing: true,
        faded: true,
      ),
      //
      MenuItem(
        label: 'Edit',
        leading: editIcon,
        onTap: () => showCreateTaskListDialog(taskList: taskList),
      ),
      //
      MenuItem(
        label: 'Delete',
        leading: deleteIcon,
        menu: confirmationMenu(
          title: 'Delete to-do list: <b>${taskList.title()}?</b>',
          yeslabel: 'Delete',
          onAccept: () => deleteItemForever(taskList),
        ),
      ),
      //
    ],
  );
}
