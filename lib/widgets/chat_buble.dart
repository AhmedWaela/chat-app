import 'package:chat_app/models/messaage_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,bottom: 32,right: 32,top: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),topRight: Radius.circular(36)),
          color: kPrimaryColor,
        ),
        child: Text(message.message,style: TextStyle(color: Colors.white,
        ),),
      ),
    );
  }
}


class ChatBubleForFreinds extends StatelessWidget {
  const ChatBubleForFreinds({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,bottom: 32,right: 32,top: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),topRight: Radius.circular(36)),
          color: Colors.orange,
        ),
        child: Text(message.message,style: TextStyle(color: Colors.white,
        ),),
      ),
    );
  }
}