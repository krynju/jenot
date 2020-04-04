import 'package:flutter/material.dart';
import 'chat.dart';
import 'strings.dart';

class ContactScreen extends StatefulWidget {
  @override
  State createState() => new ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(title: new Text("Kontakty")),
        body: _buildListView());
  }

  Widget _buildListView() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i > names.length - 1) return null;
      return _buildRow(names[i]);
    });
  }

  Widget _buildRow(String name) {
    final partyIndex = names.indexOf(name) % 4;
    return Card(
      child: ListTile(
        title: Text(name),
        leading: new CircleAvatar(child: new Text(name[0])),
        onTap: () => openChat(name),
        subtitle: Text(parties[partyIndex]),
        trailing: new Image(image: AssetImage(partiesAssets[partyIndex]),
          fit: BoxFit.fitWidth,
          width: 50,),
      ),
    );
  }

  void openChat(String recipientName) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ChatScreen(recipientName: recipientName);
    }));
  }
}
