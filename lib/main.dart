import 'package:final_application/provider/local_notification_service.dart';
import 'package:final_application/screens/AuthScreen/plashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(App());
  LocalNotificationServices.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic('item added');
}

// FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// //This method will be used to subscribe a user to the item added topic
// void fcmSubscribe() {
//   firebaseMessaging.subscribeToTopic('item added');
// }

// //This method will be used to unsubscribe a user to the item added topic
// void fcmUnSubscribe() {
//   firebaseMessaging.unsubscribeFromTopic('item added');
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    //onMessage only works if the app is in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      //This piece of code allows us to verify on the console that we
      //have received a notification and to get an instance of the notification
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }

      LocalNotificationServices.display(message);
    });

    //onMessageOpenedApp only works when the app is in the background but
    //is still open and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //this will allow the app to receive a route from the message data,
      //and take the user to the specified route in the notification
      final routeFromMessage = message.data["route"];
      print(routeFromMessage);

      //Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Splash();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

//receive message when the app is in the background
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}
