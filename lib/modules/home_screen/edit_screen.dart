import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/modules/home_screen/home_screen.dart';
import 'package:todo_application/shared/remote/firebase_services.dart';
import 'package:todo_application/shared/utils/app_colors.dart';
import '../../models/task_model.dart';
import '../../shared/reusable_components/task_provider.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'editScreen';
  final TaskModel task;

  const EditScreen({super.key, required this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var date;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  DateTime? selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateFormat dateFormat = DateFormat('yy/MM/dd');

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.taskName;
    detailsController.text = widget.task.taskDetails;
    selectedDate = widget.task.date;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorLight,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Edit your Task',
                    style:  TextStyle(
                      color: AppColors.blackAppColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'task title cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Task Details',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'task title cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Text(
                        'Select Date : ',
                        style: TextStyle(
                          color: AppColors.kohliAppColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: selectedDate,
                            lastDate: DateTime.now().add(
                              const Duration(days: 200),
                            ),
                          );
                          if (date != null) {
                            selectedDate =
                                DateTime(date.year, date.month, date.day);
                            setState(() {});
                          }
                        },
                        child: Text(
                          //  selectedDate.toString().split(' ')[0],
                          dateFormat.format(selectedDate as DateTime),
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.kohliAppColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        TaskModel updatedTask = TaskModel(
                          id: widget.task.id,
                          taskName: titleController.text,
                          taskDetails: detailsController.text,
                          date: selectedDate!,
                        );

                        try {
                          await FirebaseServices.updateTask(
                            widget.task.id,
                            updatedTask,
                          );
                          print(' the id ======>${FirebaseAuth.instance.currentUser!.uid}');
                          Provider.of<TaskProvider>(context, listen: false).fetchTasks(FirebaseAuth.instance.currentUser!.uid);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Task updated successfully')),
                          );
                          Navigator.of(context).pop();
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to update task: $error')),
                          );
                        }
                      }
                    },
                    child: const Text('Save Changes'),
                  ),


                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (formKey.currentState!.validate()) {
                  //
                  //       TaskModel updatedTask = TaskModel(
                  //         id: widget.task.id,
                  //         taskName: titleController.text,
                  //         taskDetails: detailsController.text,
                  //         date: selectedDate!,
                  //       );
                  //       FirebaseServices.updateTask(FirebaseAuth.instance.currentUser!.uid, updatedTask);
                  //     }
                  //   },
                  //   child: const Text('Save Changes'),
                  // ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      const Text('Back to edited Task '),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popAndPushNamed(HomeScreen.routeName);
                          },
                          icon: const Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 30.0,
                            color: AppColors.blackAppColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}
