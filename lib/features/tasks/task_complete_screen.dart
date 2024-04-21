import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:performer/models/task.dart';
import 'package:performer/providers/task_provider.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/back.dart';
import 'package:performer/widgets/gap.dart';
import 'package:performer/widgets/primary_button.dart';
import 'package:performer/widgets/primary_text.dart';
import 'package:performer/widgets/primary_tff.dart';

class TaskCompleteScreen extends StatefulWidget {
  final GoRouterState state;
  const TaskCompleteScreen(this.state, {super.key});

  @override
  State<TaskCompleteScreen> createState() => _TaskCompleteScreenState();
}

class _TaskCompleteScreenState extends State<TaskCompleteScreen> {
  late final TaskProvider _taskProvider;
  late final Task _task;
  late final StatusEnum _status;
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskProvider = provider<TaskProvider>(context);
    _task = widget.state.extra as Task;
    _status = StatusEnum.values.firstWhere(
        (element) => element.name.contains(_task.taskStatus.toString()));
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _taskProvider.loadTasks(
        context,
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: PrimaryButton(
            onPressed: () => _taskProvider.approveTask(
              context,
              taskId: _task.id,
              status: _status,
              descriptionController: _descriptionController,
            ),
            label: 'APPROVE',
            width: double.infinity,
          ),
        ),
        appBar: AppBar(
          backgroundColor: primary,
          leading: const Back(),
          title: const PrimaryText(
            'Evaluation',
            color: white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  PrimaryText(
                    '${_task.assignedFname} ${_task.assignedLname}',
                    textAlign: TextAlign.center,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                  const Gap(vGap: 10.0),
                  PrimaryText(
                    date(
                      _task.createdAt,
                      format: 'dd MMM yyyy, hh:mm a',
                    ),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                  const Gap(vGap: 10.0),
                  PrimaryText(
                    'Cleaning F${_task.taskFloor}-${_task.taskCategoryId == 1 ? 'W' : 'B'}${_task.taskWashroom}',
                    color: black,
                    fontSize: 16.0,
                  ),
                  const Gap(vGap: 10.0),
                  PrimaryText(
                    _task.description ?? 'No description available!',
                    textAlign: TextAlign.center,
                    fontSize: 16.0,
                    color: grey.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                  const Gap(vGap: 20.0),
                  PrimaryTFF(
                    controller: _descriptionController,
                    maxLines: 3,
                    labelText: 'Description',
                  ),
                  const Gap(vGap: 20.0),
                  Consumer<TaskProvider>(
                    builder: (context, taskData, _) {
                      final videoNotNull = notNull(taskData.selectedFile);
                      return PrimaryButton(
                        width: inf,
                        onPressed: () => taskData.selectVideo(context),
                        outlined: true,
                        icon: Icon(
                          videoNotNull
                              ? Icons.video_file
                              : Icons.video_camera_back_outlined,
                          color: primary,
                        ),
                        label: videoNotNull ? 'REMOVE VIDEO' : 'ADD VIDEO',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
