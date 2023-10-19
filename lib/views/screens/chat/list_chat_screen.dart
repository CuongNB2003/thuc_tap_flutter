import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_flutter/views/screens/chat/chat_screen.dart';
import 'package:thuc_tap_flutter/views/widgets/my_item_chat.dart';
import 'package:thuc_tap_flutter/views/widgets/my_loading.dart';
import 'package:thuc_tap_flutter/views/widgets/my_text_field_send.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _searchUser = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            MyTextFieldSend(
              controller: _searchUser,
              hintText: 'Enter name to search',
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.blue,
              ),
              onTap: () {

              },
              messOrSearch: false,
            ),
            const SizedBox(height: 30),
            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoading(
            withLoading: 50,
            heightLoading: 50,
            color: Colors.blue,
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return MyItemChat(
        imageUrl:
            'https://www.vietnamfineart.com.vn/wp-content/uploads/2023/03/hinh-anh-co-gai-cute-anime-8-min-4.jpg',
        title: data['name'],
        content: data['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  receiveUserEmail: data['email'],
                  receiveUserID: data['uid'],
                  receiveUserName: data['name'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}