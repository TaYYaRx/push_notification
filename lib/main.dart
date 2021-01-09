import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  @override
  void initState() {
    super.initState();
    _initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Icon(Icons.notifications),
          onPressed: showNotification,
        ),
      ),
    );
  }

  Future showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        'Channel ID', 'TaYYaR', 'Hello',
        importance: Importance.max);
    var iOSDetails = IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterNotificationPlugin.show(
        0, 'Hourly Event', 'All Hero Development', generalNotificationDetails);
  }

  void _initNotification() {
    var initSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initSettingsIOS = IOSInitializationSettings();

    var initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    //Notification'a tıkladıgında olacak şey
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('PAYLOAD'),
              content: Text('Your payload is : $payload'),
            ));
  }

  /**
   * Payload : Notification messages can contain an optional data that is known as payload
   */
}
