import 'package:flutter/material.dart';
import 'package:performer/models/init_task.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/primary_text.dart';

class AsignBody extends StatelessWidget {
  final InitTask initTask;
  const AsignBody(this.initTask, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            'Floor: ${initTask.floorId}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          PrimaryText(
            'Gender: ${gender(initTask.genderId)}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          PrimaryText(
            'Washroom: ${initTask.washroomId}',
            color: black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
