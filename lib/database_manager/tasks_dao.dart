import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:future_task_management_app/database_manager/model/task.dart';
import 'package:future_task_management_app/database_manager/user_dao.dart';

class TasksDao {
  static CollectionReference<Task> getTasksCollection(String uid) {
    var usersCollection = UserDao.getUsersCollection();
    var userDoc = usersCollection.doc(uid);
    return userDoc.collection('Tasks').withConverter<Task>(
      fromFirestore: (snapshot, options) =>
          Task.fromFireStore(snapshot.data()),
      toFirestore: (task, options) => task.toFireStore(),
    );
  }

  static Future<void> addTaskToFireStore(String uid, Task task) {
    var tasksCollection = getTasksCollection(uid);
    var taskDoc = tasksCollection.doc(); // id auto generated
    task.taskId = taskDoc.id;
    return taskDoc.set(task);
  }

  static Future<List<Task>> getData(String uid) async {
    var tasksCollection = getTasksCollection(uid);
    var querySnapShot = await tasksCollection.get();
    return querySnapShot.docs
        .map(
          (queryDocSnapShot) => queryDocSnapShot.data(),
    )
        .toList();
  }

  // static StreamSubscription<QuerySnapshot<Task>> getDataRealTimeUpdates(String uid) async* {
  //   var tasksCollection = getTasksCollection(uid); // getCollection
  //   var tasksList = await tasksCollection.snapshots().listen(
  //         (querySnapShot) => querySnapShot.docs
  //             .map(
  //               (taskSnapShot) => taskSnapShot.data(),
  //             )
  //             .toList,
  //       );
  //   yield* tasksList.;
  // }

  static Stream<List<Task>> getDataRealTime(
      String uid, DateTime selectedDate) async* {
    var tasksCollection =
    getTasksCollection(uid).where('dateTime', isEqualTo: selectedDate);
    var queryTaskSnapShot = tasksCollection.snapshots();
    var tasksList = queryTaskSnapShot.map(
          (taskSnapShot) => taskSnapShot.docs
          .map(
            (tasksDoc) => tasksDoc.data(),
      )
          .toList(),
    );
    yield* tasksList;
  }

  static Future<void> delete(String uid, String taskId) {
    var tasksCollection = getTasksCollection(uid);
    return tasksCollection.doc(taskId).delete();
  }

  static Future<void> edit(String uid, Task task){
    var tasksCollection = getTasksCollection(uid);
    var taskDoc = tasksCollection.doc(task.taskId);
    return taskDoc.set(task);

  }

  static Future<void> taskDone(String uid, Task task) {
    var tasksCollection = getTasksCollection(uid);
    var taskDoc = tasksCollection.doc(task.taskId);
    task.isDone = true;
    return taskDoc.update({
      'isDone':task.isDone
    });
  }
}