import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:productos_app/screens/Friends_Chat.dart';
import 'package:productos_app/utils/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Homechat extends StatefulWidget {
  @override
  _HomechatState createState() => _HomechatState();
}

class _HomechatState extends State<Homechat> {
  final _usernameController = TextEditingController();
  String _usernameError = '';
  bool _loading = false;

  get channel => null;

  Future<void> _onGoPressed() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      final user = client.state.currentUser;
      if (user == null) {
        setState(() {
          _loading = true;
        });
        await client.connectUser(
            User(
                id: username,
                extraData: {'image': DataUtils.getUserImage(username)}),
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidXNlcm5hbWUifQ.koAOsR1n1tcHq2bWIDiw9k7qvgogzKwV5ucYntksIvk');
        setState(() {
          _loading = false;
        });
      }
      final channel = client.channel('messaging', id: 'flutterdevs');
      await channel.watch();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FriendsChat(client: client, channel: channel),
        ),
      );
    } else {
      setState(() {
        _usernameError = 'el usuario no es valido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = StreamChat.of(context).client;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Card(
                elevation: 11,
                margin: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Bienvenido al chat'),
                      if (client.state.currentUser == null)
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'username',
                            errorText: _usernameError,
                          ),
                        )
                      else
                        Text('Bienvenido: ${client.state.currentUser!.id}'),
                      ElevatedButton(
                        onPressed: _onGoPressed,
                        child: Text('Vamos'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
