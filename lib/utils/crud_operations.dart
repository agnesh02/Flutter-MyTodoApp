import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_riverpod/models/common.dart';

import '../models/todo.dart';

class CrudOperations {
  Future<void> logTodo(String email, Todo todoData) async {
    CollectionReference collectionReference =
        Common.firebaseFirestoreInstance.collection(email);

    try {
      Map<String, dynamic> todoMap = {
        "title": todoData.taskTitle,
        "description": todoData.taskDescription,
        "category": todoData.taskCategory,
        "date": todoData.date,
        "time": todoData.time,
        "priority": todoData.taskPriority,
        "isCompleted": todoData.isCompleted,
      };
      await collectionReference.add(todoMap);
      DocumentReference documentReference = collectionReference.doc("STAT");
      DocumentSnapshot snapshot = await documentReference.get();
      int inProgressCount = snapshot.get("inProgress");
      await documentReference.update({"inProgress": inProgressCount + 1});
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Todo>> getTodos() async {
    Query todoQuery = Common.firebaseFirestoreInstance
        .collection(Common.email)
        .orderBy('title');

    List<Todo> listOfTodos = [];

    try {
      QuerySnapshot querySnapshot = await todoQuery.get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var document in documents) {
        if (document.id != 'STAT') {
          String id = document.id;
          String title = document['title'];
          String description = document['description'];
          int category = document["category"];
          String date = document["date"];
          String time = document["time"];
          int priority = document["priority"];
          bool isCompleted = document["isCompleted"];
          final todoItem = Todo(
            taskId: id,
            taskTitle: title,
            taskDescription: description,
            taskCategory: category,
            date: date,
            time: time,
            taskPriority: priority,
            isCompleted: isCompleted,
          );
          listOfTodos.add(todoItem);
        }
      }
      return listOfTodos;
    } catch (e) {
      print('Error getting data from Firestore: $e');
      return listOfTodos;
    }
  }

  Future<void> updateCompletionStatus(
      String email, String docId, bool isCompleted) async {
    DocumentReference docRef =
        Common.firebaseFirestoreInstance.collection(email).doc(docId);
    await docRef.update({
      "isCompleted": isCompleted,
    });
  }

  Future<void> updateStat(bool isCompleted) async {
    DocumentReference documentReference =
        Common.firebaseFirestoreInstance.collection(Common.email).doc("STAT");
    DocumentSnapshot snapshot = await documentReference.get();
    int completedCount = snapshot.get("completed");
    int inProgressCount = snapshot.get("inProgress");
    if (isCompleted) {
      completedCount++;
      inProgressCount--;
    } else {
      completedCount--;
      inProgressCount++;
    }
    await documentReference
        .update({"completed": completedCount, "inProgress": inProgressCount});
  }

  Future<Map<String, int>> getStats() async {
    DocumentReference documentReference =
        Common.firebaseFirestoreInstance.collection(Common.email).doc("STAT");
    DocumentSnapshot snapshot = await documentReference.get();
    int completedCount = snapshot.get("completed");
    int inProgressCount = snapshot.get("inProgress");
    int allCount = completedCount + inProgressCount;
    return {
      "all": allCount,
      "completed": completedCount,
      "inProgress": inProgressCount
    };
  }

  Future<void> deleteTodo(String docId) async {
    DocumentReference documentReference =
        Common.firebaseFirestoreInstance.collection(Common.email).doc(docId);
    await documentReference.delete();
  }
}
