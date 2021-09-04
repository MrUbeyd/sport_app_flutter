import 'package:flutter/material.dart';
import 'package:sport_app/components/text_field_container.dart';
import 'package:sport_app/constants.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;

  final ValueChanged<String> onChanged;
  const RoundedInput({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
