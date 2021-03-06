import 'package:flutter/material.dart';

class PinWidget extends StatefulWidget {
  PinWidget({
    @required this.correct_pin,
    @required this.proceed_to,
  }) : assert(correct_pin.length == 6);
  @override
  PinWidgetState createState() => PinWidgetState();
  final String correct_pin;
  final Widget proceed_to;
}

class PinWidgetState extends State<PinWidget> {
  var _pin = '';

  IconButton getDummy(){
    return IconButton(
      padding: const EdgeInsets.all(30),
      icon: Text(' ', style: TextStyle(fontSize: 20)),
    );
  }
  IconButton getButton(String label){
    return IconButton(
        padding: const EdgeInsets.all(15),
        icon: Text(label, style: TextStyle(fontSize: 25)),
        onPressed: () {
          setState(() {
            _pin = _pin+label;
            print(_pin);
            if (_pin == widget.correct_pin){
              _pushSaved();
            }
            else if (_pin.length>6){
              _pin = '';
            }
          });
        }
    );
  }
  Row pinField(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Icon(_pin.length>0? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>0? Colors.blue : Colors.black12),
        Icon(_pin.length>1? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>1? Colors.blue : Colors.black12),
        Icon(_pin.length>2? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>2? Colors.blue : Colors.black12),
        Icon(_pin.length>3? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>3? Colors.blue : Colors.black12),
        Icon(_pin.length>3? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>4? Colors.blue : Colors.black12),
        Icon(_pin.length>3? Icons.brightness_1 : Icons.brightness_1, color: _pin.length>5? Colors.blue : Colors.black12),

      ],
    );
  }
  Container my_keyboard(){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children:[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [getButton('1'), getButton('2'), getButton('3')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [getButton('4'), getButton('5'), getButton('6')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [getButton('7'), getButton('8'), getButton('9')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [getDummy(), getButton('0'), IconButton(padding: const EdgeInsets.all(30), icon: Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      setState(() {
                        _pin = '';
                        print(_pin);
                      });
                    })]
            )]
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//          title: Text('Startup Name Generator'),
//          actions: <Widget>[IconButton(icon: Icon(Icons.list, color: Colors.pink,), onPressed: _pushSaved)]
//      ),
        body: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                new Image(image: AssetImage('images/herb.png'),
                  fit: BoxFit.fitHeight,
                  width: 70,),
                Container(padding: const EdgeInsets.fromLTRB(20, 20, 20, 20), child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Jenot', style: TextStyle(fontSize: 35, fontFamily: 'Georgia'), ),
                    Text('catchy phrase',),
                  ],
                ),)

              ]
            ),
            Container(padding: const EdgeInsets.fromLTRB(40, 110, 40, 30),child:pinField(),),
            Divider(),
            my_keyboard(),
          ],
        )
    );
  }
  void _pushSaved(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          return widget.proceed_to;
        }
      )
    );

  }
}