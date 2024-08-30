import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:future_task_management_app/database_manager/model/user.dart';

class UserDao {
  static CollectionReference<User> getUsersCollection() {
    var db = FirebaseFirestore.instance;
    return db.collection('Users').withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(User user) {
    var userCollection = getUsersCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async {
    var usersCollection = getUsersCollection();
    var docRef = usersCollection.doc(uid);
    var snapShot = await docRef.get();
    return snapShot.data(); // this func return user
  }
}
