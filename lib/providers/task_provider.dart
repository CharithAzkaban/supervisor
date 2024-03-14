import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:supervisor/models/performer.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/models/task_type.dart';
import 'package:supervisor/popups/asign_body.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/services/task_services.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/popup_action.dart';
import 'package:supervisor/widgets/primary_text.dart';

class TaskProvider extends ChangeNotifier {
  final _checkedTypes = <int>[];
  final _availableTypes = <TaskType>[];
  final _performers = <Performer>[];
  int? _selectedPerformerId;

  List<int> get checkedTypes => _checkedTypes;
  List<TaskType> get availableTypes => _availableTypes;
  List<Performer> get performers => _performers;
  int? get selectedPerformerId => _selectedPerformerId;

  void addOrRemoveType(
    int? typeId, {
    required bool isAdding,
  }) {
    if (isAdding && notNull(typeId) && !_checkedTypes.contains(typeId)) {
      _checkedTypes.add(typeId!);
    } else {
      _checkedTypes.remove(typeId);
    }
    notifyListeners();
  }

  void asignTask(
    BuildContext context, {
    required Task task,
    required GlobalKey<FormState> formKey,
    required String? otherTypes,
  }) {
    if (_checkedTypes.isEmpty) {
      notify(
        context,
        message: 'At least one task should be selected!',
        messageColor: error,
      );
    }
    if (formKey.currentState!.validate()) {
      waiting(
        context,
        futureTask: () => asignTaskAPI(
          context,
          task: task,
          issuedUserId: provider<AuthProvider>(context).user?.id,
          assignedUserId: _selectedPerformerId,
          selectedTypes: _checkedTypes,
          otherTypes: otherTypes,
        ),
        afterTask: (isOk) {
          if (isOk) {
            pop(context);
          }
        },
      );
    }
  }

  void loadPerformers(BuildContext context, {re}) async {
    _performers.clear();
    _performers.addAll(await getPerformersAPI(context));
    notifyListeners();
  }

  void loadTaskTypes(
    BuildContext context, {
    required Task task,
  }) async {
    _availableTypes.clear();
    _availableTypes.addAll(await getTaskTypesAPI(
      context,
      task: task,
    ));
    notifyListeners();
  }

  void reset() {
    _availableTypes.clear();
    _checkedTypes.clear();
    _performers.clear();
    _selectedPerformerId = null;
  }

  Future<void> scanQr(BuildContext context) async {
    FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.QR,
    ).then((qrData) {
      if (qrData == '-1') {
        notify(
          context,
          message: 'Camera permission denied!',
        );
      } else {
        try {
          final task = Task.fromJson(json.decode(qrData));
          popup(
            context,
            outTapDismissible: false,
            title: const PrimaryText(
              'Assigning',
              color: black,
            ),
            content: AsignBody(task),
            actions: [
              PopupAction(
                onPressed: () => pop(context),
                color: error,
                label: 'DISMISS',
              ),
              PopupAction(
                onPressed: () {
                  pop(context);
                  navigate(
                    context,
                    page: PageEnum.asign,
                    extra: task,
                  );
                },
                color: primary,
                label: 'ASIGN',
              ),
            ],
          );
        } on FormatException catch (_) {
          notify(
            context,
            message: 'Invalid QR has been scanned!',
            messageColor: error,
          );
        }
      }
    });
  }

  void selectPerformer(int? performerId) => _selectedPerformerId = performerId;
}
