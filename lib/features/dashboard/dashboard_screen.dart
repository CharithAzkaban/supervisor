import 'package:flutter/material.dart';
import 'package:supervisor/features/dashboard/widgets/task_card.dart';
import 'package:supervisor/models/user.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/providers/task_provider.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_icon_button.dart';
import 'package:supervisor/widgets/primary_text.dart';
import 'package:supervisor/widgets/side_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final AuthProvider _authProvider;
  late final TaskProvider _taskProvider;
  late final User? _user;

  @override
  void initState() {
    super.initState();
    _authProvider = provider<AuthProvider>(context);
    _taskProvider = provider<TaskProvider>(context);
    _user = _authProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(context),
      appBar: AppBar(
        backgroundColor: primary,
        leading: Builder(builder: (ctx) {
          return PrimaryIconButton(
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            icon: netImage(
              _user?.userImage,
              errorWidget: assetImage(
                ImageEnum.profile,
                radius: 50.0,
              ),
              radius: 50.0,
            ),
          );
        }),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              '${greeting()},',
              color: white,
              fontSize: 12.0,
            ),
            PrimaryText(
              '${_user?.userFirstName}',
              color: white,
            ),
          ],
        ),
        actions: [
          PrimaryIconButton(
            onPressed: () => _taskProvider.scanQr(context),
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TaskCard(
                label: 'Assigned',
                color: Colors.blue,
                tasks: 3,
              ),
              const Gap(vGap: 10.0),
              const TaskCard(
                label: 'Ongoing',
                color: Colors.amber,
                tasks: 7,
              ),
              const Gap(vGap: 10.0),
              TaskCard(
                label: 'Submitted',
                color: success,
                tasks: 2,
              ),
              const Gap(vGap: 10.0),
              TaskCard(
                label: 'Rejected',
                color: error,
                tasks: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
