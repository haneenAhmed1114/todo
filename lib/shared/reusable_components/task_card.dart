import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/modules/home_screen/edit_screen.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';
import 'package:todo_application/shared/utils/app_assets.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          extentRatio: 0.6,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(taskModel.id);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(10.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            SlidableAction(
              onPressed: (context) async {
                Navigator.of(context).pushNamed(
                  EditScreen.routeName,
                  arguments: taskModel,
                );
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(10.0),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Container(
            width: 4,
            height: 62,
            color: Theme.of(context).primaryColor,
          ),
          title: Consumer<TaskProvider>(
            builder: (context, provider, child) {
              final task = provider.tasks.firstWhere(
                    (task) => task.id == taskModel.id,
                orElse: () => taskModel, // Fallback to the current taskModel
              );
              return Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                taskModel.taskName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: task.isCompleted! ? Colors.green : Colors.black,
                ),
              );
            },
          ),
          trailing: InkWell(
            onTap: () {
              Provider.of<TaskProvider>(context, listen: false).toggleTaskCompletion(taskModel.id);
            },
            child: Container(
              width: 69,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ImageIcon(
                AssetImage(AppAssets.checkIcon),
                color: AppColors.whiteAppColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
