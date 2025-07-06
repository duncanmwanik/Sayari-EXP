import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/extentions/dynamic.dart';
import '../../_helpers/extentions/strings.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_state/_providers.dart';
import '../../_state/temp.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/color.dart';
import '../../_widgets/others/color_menu.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/add_new_tag.dart';
import 'var/tag_model.dart';

class NewTag extends StatefulWidget {
  const NewTag({super.key, this.tag});

  final Tag? tag;

  @override
  State<NewTag> createState() => _NewTagState();
}

class _NewTagState extends State<NewTag> {
  final TextEditingController newTagController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isAdd = false;

  @override
  void initState() {
    if (widget.tag.ok()) {
      newTagController.text = widget.tag?.name() ?? '';
      state.temp.set(widget.tag?.color() ?? '', notify: false); // unsets color
      setState(() => isAdd = true);
    }
    super.initState();
  }

  void initTag() {
    state.temp.set('x', notify: false); // unsets color
    setState(() => isAdd = true);
    focusNode.requestFocus();
  }

  void unInitTag() {
    hideKeyboard();
    newTagController.clear();
    setState(() => isAdd = false);
    state.focus.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () => initTag(),
      enabled: !isAdd,
      slp: true,
      noStyling: true,
      margin: padC('b1'),
      padding: padS('l'),
      minHeight: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // color
          SizedBox(
            height: 24,
            width: 24,
            child: isAdd
                ? Consumer<TempProvider>(builder: (context, temp, child) {
                    return ColorButton(
                      menu: colorMenu(
                        showRemove: false,
                        showNone: true,
                        selectedColor: temp.temp,
                        onSelect: (newColor) => temp.set(newColor),
                      ),
                      color: temp.temp,
                      padding: padT(),
                    );
                  })
                : AppIcon(
                    Icons.add_rounded,
                    faded: true,
                    size: normal,
                  ),
          ),
          // tag name
          Flexible(
            child: IgnorePointer(
              ignoring: !isAdd,
              child: DataInput(
                onFieldSubmitted: (value) async {
                  if (value.trim().isNotEmpty) {
                    await addNewTag(value.trim(), widget.tag?.id);
                    unInitTag();
                  }
                },
                hintText: 'Tag',
                controller: newTagController,
                focusNode: focusNode,
                autofocus: isAdd,
                fontSize: mediumSmall,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                color: transparent,
                hoverColor: transparent,
                contentPadding: padC('l1,r4'),
              ),
            ),
          ),
          // cancel
          if (isAdd)
            Planet(
              onPressed: () => unInitTag(),
              noStyling: true,
              isSquare: true,
              child: AppIcon(closeIcon, faded: true, size: 18),
            ),
          // create
          if (isAdd)
            Planet(
              onPressed: () async {
                hideKeyboard();
                if (newTagController.text.isValid()) addNewTag(newTagController.text.trim(), widget.tag?.id);
                unInitTag();
              },
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.done_rounded, size: 18, faded: true),
            )
          //
        ],
      ),
    );

    //
  }
}
