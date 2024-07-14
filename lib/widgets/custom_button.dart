import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Center(child: Text(buttonText)),
      ),
    );
  }
}
