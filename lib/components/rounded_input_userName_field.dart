import 'package:flutter/material.dart';
import 'package:sport_app/components/text_field_container.dart';
import 'package:sport_app/constants.dart';

class RoundedInputUserNameField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputUserNameField({
    Key key,
    this.hintText,
    this.icon = Icons.alternate_email_rounded,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
