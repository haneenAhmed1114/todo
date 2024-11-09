import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/shared/utils/app_colors.dart';
import '../remote/firebase_services.dart';

class TaskProvider with ChangeNotifier
{
  List<TaskModel> tasks =[];
  DateTime selectedDate = DateTime.now();
  Future<List<TaskModel>> getTasksByDate(DateTime selectedDate) async {
    try {
      final List<TaskModel> allTasks = await FirebaseServices.getTasksByDate(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      );
      print('Focus Date: $selectedDate');
      print('Tasks Retrieved: ${allTasks.length}');

      tasks = allTasks.isEmpty ? [] : allTasks;
      return tasks;
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Failed to load tasks: ${error.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.redAppColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }




  Future<void> addTask(TaskModel newTask)async
  {
    try
    {
      await FirebaseServices.addTask(newTask).timeout(const Duration(seconds: 2),onTimeout: () async{

      },);

    }
    catch(error)
    {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.redAppColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  deleteTask(String taskId)async
  {
   try {
      await FirebaseServices.deleteTask(taskId).then((value) {
        Fluttertoast.showToast(
            msg: 'Task Is Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:AppColors.redAppColor,
            textColor: Colors.white,
            fontSize: 16.0
        );
      },);
    }
    catch(error)
    {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:AppColors.redAppColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> editTask(String taskId, TaskModel updatedTask) async {
    try {
      await FirebaseServices.updateTask(taskId, updatedTask);
      Fluttertoast.showToast(
        msg: 'Task updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.greenAppColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await getTasksByDate(selectedDate);
      notifyListeners();
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.redAppColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> fetchTasks(String userId) async {
    tasks = await FirebaseServices.getTasksByDate(DateTime.now());
    notifyListeners();
  }
  void toggleTaskCompletion(String taskId) async {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex].isCompleted = !(tasks[taskIndex].isCompleted ?? false);
      await FirebaseServices.updateTask(taskId, tasks[taskIndex]);
      notifyListeners();
    }
  }


}

