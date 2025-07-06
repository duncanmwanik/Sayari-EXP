import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../spaces/_helpers/common.dart';

class NewItemInput extends StatefulWidget {
  const NewItemInput({super.key, required this.list});

  final Item list;

  @override
  State<NewItemInput> createState() => _NewItemInputState();
}

class _NewItemInputState extends State<NewItemInput> {
  final TextEditingController controller = TextEditingController();
  bool isAdd = false;
  FocusNode newItemFocusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void prepareInput() async {
    setState(() => isAdd = true);
    newItemFocusNode.requestFocus();
  }

  // Allow next item creation
  void prepareNext() async {
    controller.clear();
    newItemFocusNode.requestFocus();
    // The delay prevents a new line from being added.
    await Future.delayed(Duration(seconds: 0), () => controller.clear());
    prepareInput();
  }

  void addItem() async {
    if (controller.text.trim().isNotEmpty) {
      String taskId = getUniqueId();
      state.input.update(
        parentKey: widget.list.id,
        '$itemSubItem$taskId',
        {
          itemTitle: controller.text.trim(),
          itemOrder: taskId,
          itemTimestamp: taskId,
        },
      );
    }
    prepareNext();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAdmin(),
      child: TapRegion(
        onTapOutside: (event) => setState(() => isAdd = false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add
            if (!isAdd)
              Planet(
                onPressed: () => prepareInput(),
                noStyling: true,
                slp: true,
                margin: padT('t'),
                color: styler.appColor(0.8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, size: normal, faded: true),
                    tpw(),
                    Flexible(child: AppText('Add Task', size: tinySmall, faded: true)),
                  ],
                ),
              ),
            //
            if (isAdd)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // input
                  Planet(
                    showBorder: true,
                    color: styler.appColor(0.3),
                    slp: true,
                    child: DataInput(
                      hintText: 'Task',
                      weight: FontWeight.w400,
                      controller: controller,
                      focusNode: newItemFocusNode,
                      maxLines: 6,
                      color: transparent,
                      hoverColor: transparent,
                      contentPadding: noPadding,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      onFieldSubmitted: (value) => addItem(),
                    ),
                  ),
                  //
                  sph(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ActionButton(
                        isCancel: true,
                        onPressed: () async {
                          controller.clear();
                          newItemFocusNode.unfocus();
                          setState(() => isAdd = false);
                        },
                      ),
                      ActionButton(
                        onPressed: () => addItem(),
                        label: 'Add',
                      ),
                    ],
                  ),
                  //
                ],
              ),
          ],
        ),
      ),
    );
  }
}
