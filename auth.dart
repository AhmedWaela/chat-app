//
// import 'package:chat_app/screens/chat_screen.dart';
// import 'package:chat_app/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class Auth extends StatelessWidget {
//   const Auth({super.key, required this.email});
//   static String id = 'auth';
//   final String email;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.hasData) {
//             return  ChatPage();
//           } else {
//             return const LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }