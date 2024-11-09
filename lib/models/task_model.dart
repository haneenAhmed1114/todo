import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
   String taskName;

   String taskDetails;

   DateTime date;

   bool isDone;

   String id ;

   bool? isCompleted;

   TaskModel(
       { this.id='',required this.taskName, required this.taskDetails, required this.date, this.isDone = false,this.isCompleted = false,});

   TaskModel.fromJson(Map<String, dynamic> json)
       : this(
      taskName: json['taskName'],
      taskDetails: json['taskDetails'],
      date: (json['date'] as Timestamp).toDate(),
      isDone: json['isDone'],
      id: json['id'],
      isCompleted: json['isCompleted'] ?? false,
   );


   Map<String, dynamic> toJson() {
      return {
         'taskName': taskName,
         'taskDetails': taskDetails,
         'date': Timestamp.fromDate(date),
         'isDone': isDone,
         'id': id,
         'isCompleted': isCompleted ?? false,
      };
   }


}
