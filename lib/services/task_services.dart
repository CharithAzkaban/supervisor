import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/models/performer.dart';
import 'package:supervisor/models/init_task.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/models/task_count.dart';
import 'package:supervisor/models/task_type.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

Future<bool> asignTaskAPI(
  BuildContext context, {
  required InitTask initTask,
  required int? issuedUserId,
  required int? assignedUserId,
  required List<int> selectedTypes,
  required String? otherTypes,
}) =>
    respo(
      EndPointEnum.addtasks,
      method: MethodEnum.post,
      setAccessToken: true,
      context: context,
      data: {
        'task_issued_user_id': issuedUserId,
        'task_assigned_user_id': assignedUserId,
        'task_category_id': 1,
        'task_floor': initTask.floorId,
        'task_washroom': initTask.washroomId,
        'gender': initTask.genderId,
        'task_ids': selectedTypes,
        'other_type': otherTypes,
      },
    ).then((response) async {
      final isSuccess = response.ok;
      notify(
        context,
        message: isSuccess
            ? 'Task assigned successfully.'
            : 'Task assigning failed!',
        messageColor: isSuccess ? success : error,
      );
      return isSuccess;
    });

Future<bool> completeTaskAPI(
  BuildContext context, {
  required int taskId,
  required double rate,
  XFile? selectedFile,
  String? description,
}) =>
    respo(
      EndPointEnum.completetask,
      context: context,
      data: FormData.fromMap({
        'video_url': selectedFile != null
            ? MultipartFile.fromFileSync(selectedFile.path)
            : null,
        'task_id': taskId,
        'description': description,
        'rate': rate,
        'status': 3,
      }),
      setAccessToken: true,
      method: MethodEnum.post,
    ).then((response) => response.ok);

Future<List<Task>> getAllTasksAPI(
  BuildContext context, {
  required StatusEnum status,
}) =>
    respo(
      EndPointEnum.alltasks,
      data: {
        'task_type_id': int.parse(status.name.replaceFirst('status', '')),
        'user_id': provider<AuthProvider>(context).user?.id,
      },
      method: MethodEnum.post,
      setAccessToken: true,
      context: context,
    ).then((response) async {
      if (response.ok) {
        final List taskList = response.data;
        return taskList.map((task) => Task.fromJson(task)).toList();
      }
      notify(
        context,
        messageColor: error,
        message: 'ERROR CODE: TASK-002',
      );
      return [];
    });

Future<List<Performer>> getPerformersAPI(BuildContext context) => respo(
      EndPointEnum.performers,
      method: MethodEnum.post,
      setAccessToken: true,
      context: context,
    ).then((response) async {
      if (response.ok) {
        final List performerList = response.data;
        return performerList
            .map((performer) => Performer.fromJson(performer))
            .toList();
      }
      notify(
        context,
        messageColor: error,
        message: 'ERROR CODE: TASK-001',
      );
      return [];
    });

Future<TaskCount> getTaskCountAPI(BuildContext context) => respo(
      EndPointEnum.taskcount,
      data: {'user_id': provider<AuthProvider>(context).user?.id},
      context: context,
      setAccessToken: true,
      method: MethodEnum.post,
    ).then((response) => response.ok
        ? TaskCount.fromJson(response.data)
        : TaskCount(
            pending_status: 0,
            todo_status: 0,
            performer_completed_status: 0,
            supervisor_completed: 0,
            rejected_status: 0,
          ));

Future<List<TaskType>> getTaskTypesAPI(
  BuildContext context, {
  required InitTask initTask,
}) =>
    respo(
      EndPointEnum.tasktypes,
      data: {
        'gender_id': initTask.genderId,
        'floor_id': initTask.floorId,
        'washroom_id': initTask.washroomId,
      },
      method: MethodEnum.post,
      setAccessToken: true,
      context: context,
    ).then((response) async {
      if (response.ok) {
        final List taskTypeList = response.data['tasks'];
        return taskTypeList
            .map((taskType) => TaskType.fromJson(taskType))
            .where((element) => element.id != 6)
            .toList();
      }
      notify(
        context,
        messageColor: error,
        message: response.message ?? 'ERROR CODE: TASK-002',
      );
      return [];
    });
