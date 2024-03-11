import 'package:flutter/material.dart';
import 'package:supervisor/models/performer.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

Future<bool> asignTaskAPI(
  BuildContext context, {
  required Task task,
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
        "task_issued_user_id": issuedUserId,
        "task_assigned_user_id": assignedUserId,
        "task_category_id": 1,
        "task_floor": task.floorId,
        "task_washroom": task.washroomId,
        "gender": task.genderId,
        "task_ids": selectedTypes,
        "other_type": otherTypes,
      },
    ).then((response) async {
      final isSuccess = response.success;
      notify(
        context,
        message: isSuccess
            ? 'Task assigned successfully.'
            : 'Task assigning failed!',
        messageColor: isSuccess ? success : error,
      );
      return isSuccess;
    });

Future<List<Performer>> getPerformersAPI(BuildContext context) => respo(
      EndPointEnum.performers,
      method: MethodEnum.post,
      setAccessToken: true,
      context: context,
    ).then((response) async {
      if (response.success) {
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
