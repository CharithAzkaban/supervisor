import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supervisor/features/dashboard/widgets/task_card.dart';
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
  late final TaskProvider _taskProvider;

  @override
  void initState() {
    super.initState();
    _taskProvider = provider<TaskProvider>(context);
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
            icon: Consumer<AuthProvider>(
              builder: (context, authData, _) => netImage(
                authData.user?.userImage,
                errorWidget: assetImage(
                  ImageEnum.profile,
                  radius: 50.0,
                ),
                radius: 50.0,
              ),
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
            Consumer<AuthProvider>(
              builder: (context, authData, _) => PrimaryText(
                '${authData.user?.userFirstName}',
                color: white,
              ),
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
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TaskCard(
                status: StatusEnum.status0,
                tasks: 3,
              ),
              Gap(vGap: 10.0),
              TaskCard(
                status: StatusEnum.status1,
                tasks: 4,
              ),
              Gap(vGap: 10.0),
              TaskCard(
                status: StatusEnum.status2,
                tasks: 6,
              ),
              Gap(vGap: 10.0),
              TaskCard(
                status: StatusEnum.status3,
                tasks: 7,
              ),
              Gap(vGap: 10.0),
              TaskCard(
                status: StatusEnum.status4,
                tasks: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
