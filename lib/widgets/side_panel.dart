import 'package:flutter/material.dart';
import 'package:supervisor/models/user.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_text.dart';

class SidePanel extends StatefulWidget {
  final BuildContext scaffoldContext;
  const SidePanel(this.scaffoldContext, {super.key});

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  late final AuthProvider _authProvider;
  late final User? _user;
  late final double _dw;

  @override
  void initState() {
    super.initState();
    _authProvider = provider<AuthProvider>(context);
    _user = _authProvider.user;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dw = dWidth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: netImage(
                _user?.userImage,
                width: _dw * 0.4,
                height: _dw * 0.4,
                radius: 500.0,
                errorWidget: assetImage(
                  ImageEnum.profile,
                  width: _dw * 0.4,
                  height: _dw * 0.4,
                  radius: 500.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PrimaryText(
                '${_user?.userFirstName} ${_user?.userLastName}',
                color: black,
                textAlign: TextAlign.center,
                fontSize: 16.0,
              ),
            ),
            const Gap(vGap: 20.0),
            const Divider(height: 1.0),
            ListTile(
              title: const PrimaryText('Edit Profile'),
              leading: const Icon(Icons.edit_rounded),
              onTap: () {
                Scaffold.of(context).closeDrawer();
              },
            ),
            const Divider(height: 1.0),
            ListTile(
              title: const PrimaryText('Change Password'),
              leading: const Icon(Icons.lock_rounded),
              onTap: () {
                Scaffold.of(context).closeDrawer();
              },
            ),
            const Divider(height: 1.0),
            ListTile(
              title: PrimaryText(
                'Log Out',
                color: error,
              ),
              leading: Icon(
                Icons.logout_rounded,
                color: error,
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                _authProvider.signout(widget.scaffoldContext);
              },
            ),
            const Divider(height: 1.0),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                children: [
                  PrimaryText(
                    'Version - 1.0.0',
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                  PrimaryText(
                    'Copyright @ 2024 by Yaalu.lk.\nAll rights reserved.',
                    color: black,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
