import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supervisor/features/tasks/widgets/task_list.dart';
import 'package:supervisor/providers/task_provider.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/back.dart';
import 'package:supervisor/widgets/primary_text.dart';

class TaskScreen extends StatefulWidget {
  final GoRouterState state;
  const TaskScreen(this.state, {super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TaskProvider _taskProvider;
  late final StatusEnum _status;

  @override
  void initState() {
    super.initState();
    _taskProvider = provider<TaskProvider>(context);
    _status = widget.state.extra as StatusEnum;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _taskProvider.loadTasks(
        context,
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leading: const Back(),
        title: Hero(
          tag: _status,
          child: PrimaryText(
            _status == StatusEnum.status0
                ? 'Todo'
                : _status == StatusEnum.status1
                    ? 'Ongoing'
                    : _status == StatusEnum.status2
                        ? 'Performer Completed'
                        : _status == StatusEnum.status3
                            ? 'Supervisor Completed'
                            : 'Rejected',
            color: white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: TaskList(),
      ),
    );
  }

  @override
  void dispose() {
    _taskProvider.reset();
    super.dispose();
  }
}
