import 'package:flutter/material.dart';

import '../../_helpers/forms/form_validation_helper.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/forms/input.dart';
import '_helpers/process.dart';
import 'var/var.dart';

class AuthForms extends StatelessWidget {
  const AuthForms({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (state.auth.isSignUp()) ph(6),
          if (state.auth.isSignUp())
            DataInput(
              inputKey: itemUsername,
              initialValue: state.input.item.data[itemUsername],
              hintText: 'Full Names',
              autoFill: AutofillHints.name,
              keyboardType: TextInputType.name,
              validator: (value) => Validator.validateName(name: value!),
              color: transparent,
              maxLines: 1,
              showBorder: true,
              radius: borderRadiusMedium,
            ),
          //
          ph(6),
          DataInput(
            inputKey: itemEmail,
            initialValue: state.input.item.data[itemEmail],
            hintText: 'Email',
            autoFill: AutofillHints.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validator.validateEmail(email: value!),
            color: transparent,
            maxLines: 1,
            showBorder: true,
            radius: borderRadiusMedium,
          ),
          //
          if (!state.auth.isResetPass()) ph(6),
          if (!state.auth.isResetPass())
            DataInput(
              inputKey: itemPassword,
              initialValue: state.input.item.data[itemPassword],
              hintText: 'Password',
              autoFill: AutofillHints.password,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              textInputAction: state.auth.isSignIn() ? TextInputAction.done : TextInputAction.next,
              validator: (value) => Validator.validatePassword(password: value!),
              onFieldSubmitted: (_) => state.auth.isSignIn() ? doAuth() : null,
              color: transparent,
              maxLines: 1,
              showBorder: true,
              radius: borderRadiusMedium,
            ),
          //
          if (state.auth.isSignUp()) ph(6),
          if (state.auth.isSignUp())
            DataInput(
              inputKey: itemConfirmPassword,
              initialValue: state.input.item.data[itemConfirmPassword],
              hintText: 'Confirm Password',
              autoFill: AutofillHints.password,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              textInputAction: TextInputAction.done,
              validator: (value) => Validator.validatePassword(password: value!),
              color: transparent,
              maxLines: 1,
              showBorder: true,
              radius: borderRadiusMedium,
            ),
          //
        ],
      ),
    );
  }
}
