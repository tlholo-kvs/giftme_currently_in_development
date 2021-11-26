import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DbHelper2{

CollectionReference rCollection = FirebaseFirestore.instance.collection("Requests");
CollectionReference rCollection2 = FirebaseFirestore.instance.collection("Reviewed Requests");

User rUser = FirebaseAuth.instance.currentUser;
User rUser2 = FirebaseAuth.instance.currentUser;

  Future<String> add({String title, String description}) async
  {

    try{
      String formateDate = DateFormat.jm().format(DateTime.now());
      final rData = {
        'title': title,
        'description': description,
        'time': formateDate,
      };

      rCollection.doc(rUser.uid).collection('Requests').add(rData);

      return 'Request Sent';
    }catch(e) {
      return e.toString();
    }


  }

  Future<String> add2({String id,String title, String description}) async
  {

    try{
      String formateDate = DateFormat.jm().format(DateTime.now());
      final rData = {
        'title': title,
        'description': description,
        'time': formateDate,
      };

      rCollection2.doc(rUser2.uid).collection('Review Requests').add(rData);

      return 'Request Sent';
    }catch(e) {
      return e.toString();
    }


  }

  Future<String> delete({String id,String title, String desciption}) async {

  try{
    

    rCollection.doc(rUser.uid).collection('Requests').doc(id).delete();

    return '  ';
  } catch (e) {
    return e.toString();
  }



}

Future<String> delete2({String id,String title, String desciption}) async {

  try{
    

    rCollection2.doc(rUser.uid).collection('Reviewed Requests').doc(id).delete();

    return 'Item Donated Deleted  ';
  } catch (e) {
    return e.toString();
  }



}

}