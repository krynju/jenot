import 'package:flutter/material.dart';
import 'chat.dart';

class ContactScreen extends StatefulWidget {

    @override
    State createState() => new ContactScreenState();

}

class ContactScreenState extends State<ContactScreen> {
    final List<String> _names = <String>['Jarek','Darek','Czarek'];

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return new Scaffold(
            appBar: new AppBar(title: new Text("Contacts")),
            body: _buildListView()
        );
    }

    Widget _buildListView() {
        return ListView.builder(itemBuilder: (BuildContext _context, int i) {
            if (i > _names.length-1) return null;
            return _buildRow(_names[i]);
        });
    }

    Widget _buildRow(String pair) {
        return ListTile(
            title: Text(pair
            ),
            onTap: () => openChat(pair),
        );
    }

    void openChat(String recipientName) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
            return ChatScreen(recipientName: recipientName);
        }));
    }
}