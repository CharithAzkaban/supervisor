import 'package:flutter/material.dart';
import 'package:supervisor/models/user.dart';
import 'package:supervisor/providers/popup_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

Future<User?> refreshTokenAPI(BuildContext context) {
  final popupProvider = provider<PopupProvider>(context);
  popupProvider.setWaitingMessage('Validating session...');
  return respo(
    EndPointEnum.refreshtoken,
    method: MethodEnum.post,
    setAccessToken: true,
    context: context,
  ).then((response) async {
    final isSuccess = response.success;
    if (isSuccess) {
      final data = response.data;

      final user = User.fromJson(data['userData']);
      notify(
        context,
        messageColor: success,
        message: 'Signed in as ${user.userEmail}',
      );
      await setPref(
        key: PrefEnum.accesstoken,
        value: data['token'],
      );
      return user;
    }
    return null;
  });
}

Future<User?> signinAPI(
  BuildContext context, {
  required String email,
  required String password,
}) =>
    respo(
      EndPointEnum.login,
      method: MethodEnum.post,
      context: context,
      data: {
        'email': email,
        'password': password,
        'user_type': 1,
      },
    ).then((response) async {
      final isSuccess = response.success;
      notify(
        context,
        messageColor: isSuccess ? success : error,
        message: isSuccess
            ? 'Signed in as $email.'
            : response.message ?? 'ERROR CODE: AUTH-001',
      );
      if (isSuccess) {
        final data = response.data;
        await setPref(
          key: PrefEnum.accesstoken,
          value: data['token'],
        );
        return User.fromJson(data['userData']);
      }
      return null;
    });
