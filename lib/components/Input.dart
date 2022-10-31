// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label, errorText, inputValue;
  final Function textval;
  final bool passwordstatus;
  final TextInputType inputype;
  final TextInputAction nextType;
  final Color bgcolors, borderColors;
  const Input(
      {Key? key,
      this.bgcolors = Colors.white,
      this.borderColors = Colors.white,
      this.nextType = TextInputAction.next,
      this.passwordstatus = false,
      this.inputype = TextInputType.text,
      this.label = "",
      required this.textval,
      this.inputValue = "",
      this.errorText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 7),
      child: TextFormField(
        keyboardType: inputype,
        initialValue: inputValue,
        obscureText: passwordstatus,
        textInputAction: nextType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          // prefixIcon: inputIcon,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColors, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColors, width: 1.0),
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return errorText;
          }
          return null;
        },
        onSaved: (text) => textval(text),
      ),
    );
  }
}
