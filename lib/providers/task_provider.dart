import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisor/models/performer.dart';
import 'package:supervisor/models/init_task.dart';
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
  var _isLoading = false;
  final _checkedTypes = <int>[];
  final _availableTypes = <TaskType>[];
  final _performers = <Performer>[];
  final _tasks = <Task>[];
  int? _selectedPerformerId;
  double _rate = 0.0;
  XFile? _selectedFile;

  bool get isLoading => _isLoading;
  List<int> get checkedTypes => _checkedTypes;
  List<TaskType> get availableTypes => _availableTypes;
  List<Performer> get performers => _performers;
  List<Task> get tasks => _tasks;
  int? get selectedPerformerId => _selectedPerformerId;
  XFile? get selectedFile => _selectedFile;

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

  void approveTask(
    BuildContext context, {
    required int taskId,
    required StatusEnum status,
    required TextEditingController descriptionController,
    String? description,
  }) {
    confirm(
      context,
      confirmMessage: 'Would you like to approve this task now?',
      onConfirm: () => waiting(
        context,
        futureTask: () => completeTaskAPI(
          context,
          taskId: taskId,
          rate: _rate,
          selectedFile: _selectedFile,
          description: descriptionController.text.trim(),
        ),
        afterTask: (isOk) {
          resetCompleting();
          if (isOk) {
            pop(context);
            loadTasks(
              context,
              status: status,
            );
          }
          notify(
            context,
            message:
                isOk ? 'Task completed successfully.' : 'Failed to complete!',
            messageColor: isOk ? success : error,
          );
        },
      ),
    );
  }

  void asignTask(
    BuildContext context, {
    required InitTask initTask,
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
          initTask: initTask,
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

  void loadPerformers(BuildContext context) async {
    _performers.clear();
    _performers.addAll(await getPerformersAPI(context));
    notifyListeners();
  }

  void loadTasks(
    BuildContext context, {
    required StatusEnum status,
  }) async {
    _tasks.clear();
    setLoading(true);
    _tasks.addAll(await getAllTasksAPI(
      context,
      status: status,
    ));
    setLoading(false);
  }

  void loadTaskTypes(
    BuildContext context, {
    required InitTask initTask,
  }) async {
    _availableTypes.clear();
    _availableTypes.addAll(await getTaskTypesAPI(
      context,
      initTask: initTask,
    ));
    notifyListeners();
  }

  void reset() {
    if (_availableTypes.isNotEmpty) _availableTypes.clear();
    if (_checkedTypes.isNotEmpty) _checkedTypes.clear();
    if (_performers.isNotEmpty) _performers.clear();
    if (_tasks.isNotEmpty) _tasks.clear();
    _selectedPerformerId = null;
  }

  void resetCompleting() {
    _selectedFile = null;
    _rate = 0.0;
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
          final initTask = InitTask.fromJson(json.decode(qrData));
          popup(
            context,
            outTapDismissible: false,
            title: const PrimaryText(
              'Assigning',
              color: black,
            ),
            content: AsignBody(initTask),
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
                    extra: initTask,
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

  void selectVideo(BuildContext context) {
    if (notNull(selectedFile)) {
      _selectedFile = null;
      notifyListeners();
    } else {
      ImagePicker().pickVideo(source: ImageSource.camera).then((xfile) {
        if (notNull(xfile)) {
          _selectedFile = xfile;
        } else {
          notify(
            context,
            message: 'You\'ve nothing recorded!',
            messageColor: warn,
          );
        }
        notifyListeners();
      });
    }
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setRate(double rate) => _rate = rate;
}
