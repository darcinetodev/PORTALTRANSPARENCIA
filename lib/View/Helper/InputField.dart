import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.hint, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            errorText: snapshot.hasError ? snapshot.error : null
          ),
          style: TextStyle(fontSize: 20)
        );
      },
    );
  }
}