import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../show_snack_bar.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;
  String? confirmPassword;

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
                      'Register',
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
                  validatorValue: 'Please enter your email',
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  validatorValue: 'Please enter your password',
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  validatorValue: 'Please repeat your password',
                  onChanged: (data) {
                    confirmPassword = data;
                  },
                  hintText: 'Confirm Password',
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

                      if (password != confirmPassword) {
                        showSnackBar(context, 'Passwords Don\'t Match');
                        return;
                      }

                      try {
                        final userCredential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        await userCredential.user!.sendEmailVerification();
                        formKey.currentState!.reset();
                        showSnackBar(context, 'Registration Successful');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak Password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email Already Exists');
                        } else {
                          showSnackBar(context, 'Sign Up Error');
                        }
                      } catch (e) {
                        showSnackBar(context, 'Unexpected Error');
                      }
                      saving = true;
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
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
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
  Future<void> registrationMethod() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    showSnackBar(context, 'success');
  }
}
