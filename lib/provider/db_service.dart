import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DbHelper {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Donate Item');

  User user = FirebaseAuth.instance.currentUser;
//Adding Item

  Future<String> add({String title, String desciption}) async {
    try {
      String formateDate = DateFormat.jm().format(DateTime.now());
      final data = {
        'title': title,
        'description': desciption,
        'time': formateDate,
      };

      await dbCollection.doc(user.uid).collection('Donated Items').add(data);

      return 'Item Donated';
    } catch (e) {
      return e.toString();
    }
  }

//Update Item
  Future<String> update({String id, String title, String desciption}) async {
    try {
      String formateDate = DateFormat.jm().format(DateTime.now());
      final data = {
        'title': title,
        'description': desciption,
        'time': DateTime.now(),
      };

      dbCollection
          .doc(user.uid)
          .collection('Donated Items')
          .doc(id)
          .update(data);

      return 'Item Donated Updated';
    } catch (e) {
      return e.toString();
    }
  }

//Delete Item

  Future<String> delete({String id, String title, String desciption}) async {
    try {
      dbCollection.doc(user.uid).collection('Donated Items').doc(id).delete();

      return 'Item Donated Deleted';
    } catch (e) {
      return e.toString();
    }
  }
}
