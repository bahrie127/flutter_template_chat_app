import 'package:flutter/material.dart';
import 'package:trial_chat/pages/login_page.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Firebase Chat App',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 25,
                child: Text('${index + 1}',
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text('Chat ${index + 1}'),
              subtitle: const Text('Last message'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ChatPage();
                }));
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }
}
