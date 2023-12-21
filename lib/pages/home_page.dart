import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial_chat/data/datasources/firebase_datasource.dart';
import 'package:trial_chat/pages/login_page.dart';

import '../data/models/user_model.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
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
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return const LoginPage();
                // }));
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
          stream: FirebaseDatasource.instance.allUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<UserModel> users = (snapshot.data ?? [])
                .where((element) => element.id != currentUser!.uid)
                .toList();
            //if user is null
            if (users.isEmpty) {
              return const Center(
                child: Text('No user found'),
              );
            }
            return ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: Text(users[index].userName[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(users[index].userName),
                    subtitle: const Text('Last message'),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ChatPage(
                          partnerUser: users[index],
                        );
                      }));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                });
          }),
    );
  }
}
