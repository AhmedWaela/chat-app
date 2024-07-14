import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../auth.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  bool saving = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontFamily: 'font',
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      email = value;
                    },
                    validatorValue: 'please enter your email',
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      password = value;
                    },
                    validatorValue: 'please enter your email',
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        saving = true;
                        setState(() {

                        });
                        if (!email!.endsWith('@gmail.com')) {
                          showSnackBar(context, 'Invalid Email');
                          return;
                        }
                        try {
                          final userCredential =
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );

                          if (userCredential.user!.emailVerified) {
                            formKey.currentState!.reset();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ChatPage(email: email!,);
                            },));
                          } else {
                            showSnackBar(context, 'Email Not Verified');
                          }
                        } on FirebaseAuthException catch (e) {
                          final list =
                          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email!);
                          String message;
                          if (list.isEmpty) {
                            message = 'The email address you entered does not exist.';
                          } else {
                            message = 'An error occurred during sign in. Please try again.';
                          }
                          showSnackBar(context, message);
                        } catch (e) {
                          showSnackBar(context, 'Unexpected Error');
                        }
                        saving = false;
                        setState(() {

                        });
                      }

                    },
                    buttonText: 'Register',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Future<void> signInMethod() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);

  }
}
