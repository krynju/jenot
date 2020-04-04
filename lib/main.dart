import 'package:flutter/material.dart';
import 'pin.dart';
import 'chat.dart';
import 'vote.dart';
import 'contacts.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Jenot',
      theme: ThemeData(
        primaryColor: Colors.white,

          brightness: Brightness.light,
        accentColor: Colors.lightBlue[50]
      ),
      home: PinWidget(
        correct_pin: '6969',
        proceed_to: MyHomePage(title: 'Flutter Demo Home Page'),
      )
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            IconButton(icon: Icon(Icons.assessment), onPressed: openVote),
            IconButton(icon: Icon(Icons.contacts), onPressed: openContacts),
          ],
        ),
      ),
    );
  }

  void openChat() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ChatScreen();
    }));
  }
  void openContacts() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ContactScreen();
    }));
  }

  void openVote() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return VoteWidget();
    }));
  }
}
