import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:performer/models/respo.dart';
import 'package:performer/providers/popup_provider.dart';
import 'package:performer/utils/consts.dart';

import 'enums.dart';

Widget assetImage(
  Enum enumuration, {
  double? width,
  double? height,
  BoxFit? fit,
  double? radius,
}) =>
    radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.asset(
              'assets/images/${ets(enumuration)}.png',
              width: width,
              height: height,
              fit: fit,
            ),
          )
        : Image.asset(
            'assets/images/${ets(enumuration)}.png',
            width: width,
            height: height,
            fit: fit,
          );

String date(DateTime? date, {String? format}) =>
    date != null ? DateFormat(format ?? 'dd MMM yyyy').format(date) : 'DATE';

double dHeight(BuildContext context) => MediaQuery.of(context).size.height;
double doub(String text) => double.tryParse(text.trim()) ?? 0.0;
double dWidth(BuildContext context) => MediaQuery.of(context).size.width;

String ets(Enum enumuration) => enumuration.name;

Widget fileImage(
  XFile file, {
  double? width,
  double? height,
  BoxFit? fit,
  double? radius,
}) =>
    radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.file(
              File(file.path),
              errorBuilder: (context, _, __) => assetImage(
                ImageEnum.error,
                width: width,
                height: height,
              ),
              width: width,
              height: height,
              fit: fit,
            ),
          )
        : Image.file(
            File(file.path),
            errorBuilder: (context, _, __) => assetImage(
              ImageEnum.error,
              width: width,
              height: height,
            ),
            width: width,
            height: height,
            fit: fit,
          );

String gender(int? genderId) => genderId == 1
    ? 'Male'
    : genderId == 2
        ? 'Female'
        : 'Family';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

Future<bool?> getBoolPref(PrefEnum key) =>
    sharedPrefs().then((pref) => pref.getBool(ets(key)));

Future<double?> getDoublePref(PrefEnum key) =>
    sharedPrefs().then((pref) => pref.getDouble(ets(key)));

Future<int?> getIntPref(PrefEnum key) =>
    sharedPrefs().then((pref) => pref.getInt(ets(key)));

Future<String?> getStringPref(PrefEnum key) =>
    sharedPrefs().then((pref) => pref.getString(ets(key)));

String greeting() {
  final hour = DateTime.now().hour;
  return hour < 12
      ? 'Good Morning'
      : hour >= 12 && hour < 14
          ? 'Good Afternoon'
          : 'Good Evening';
}

HexColor hexColor(String code) =>
    HexColor(code.contains('#') ? code : '#$code');

Future navigate(
  BuildContext context, {
  required PageEnum page,
  bool replace = false,
  Object? extra,
}) =>
    replace
        ? Future.sync(() => context.pushReplacement(
              '/${ets(page)}',
              extra: extra,
            ))
        : context.push(
            '/${ets(page)}',
            extra: extra,
          );

navigateAndReplaceAll(
  BuildContext context, {
  required PageEnum page,
  Object? extra,
}) =>
    context.go(
      '/${ets(page)}',
      extra: extra,
    );

Widget netImage(
  String? url, {
  double? width,
  double? height,
  BoxFit? fit,
  double? radius,
  Widget? errorWidget,
}) =>
    radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              url ?? errorImageUrl,
              errorBuilder: (context, _, __) =>
                  errorWidget ??
                  assetImage(
                    ImageEnum.error,
                    width: width,
                    height: height,
                  ),
              width: width,
              height: height,
              fit: fit,
            ),
          )
        : Image.network(
            url ?? errorImageUrl,
            errorBuilder: (context, _, __) =>
                errorWidget ??
                assetImage(
                  ImageEnum.error,
                  width: width,
                  height: height,
                ),
            width: width,
            height: height,
            fit: fit,
          );

bool notNull(dynamic content) => content != null;

String number(
  num number, {
  String? unit,
  String? pluralUnit,
  int? doubleFix,
}) =>
    number == number.toInt()
        ? '${number.toInt().toString()}${unit == null ? '' : ' ${number == 1 ? unit : pluralUnit ?? '${unit}s'}'}'
        : '${doubleFix != null ? number.toStringAsFixed(doubleFix) : number.toString()}${unit == null ? '' : ' ${number == 1 ? unit : pluralUnit ?? '${unit}s'}'}';

ChangeNotifier provider<ChangeNotifier>(BuildContext context) =>
    context.read<ChangeNotifier>();

Future<bool> removePref(PrefEnum key) =>
    sharedPrefs().then((prefs) => prefs.remove(ets(key)));

Future<Respo> respo(
  EndPointEnum endPointEnum, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  required BuildContext context,
  MethodEnum? method,
  Map<String, dynamic>? headers,
  bool setAccessToken = false,
  bool? showProgress,
}) async {
  final popupProvider = provider<PopupProvider>(context);
  final initHeaders = headers ?? {};

  try {
    initHeaders.addAll({
      'Accept': 'application/json',
      if (setAccessToken)
        'Authorization': 'Bearer ${await getStringPref(PrefEnum.accesstoken)}',
    });
    final dio = Dio(BaseOptions(
      baseUrl: '$baseUrl/',
      headers: initHeaders,
    ));
    final endPoint = endPointMap[endPointEnum] ?? '';

    final onSendProgress = showProgress != null && showProgress
        ? (sent, total) =>
            popupProvider.setSentProgress(total != 0 ? sent / total : 0.0)
        : null;
    final onReceiveProgress = showProgress != null && !showProgress
        ? (receive, total) => popupProvider
            .setReceivedProgress(total != 0 ? receive / total : 0.0)
        : null;

    final response = method == MethodEnum.delete
        ? await dio.delete(
            endPoint,
            data: data,
            queryParameters: queryParameters,
          )
        : method == MethodEnum.patch
            ? await dio.patch(
                endPoint,
                data: data,
                queryParameters: queryParameters,
                onSendProgress: onSendProgress,
                onReceiveProgress: onReceiveProgress,
              )
            : method == MethodEnum.post
                ? await dio.post(
                    endPoint,
                    data: data,
                    queryParameters: queryParameters,
                    onSendProgress: onSendProgress,
                    onReceiveProgress: onReceiveProgress,
                  )
                : method == MethodEnum.put
                    ? await dio.put(
                        endPoint,
                        data: data,
                        queryParameters: queryParameters,
                        onSendProgress: onSendProgress,
                        onReceiveProgress: onReceiveProgress,
                      )
                    : await dio.get(
                        endPoint,
                        queryParameters: queryParameters,
                        onReceiveProgress: onReceiveProgress,
                      );

    return Respo.fromJson(response.data).setOk();
  } on DioException catch (error) {
    return Respo.fromJson(error.response?.data);
  }
}

Future<void> setPref({
  required PrefEnum key,
  required dynamic value,
}) async {
  final prefs = await sharedPrefs();
  final prefKey = ets(key);

  if (value is bool) {
    await prefs.setBool(prefKey, value);
  }
  if (value is double) {
    await prefs.setDouble(prefKey, value);
  }
  if (value is int) {
    await prefs.setInt(prefKey, value);
  }
  if (value is String) {
    await prefs.setString(prefKey, value);
  }
  if (value is List<String>) {
    await prefs.setStringList(prefKey, value);
  }
}

Future<SharedPreferences> sharedPrefs() => SharedPreferences.getInstance();

String textOrEmpty(String? text) => text?.trim() ?? '';

String? textOrNull(String? text) => text?.trim();
