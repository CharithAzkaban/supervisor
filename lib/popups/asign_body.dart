import 'package:flutter/material.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_text.dart';

class AsignBody extends StatelessWidget {
  final Task task;
  const AsignBody(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            'Floor: ${task.floorId}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          PrimaryText(
            'Gender: ${gender(task.genderId)}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          PrimaryText(
            'Washroom: ${task.washroomId}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          const Divider(),
          const PrimaryText(
            'Available tasks',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          const Gap(vGap: 5.0),
          ...(task.tasks ?? []).map(
            (type) => Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    color: black,
                    size: 18.0,
                  ),
                  Expanded(
                    child: PrimaryText(
                      type.taskTypeName,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
