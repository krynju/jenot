import 'package:flutter/material.dart';
import 'pin.dart';
import 'chat.dart';
import 'vote.dart';
import 'contacts.dart';
import 'strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Jenot',
        theme: ThemeData(
            fontFamily: 'Georgia',
            primaryColor: Colors.white,
            brightness: Brightness.light,
            accentColor: Colors.lightBlue[50]),
        home: PinWidget(
          correct_pin: '6969',
          proceed_to: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
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
    final partyIndex = names.indexOf(mainUserName) % 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(mainUserName, textAlign: TextAlign.center,),
        actions: <Widget>[
          new Image(image: AssetImage(partiesAssets[partyIndex]),
              fit: BoxFit.fitWidth,
              width: 40),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                    children: <Widget>[
//                  Expanded(flex: 3,child: Container(child: Image(image: AssetImage('images/profile.png'),,),)),
                      Expanded(
                          flex: 3,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('images/profile.png'),)),
                            ),
                          )
                      ),
                      Expanded(flex: 1, child: Text('Witaj w aplikacji Jenot')),
                    ],
                  )),
            ),
            _buildCard('images/sejm.jpg', "Głosuj", () => openVote),
            _buildCard('images/talking.jpg', "Konwersacje", () => openContacts)
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String title, Function() open) {
    return Expanded(
      child: InkWell(
        onTap: open(),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imagePath), fit: BoxFit.cover)),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 3.0,
                  ))
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
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
