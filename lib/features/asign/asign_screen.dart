import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supervisor/models/task.dart';
import 'package:supervisor/providers/task_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/back.dart';
import 'package:supervisor/widgets/drop_down.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_icon_button.dart';
import 'package:supervisor/widgets/primary_text.dart';
import 'package:supervisor/widgets/primary_tff.dart';
import 'package:supervisor/widgets/side_panel.dart';

class AsignScreen extends StatefulWidget {
  final GoRouterState state;
  const AsignScreen(this.state, {super.key});

  @override
  State<AsignScreen> createState() => _AsignScreenState();
}

class _AsignScreenState extends State<AsignScreen> {
  late final TaskProvider _taskProvider;
  late final Task _task;
  final _formKey = GlobalKey<FormState>();
  final _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskProvider = provider<TaskProvider>(context);
    _task = widget.state.extra as Task;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _taskProvider.loadPerformers(context));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(),
      child: Scaffold(
        drawer: SidePanel(context),
        appBar: AppBar(
          backgroundColor: primary,
          leading: const Back(),
          title: const PrimaryText(
            'Asigning',
            color: white,
          ),
          actions: [
            PrimaryIconButton(
              onPressed: () => _taskProvider.asignTask(
                context,
                task: _task,
                formKey: _formKey,
                otherTypes: textOrNull(_otherController.text),
              ),
              icon: const Icon(
                Icons.done_rounded,
                color: white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: PrimaryText(
                  'Floor: ${_task.floorId}',
                  color: black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SliverToBoxAdapter(
                child: PrimaryText(
                  'Gender: ${gender(_task.genderId)}',
                  color: black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SliverToBoxAdapter(
                child: PrimaryText(
                  'Washroom: ${_task.washroomId}',
                  color: black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SliverToBoxAdapter(child: Divider()),
              const SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PrimaryText(
                    'Available tasks',
                    color: black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Gap(vGap: 10.0)),
              Consumer<TaskProvider>(
                builder: (context, taskData, _) => SliverList.builder(
                  itemBuilder: (context, index) {
                    final tasks = _task.tasks ?? [];
                    final type = tasks[index];
                    return CheckboxListTile(
                      value: taskData.checkedTypes.contains(type.id),
                      title: PrimaryText(
                        type.taskTypeName,
                        color: black,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isAdding) => taskData.addOrRemoveType(
                        type.id,
                        isAdding: isAdding ?? false,
                      ),
                    );
                  },
                  itemCount: _task.tasks?.length,
                ),
              ),
              const SliverToBoxAdapter(child: Gap(vGap: 10.0)),
              SliverToBoxAdapter(
                child: PrimaryTFF(
                  controller: _otherController,
                  labelText: 'Other task (if needed)',
                  maxLines: 3,
                ),
              ),
              const SliverToBoxAdapter(child: Gap(vGap: 20.0)),
              Consumer<TaskProvider>(
                builder: (context, taskData, _) => SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: DropDown<int?>(
                      value: taskData.selectedPerformerId,
                      items: taskData.performers
                          .map(
                            (performer) => DropdownMenuItem<int?>(
                              value: performer.id,
                              child: PrimaryText(
                                performer.userFirstName,
                                color: black,
                              ),
                            ),
                          )
                          .toList(),
                      labelText: 'Select performer',
                      validator: (performerId) => !notNull(performerId)
                          ? 'A performer must be selected!'
                          : null,
                      onChanged: (performerId) =>
                          taskData.selectPerformer(performerId),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }
}
