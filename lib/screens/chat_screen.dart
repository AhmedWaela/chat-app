import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/messaage_model.dart';
import '../widgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key, required this.email});
  static String id = 'ChatPage';
  final scrollController = ScrollController();
  final String email;

  final CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email  = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').orderBy('date',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error retrieving messages');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Message> messagesList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/scholar.png', height: 50),
                const Text('Chat', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse:  true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      return message.id == email
                          ? ChatBuble(message: message)
                          : ChatBubleForFreinds(message: message); // Assuming widget exists
                    },),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      messages.add({
                        'message': value.trim(),
                        'date': DateTime.now(),
                        'id': email
                      });
                      controller.clear();
                      scrollController.animateTo(
                        0,
                        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn

                      );
                    } else {
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
        ]
          )
          );
      },
    );
  }
}
