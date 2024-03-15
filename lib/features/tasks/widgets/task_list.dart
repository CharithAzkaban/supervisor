import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supervisor/providers/task_provider.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/no_data.dart';

import 'task_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskData, _) {
        final tasks = taskData.tasks;
        return taskData.isLoading
            ? const NoData('Loading tasks...')
            : tasks.isEmpty
                ? const NoData('No tasks available!')
                : ListView.separated(
                    itemBuilder: (_, index) => TaskWidget(tasks[index]),
                    separatorBuilder: (_, __) => const Gap(vGap: 5.0),
                    itemCount: tasks.length,
                  );
      },
    );
  }
}
