import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:performer/models/performer.dart';
import 'package:performer/models/init_task.dart';
import 'package:performer/models/task.dart';
import 'package:performer/models/task_count.dart';
import 'package:performer/models/task_type.dart';
import 'package:performer/providers/auth_provider.dart';
import 'package:performer/services/task_services.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';

class TaskProvider extends ChangeNotifier {
  var _isLoading = false;
  final _checkedTypes = <int>[];
  final _availableTypes = <TaskType>[];
  final _performers = <Performer>[];
  final _tasks = <Task>[];
  int? _selectedPerformerId;
  double _rate = 0.0;
  XFile? _selectedFile;
  var _taskCount = TaskCount(
    pending_status: 0,
    todo_status: 0,
    performer_completed_status: 0,
    supervisor_completed: 0,
    rejected_status: 0,
  );

  bool get isLoading => _isLoading;
  List<int> get checkedTypes => _checkedTypes;
  List<TaskType> get availableTypes => _availableTypes;
  List<Performer> get performers => _performers;
  List<Task> get tasks => _tasks;
  int? get selectedPerformerId => _selectedPerformerId;
  XFile? get selectedFile => _selectedFile;
  TaskCount get taskCount => _taskCount;

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
    getTaskTypesAPI(
      context,
      initTask: initTask,
    ).then((taskTypes) {
      if (taskTypes.isNotEmpty) {
        _availableTypes.addAll(taskTypes);
        notifyListeners();
      } else {
        pop(context);
      }
    });
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

  void setTaskCount(BuildContext context) async {
    _taskCount = await getTaskCountAPI(context);
    notifyListeners();
  }
}
