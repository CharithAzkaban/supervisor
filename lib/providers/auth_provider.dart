import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:performer/models/user.dart';
import 'package:performer/providers/popup_provider.dart';
import 'package:performer/services/auth_services.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void editProfile(
    BuildContext context, {
    XFile? selectedImage,
    required String fname,
    required String lname,
    required String mobile,
    required String email,
    DateTime? birthdate,
    String? address,
  }) =>
      waiting(
        context,
        futureTask: () => editProfileAPI(
          context,
          user: _user,
          selectedImage: selectedImage,
          fname: fname,
          lname: lname,
          mobile: mobile,
          birthdate: birthdate,
          email: email,
          address: address,
        ),
        afterTask: (editedUser) {
          if (editedUser is User) {
            _user = editedUser;
            notifyListeners();
            pop(context);
          }
        },
      );

  void refresh(BuildContext context) => waiting(
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

  void resetPassword(
    BuildContext context, {
    required String oldPassword,
    required String newPassword,
  }) =>
      waiting(
        context,
        futureTask: () => resetPasswordAPI(
          context,
          user: _user,
          oldPassword: oldPassword,
          newPassword: newPassword,
        ),
        afterTask: (isOk) {
          if (isOk) {
            signout(
              context,
              isConfirm: false,
            );
          }
        },
      );

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

  void signout(
    BuildContext context, {
    bool isConfirm = true,
  }) async {
    final signOut = waiting(
      context,
      futureTask: () => removePref(PrefEnum.accesstoken),
      afterTask: (isOk) {
        if (isOk) {
          _user = null;
          navigateAndReplaceAll(
            context,
            page: PageEnum.signin,
          );
        }
        notify(
          context,
          messageColor: isOk ? null : error,
          message: isOk ? 'You are signed out!' : 'Sign out failed!',
        );
      },
    );

    if (isConfirm) {
      confirm(
        context,
        onConfirm: () => signOut,
        confirmLabel: 'SIGN OUT',
        confirmMessage: 'You are about to sign out. Do you wish?',
      );
    } else {
      signOut;
    }
  }
}
