import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextInputType input;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.hint,
              this.obscure,
              this.input,
              this.stream,
              this.onChanged
            });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: snapshot.hasError ? Colors.red : Colors.white,
                               width: snapshot.hasError ? 2 : 0),
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: TextField(
                  keyboardType: input,
                  obscureText: obscure,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                  ),
                  style: TextStyle(fontSize: 18)
                ),
              ),
            ),
          );
      },
    );
  }
}