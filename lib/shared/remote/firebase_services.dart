import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/task_model.dart';
import '../../models/user_data_model.dart';

class FirebaseServices {

 // this function creates a collection called tasks && withConverter provide the operations of translating from and to json

 static CollectionReference<TaskModel> get getTasksCollection => getUserCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks').withConverter<TaskModel>(
  fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
      TaskModel.fromJson(snapshot.data() ?? {}),
  toFirestore: (TaskModel value, _) => value.toJson(),
 );
 static CollectionReference<UserDataModel> get getUserCollection => FirebaseFirestore.instance.collection('users').withConverter<UserDataModel>(
  fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
      UserDataModel.fromJson(snapshot.data() ?? {}),
  toFirestore: (UserDataModel value, _) => value.toJson(),
 );

 // this function adds a task , you will stand on collection you make , and add a document

 static Future<void> addTask(TaskModel task)
 {
  CollectionReference<TaskModel> tasksCollection = getTasksCollection;
  DocumentReference<TaskModel> docReference = tasksCollection.doc();
  task.id = docReference.id ;
  return  docReference.set(task);
 }

// this function delete a task by its id

 static Future<void> deleteTask(String id)
 {
  CollectionReference<TaskModel> tasksCollection = getTasksCollection;
  return tasksCollection.doc(id).delete();
 }

 // this function receive the tasks from firebase

 // static Future<List<TaskModel>> getTasks()async
 // {
 //  CollectionReference<TaskModel> tasksCollection = getTasksCollection;
 //  QuerySnapshot<TaskModel> taskQuery =   await tasksCollection.get();
 //  return taskQuery.docs.map((e) => e.data(),).toList();
 // }

 // this function filters tasks by date
 static Future<List<TaskModel>> getTasksByDate(DateTime selectedDate)async
 {
  CollectionReference<TaskModel> tasksCollection = getTasksCollection;
  QuerySnapshot<TaskModel> taskQuery =   await tasksCollection.where('date',isEqualTo: Timestamp.fromDate(selectedDate)).get();
  return taskQuery.docs.map((e) => e.data(),).toList();
 }

 // this function to login
 static Future<UserDataModel?> login(String email , String password)async
 {
  UserCredential credential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  print('======>${FirebaseAuth.instance.currentUser!.uid}');
  print('======>${credential.user!.uid}');
  return getUser();
 }


 // this function to login
 static Future<UserDataModel> register(UserDataModel userDataModel,String? password)async
 {
  UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userDataModel.email!, password: password!);
  print('======>${FirebaseAuth.instance.currentUser!.uid}');
  print('======>${credential.user!.uid}');
  userDataModel.id = credential.user!.uid;
  await createUser(userDataModel);
  return userDataModel;
 }

 static Future<UserDataModel?> getUser()async {
  DocumentSnapshot<UserDataModel> documentSnapshot = await getUserCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
  return  documentSnapshot.data();

 }

 static Future<void> updateTask(String taskId, TaskModel updatedTask) async {
  final tasksCollection = getTasksCollection;
  await tasksCollection.doc(taskId).update(updatedTask.toJson());
 }


 static Future<void> createUser(UserDataModel userDataModel) async {
  return await getUserCollection.doc(userDataModel.id).set(userDataModel);
 }
 static Future<void> logout()async
 {
  await FirebaseAuth.instance.signOut();
 }
}
