import 'package:add_to_cart_api/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  final String? hintText;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  final onTap;

  MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      this.onTap,
      this.onChanged})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obsecure_text = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenStateMangement>(
      builder: (context, value, child) {
        return TextFormField(
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: obsecure_text,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obsecure_text = !obsecure_text;
                });
              },
              child: Icon(
                obsecure_text ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
            ),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.teal, width: 3),
            ),
          ),
        );
      },
    );
  }
}
