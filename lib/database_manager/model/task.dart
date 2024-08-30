import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? taskId;
  String? title;
  String? description;
  Timestamp? dateTime;
  bool? isDone;

  Task(
      {this.taskId,
      this.title,
      this.description,
      this.dateTime,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic>? data)
      : this(
          taskId: data?['id'],
          title: data?['title'],
          description: data?['description'],
          dateTime: data?['dateTime'],
          isDone: data?['isDone'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': taskId,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'isDone': isDone,
    };
  }
}
