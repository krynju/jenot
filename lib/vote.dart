import 'package:flutter/material.dart';

class VoteWidget extends StatefulWidget {
//    @required this.correct_pin,
//    @required this.proceed_to,
//  }) : assert(correct_pin.length == 4);
  @override
  VoteWidgetState createState() => VoteWidgetState();
//  final String correct_pin;
//  final Widget proceed_to;

}
class VoteWidgetState extends State<VoteWidget> {
  bool _agreed = false;
  bool _voted = false;
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('vote title'),
          content: new Text('vote description'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Container getVoteTilte(String title){
    return Container(
        child:
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text(title), IconButton(icon: Icon(Icons.info), onPressed: _showDialog)
          ]
        )
    );
  }

  Container getVoteButtons(){
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          MaterialButton(child: Text('agree'), color: Colors.greenAccent, onPressed: (){
        setState(() {
          _voted = true;
          _agreed = true;
        });
      }),
          MaterialButton(child: Text('disagree'),color: Colors.redAccent, onPressed: (){
          setState(() {
          _voted = true;
          _agreed = false;
      });
    }),
        ]
      )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Voting")),
//      appBar: AppBar(
//          title: Text('Startup Name Generator'),
//          actions: <Widget>[IconButton(icon: Icon(Icons.list, color: Colors.pink,), onPressed: _pushSaved)]
//      ),
//        body: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            getVoteTilte('Epstein killed himself'),
//            getVoteButtons(),
//          ],
//        )
      body: Column(
          children:[
            Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(20),
              //leading: IconButton(icon: Icon(Icons.info), onPressed: _showDialog),
              leading: new Image(image: AssetImage('images/herb.png'),
                fit: BoxFit.fitHeight,
                width: 60,),
              title: Text('Głosowanie korespondencyjne'),
              subtitle: Text('Głosowanie odbędzię się w formie korespondencyjnej w zwyczajnym terminie'),
            ),

          ],
        ),
      ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(

                        minWidth: 150.0,
                        height: 60.0,
                        child: OutlineButton(
                          child: const Text('ZA'),
                          onPressed: () {setState(() {_voted=true; _agreed=true;}); print(_voted); print(_agreed);},
                          borderSide: BorderSide(color: (_voted && _agreed)? Colors.blue : Colors.black12),
                        ),
                      ),
                      ButtonTheme(

                        minWidth: 150.0,
                        height: 60.0,
                        child: OutlineButton(
                          child: const Text('PRZECIW'),
                          onPressed: () {setState(() {_voted=true; _agreed=false;});},
                          borderSide: BorderSide(color: (_voted && (!_agreed))? Colors.blue : Colors.black12),
                        ),
                      ),

                    ],
                  ),
                    padding: EdgeInsets.all(20),),

                  Container(child:LinearProgressIndicator(value: 0.69,),padding: EdgeInsets.all(20),),

                  Divider(),
                  Container(child:Column(
                    children: [MaterialButton(child: const Text('Wniosek formalny'), onPressed: (){},),
                      MaterialButton(child: const Text('Sprzeciw'), onPressed: (){},),
                      MaterialButton(child: const Text('Zgłoszenie do dyskusji'), onPressed: (){},),],
                  ),padding: EdgeInsets.all(20),),

                ],
              ),
            )
    ]
      )
    );
  }




//  void _pushSaved(){
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        builder: (BuildContext context){
//          return widget.proceed_to;
//        }
//      )
//    );
//
//  }
}