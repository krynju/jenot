import 'dart:async';

import 'package:flutter/material.dart';
import 'strings.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.senderName, this.text, this.animationController});

  final String senderName;
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: senderName == mainUserName
            ? _buildSent(context)
            : _buildReceived(context));
  }

  Widget _buildReceived(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(mainUserName[0])),
          ),
          new Expanded(
            child: new Container(
              padding: const EdgeInsets.only(right: 50.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(senderName,
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption),
                  new Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(15)),
                    ),
                    margin: const EdgeInsets.only(top: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSent(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: const EdgeInsets.only(left: 80.0),
              child: new Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(senderName,
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption),
                  new Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[800],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(0)),
                    ),
                    margin: const EdgeInsets.only(top: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    child:
                    new Text(text, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final String recipientName;
  bool _isComposing = false;

  ChatScreenState({this.recipientName});

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: (text) => _handleSubmitted(mainUserName, text),
                  decoration: new InputDecoration.collapsed(
                      hintText: "Wyślij wiadomość"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                      ? () =>
                      _handleSubmitted(mainUserName, _textController.text)
                      : null,
                ),
              )
            ],
          )),
    );
  }

  void _handleSubmitted(String senderName, String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      senderName: senderName,
      text: text,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 700)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
    if (senderName == mainUserName) {
      Timer(Duration(seconds: 3), () {
        _handleSubmitted(recipientName, "Cześć!");
      });

      Timer(Duration(seconds: 4), () {
        _handleSubmitted(recipientName, "Widziałeś już nowy projekt ustawy?");
      });
    }
  }


  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  @override
  Widget build(BuildContext context) {
    final partyIndex = names.indexOf(recipientName) % 4;
    final partystr = partiesAssets[partyIndex];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(recipientName),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: new Image(image: AssetImage(partiesAssets[partyIndex]),
                fit: BoxFit.fitWidth,
                width: 40),
          ),

        ],
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length)),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String recipientName;

  ChatScreen({this.recipientName});

  @override
  State createState() => new ChatScreenState(recipientName: recipientName);
}
