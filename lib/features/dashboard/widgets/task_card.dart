import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:performer/providers/task_provider.dart';
import 'package:performer/utils/attribute.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/primary_text.dart';

class TaskCard extends StatelessWidget {
  final StatusEnum status;
  const TaskCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inf,
      height: 150.0,
      child: InkWell(
        onTap: () => navigate(
          context,
          page: PageEnum.task,
          extra: status,
        ),
        child: Card(
          color: status == StatusEnum.status0
              ? Colors.blue
              : status == StatusEnum.status1
                  ? Colors.amber
                  : status == StatusEnum.status2
                      ? success
                      : status == StatusEnum.status3
                          ? hexColor('#15910F')
                          : error,
          shape: rrBorder(10.0),
          child: Stack(
            children: [
              Positioned(
                right: -100.0,
                bottom: -100.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: -200.0,
                right: -50.0,
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white.withOpacity(0.2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: status,
                          child: PrimaryText(
                            status == StatusEnum.status0
                                ? 'Todo'
                                : status == StatusEnum.status1
                                    ? 'Ongoing'
                                    : status == StatusEnum.status2
                                        ? 'Performer Completed'
                                        : status == StatusEnum.status3
                                            ? 'Supervisor Completed'
                                            : 'Rejected',
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Expanded(
                          child: assetImage(
                            status == StatusEnum.status0
                                ? ImageEnum.todo
                                : status == StatusEnum.status1
                                    ? ImageEnum.ongoing
                                    : status == StatusEnum.status2
                                        ? ImageEnum.pcompleted
                                        : status == StatusEnum.status3
                                            ? ImageEnum.scompleted
                                            : ImageEnum.rejected,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<TaskProvider>(
                          builder: (context, taskData, _) => PrimaryText(
                            status == StatusEnum.status0
                                ? taskData.taskCount.pending_status.toString()
                                : status == StatusEnum.status1
                                    ? taskData.taskCount.todo_status.toString()
                                    : status == StatusEnum.status2
                                        ? taskData.taskCount
                                            .performer_completed_status
                                            .toString()
                                        : status == StatusEnum.status3
                                            ? taskData
                                                .taskCount.supervisor_completed
                                                .toString()
                                            : taskData.taskCount.rejected_status
                                                .toString(),
                            color: white,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        const PrimaryText(
                          'TASKS',
                          color: white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
