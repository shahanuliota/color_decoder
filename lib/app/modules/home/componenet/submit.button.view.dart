import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    this.onTap,
    this.title = 'Submit',
    required this.focusNode,
  }) : super(key: key);
  final Function()? onTap;
  final FocusNode focusNode;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap == null ? const Color(0xff21211a) : const Color(0xff00224c),
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        focusNode: focusNode,
        onTap: onTap,
        focusColor: onTap != null ? Colors.greenAccent : null,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
