import 'package:chatting_app/widgets/chat_message.dart';
import 'package:chatting_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setUpPushNotifications() async {
    final fcm= FirebaseMessaging.instance;
    await fcm.requestPermission();
    
    fcm.subscribeToTopic('chat');
    
    
  }

  @override
  void initState() {
     super.initState();
     setUpPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FunChat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(
              Icons.exit_to_app, 
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

        ],
      ),
      body: const Column(
        children:  [
          Expanded(
            child: ChatMessages()
          ),
          NewMessage(),
        ],
      ) 
    );
  }
} 