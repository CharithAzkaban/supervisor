import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supervisor/features/asign/asign_screen.dart';
import 'package:supervisor/features/dashboard/dashboard_screen.dart';
import 'package:supervisor/features/loading/loading_screen.dart';
import 'package:supervisor/features/password/password_screen.dart';
import 'package:supervisor/features/profile/profile_screen.dart';
import 'package:supervisor/features/signin/signin_screen.dart';
import 'package:supervisor/utils/enums.dart';

import 'methods.dart';

const baseUrl = 'https://mitf.ca/api';
const errorImageUrl = 'https://static.thenounproject.com/png/504708-200.png';

const black = Colors.black;
const grey = Colors.grey;
const white = Colors.white;

final error = hexColor('#FF4650');
final primary = hexColor('#FE7702');
final secondary = hexColor('#2078E5');
const special = Colors.blueGrey;
final success = hexColor('#00BB00');
final tertiary = hexColor('#20A0E5');
final warn = hexColor('#FF8204');

const inf = double.infinity;

const dummy = SizedBox(
  width: 0.0,
  height: 0.0,
);

final goRouter = GoRouter(
  initialLocation: '/${ets(PageEnum.loading)}',
  routes: PageEnum.values
      .map(
        (page) => GoRoute(
          path: '/${ets(page)}',
          builder: (context, state) {
            switch (page) {
              case PageEnum.asign:
                return AsignScreen(state);
              case PageEnum.dashboard:
                return const DashboardScreen();
              case PageEnum.password:
                return const PasswordScreen();
              case PageEnum.profile:
                return const ProfileScreen();
              case PageEnum.signin:
                return const SigninScreen();
              default:
                return const LoadingScreen();
            }
          },
        ),
      )
      .toList(),
);

final endPointMap = {
  EndPointEnum.addtasks: 'add/tasks',
  EndPointEnum.editprofile: 'user/profile/manage',
  EndPointEnum.login: 'auth/user/login',
  EndPointEnum.performers: 'performers',
  EndPointEnum.password: 'auth/password/change',
  EndPointEnum.refreshtoken: 'refresh_token',
  EndPointEnum.tasktypes: 'get_qr_data',
};
