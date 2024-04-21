import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:performer/features/dashboard/widgets/task_card.dart';
import 'package:performer/providers/auth_provider.dart';
import 'package:performer/providers/task_provider.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/gap.dart';
import 'package:performer/widgets/primary_icon_button.dart';
import 'package:performer/widgets/primary_text.dart';
import 'package:performer/widgets/side_panel.dart';

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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _taskProvider.setTaskCount(context));
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: RefreshIndicator(
          onRefresh: () async => _taskProvider.setTaskCount(context),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                TaskCard(
                  status: StatusEnum.status0,
                ),
                Gap(vGap: 10.0),
                TaskCard(
                  status: StatusEnum.status1,
                ),
                Gap(vGap: 10.0),
                TaskCard(
                  status: StatusEnum.status2,
                ),
                Gap(vGap: 10.0),
                TaskCard(
                  status: StatusEnum.status3,
                ),
                Gap(vGap: 10.0),
                TaskCard(
                  status: StatusEnum.status4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
