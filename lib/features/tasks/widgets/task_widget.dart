import 'package:flutter/material.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/utils/attribute.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_text.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget(
    this.task, {
    super.key,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late final StatusEnum status;

  @override
  void initState() {
    super.initState();
    status = StatusEnum.values.firstWhere(
        (element) => element.name.contains(widget.task.taskStatus.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inf,
      height: 150.0,
      child: InkWell(
        onTap: () => navigate(
          context,
          page: PageEnum.taskcomplete,
          extra: widget.task,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            '${widget.task.assignedFname} ${widget.task.assignedLname}',
                            color: white,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          PrimaryText(
                            date(
                              widget.task.createdAt,
                              format: 'dd MMM yyyy, hh:mm a',
                            ),
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                          const Gap(vGap: 5.0),
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
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          '${widget.task.gender == 1 ? 'Male' : widget.task.gender == 2 ? 'Female' : 'Family'}\n${widget.task.category}',
                          color: white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        PrimaryText(
                          'Floor ${widget.task.taskFloor}',
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
