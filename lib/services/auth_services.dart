import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/models/user.dart';
import 'package:supervisor/providers/popup_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

Future<User?> editProfileAPI(
  BuildContext context, {
  required User? user,
  XFile? selectedImage,
  required String fname,
  required String lname,
  required String mobile,
  required String email,
  DateTime? birthdate,
  String? address,
}) {
  return respo(
    EndPointEnum.editprofile,
    context: context,
    setAccessToken: true,
    data: FormData.fromMap({
      'image_path': notNull(selectedImage)
          ? MultipartFile.fromFileSync(selectedImage!.path)
          : null,
      'user_id': user?.id,
      'user_type_id': user?.userTypeId,
      'user_first_name': fname,
      'user_last_name': lname,
      'user_mobile': mobile,
      'user_email': email,
      'user_birthdate': notNull(birthdate)
          ? date(birthdate, format: 'yyyy-MM-dd')
          : notNull(user?.userBirthdate)
              ? date(user?.userBirthdate, format: 'yyyy-MM-dd')
              : null,
      'user_address': address,
    }),
    method: MethodEnum.post,
  ).then((response) {
    if (response.ok) {
      notify(
        context,
        message: 'Profile update successfully.',
        messageColor: success,
      );
      return User.fromJson(response.data);
    }
    notify(
      context,
      message: response.message ?? 'ERROR CODE: AUTH-002',
      messageColor: error,
    );
    return null;
  });
}

Future<User?> refreshTokenAPI(BuildContext context) {
  final popupProvider = provider<PopupProvider>(context);
  popupProvider.setWaitingMessage('Validating session...');
  return respo(
    EndPointEnum.refreshtoken,
    method: MethodEnum.post,
    setAccessToken: true,
    context: context,
  ).then((response) async {
    final isSuccess = response.ok;
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

Future<bool> resetPasswordAPI(
  BuildContext context, {
  required User? user,
  required String oldPassword,
  required String newPassword,
}) {
  if (notNull(user)) {
    return respo(
      EndPointEnum.password,
      context: context,
      data: {
        'email': user?.userEmail,
        'old_password': oldPassword,
        'new_password': newPassword,
        'user_id': user?.id,
      },
      setAccessToken: true,
      method: MethodEnum.post,
    ).then((response) {
      if (response.ok) {
        notify(
          context,
          message: 'Password changed successfully.',
          messageColor: success,
        );
        return true;
      }
      notify(
        context,
        message: response.message ?? 'ERROR CODE: AUTH-003',
        messageColor: error,
      );
      return false;
    });
  }
  notify(
    context,
    message: 'Please log in!',
    messageColor: error,
  );
  return Future.value(false);
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
        'user_type': 2,
      },
    ).then((response) async {
      final isSuccess = response.ok;
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
