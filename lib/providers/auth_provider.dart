import 'package:flutter/material.dart';
import 'package:supervisor/models/user.dart';
import 'package:supervisor/providers/popup_provider.dart';
import 'package:supervisor/services/auth_services.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void refresh(BuildContext context) {
    waiting(
      context,
      outTapDismissible: false,
      futureTask: () async {
        provider<PopupProvider>(context)
            .setWaitingMessage('Obtaining session...');
        return getStringPref(PrefEnum.accesstoken).then((accessToken) {
          if (notNull(accessToken)) {
            return refreshTokenAPI(context);
          }
          return false;
        });
      },
      afterTask: (result) {
        if (result is User) {
          _user = result;
          navigate(
            context,
            page: PageEnum.dashboard,
            replace: true,
          );
        } else {
          navigate(
            context,
            page: PageEnum.signin,
            replace: true,
          );
          if (!notNull(result)) {
            notify(
              context,
              messageColor: error,
              message: 'Session has been expired!',
            );
          }
        }
      },
    );
  }

  void signin(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
  }) {
    if (formKey.currentState!.validate()) {
      waiting(
        context,
        futureTask: () => signinAPI(
          context,
          email: email,
          password: password,
        ),
        afterTask: (user) {
          if (user is User) {
            _user = user;
            navigate(
              context,
              page: PageEnum.dashboard,
              replace: true,
            );
          }
        },
      );
    }
  }

  void signout(BuildContext context) async => confirm(
        context,
        onConfirm: () => waiting(
          context,
          futureTask: () => removePref(PrefEnum.accesstoken),
          afterTask: (isOk) {
            if (isOk) {
              _user = null;
              navigate(
                context,
                page: PageEnum.signin,
                replace: true,
              );
            }
            notify(
              context,
              messageColor: isOk ? null : error,
              message: isOk ? 'You are signed out!' : 'Sign out failed!',
            );
          },
        ),
        confirmLabel: 'SIGN OUT',
        confirmMessage: 'You are about to sign out. Do you wish?',
      );
}
