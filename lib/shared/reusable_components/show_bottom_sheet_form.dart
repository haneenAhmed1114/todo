import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/shared/reusable_components/custom_elevated_button.dart';
import 'package:todo_application/shared/reusable_components/custom_text_field.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';
import 'package:todo_application/shared/utils/app_colors.dart';
import 'package:todo_application/shared/utils/app_styles.dart';

class ShowBottomSheetForm extends StatefulWidget {
  const ShowBottomSheetForm({super.key});

  @override
  State<ShowBottomSheetForm> createState() => _ShowBottomSheetFormState();
}

class _ShowBottomSheetFormState extends State<ShowBottomSheetForm> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDetailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateFormat dateFormat = DateFormat('yy/MM/dd');
  bool isLoading = false ;
  var date ;

  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<TaskProvider>(context,listen: false);
    return Padding(
      padding:  EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
        bottom:  MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                  'Add New Task',
                  style: AppStyles.bottomSheetHeaderLight,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0 ,
                ),
                child: CustomTextField(
                    controller: taskNameController,
                    hint: 'enter your task',
                    type: TextInputType.text,
                  validator: (p0) {
                      if(p0 == null || p0 =='')
                        {
                          return 'task name cannot be empty' ;
                        }
                      else if(p0.length<5)
                        {
                          return 'task name cannot be less than 5 ';
                        }
                      else
                        {
                          return null ;
                        }
                  },
                   ),
              ),
              CustomTextField(
                  controller: taskDetailController ,
                  hint: 'enter task detail',
                  type: TextInputType.text,
                  maxLines:2,
                validator: (p0) {
                  if(p0 == null || p0 =='')
                  {
                    return 'task detail cannot be empty' ;
                  }
                  else if(p0.length<5)
                  {
                    return 'task detail cannot be less than 5 ';
                  }
                  else
                  {
                    return null ;
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text(
                    'Select Date : ',
                    style:  TextStyle(
                      color: AppColors.kohliAppColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async
                         {
                    date = await showDatePicker(context: context,
                        firstDate: DateTime.now(),
                        initialDate: selectedDate,
                        lastDate: DateTime.now().add(const Duration(days: 200),),);
                        if(date!=null)
                         {
                          selectedDate = DateTime(date.year,date.month , date.day) ;
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
              CustomElevatedButton(
                text: isLoading ? 'Loading....' :  'Add',
                onPressed: isLoading ? null : ()async
                {
                if(formKey.currentState!.validate()==true)
                  {
                    TaskModel newTask = TaskModel(taskName: taskNameController.text.trim(), taskDetails: taskDetailController.text.trim(), date: selectedDate as DateTime);
                    setState(() {
                      isLoading = true ;
                    });
                   await provider.addTask(newTask);
                   Navigator.of(context).pop();
                    setState(() {
                      isLoading = false ;
                    });
                  }
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
