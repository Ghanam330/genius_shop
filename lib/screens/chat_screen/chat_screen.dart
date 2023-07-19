import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {

  final  textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getMessages(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No messages available.'),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final content = message['content'] as String? ?? '';


                    return ListTile(
                      title: Text(content),
                      subtitle: Text(message['sender']),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                 Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Implement sending message logic
                    final messageContent = textEditingController.text;
                    sendMessage(messageContent);
                    textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void sendMessage(String messageContent) {
  final messagesRef = FirebaseFirestore.instance.collection('messages').doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("userMessages");

  messagesRef.add({
    'sender': 'User',
    'content': messageContent,
    'timestamp': Timestamp.now(),
  }).then((value) {

    // Message sent successfully
    // You can perform any additional actions here
  }).catchError((error) {
    // An error occurred while sending the message
    // Handle the error as desired
  });
}
Stream<QuerySnapshot> getMessages() {
  CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("userMessages");
  return messagesRef.orderBy('timestamp', descending: true).snapshots();
}
