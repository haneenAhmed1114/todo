import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/task_model.dart';
import 'package:todo_application/shared/reusable_components/task_card.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  EasyInfiniteDateTimelineController controller = EasyInfiniteDateTimelineController();
  DateTime selectedDate = DateTime.now();
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<TaskProvider>(context,listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EasyInfiniteDateTimeLine(
            onDateChange: (selectedDate) {
              focusDate=selectedDate;
              setState(() {});
            },
            showTimelineHeader: false,
            firstDate: DateTime(2024),
            lastDate: DateTime(2025),
            focusDate: focusDate,
            dayProps: EasyDayProps(
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(color: Theme.of(context).colorScheme.primary,width: 2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                dayStrStyle: Theme.of(context).textTheme.labelLarge,
                dayNumStyle: Theme.of(context).textTheme.labelLarge,
                monthStrStyle: Theme.of(context).textTheme.labelLarge,
              ),
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                dayStrStyle: Theme.of(context).textTheme.labelSmall,
                dayNumStyle: Theme.of(context).textTheme.labelSmall,
                monthStrStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
        FutureBuilder<List<TaskModel>>(
          future: provider.getTasksByDate(focusDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return Expanded(
                child: Center(child: Text('An error occurred: ${snapshot.error}')),
              );
            }
            // Handle cases where snapshot data is null or empty
            final List<TaskModel>? data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Expanded(
                child: Center(child: Text('No tasks today')),
              );
            }
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: data.length,
                itemBuilder: (context, index) => TaskCard(taskModel: data[index]),
              ),
            );
          },
        ),

      ],
    );
  }
}