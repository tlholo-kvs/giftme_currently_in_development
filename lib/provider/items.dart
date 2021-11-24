import 'package:firebase_database/firebase_database.dart';

class Item {
  String key;
  String description;
  String title;

  Item(this.description, this.title);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["Title"],
        description = snapshot.value['Description'];

  toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
