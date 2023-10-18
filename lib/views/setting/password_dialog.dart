import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_data.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({super.key});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return AlertDialog(
      title: Text('Enter the new password'),
      insetPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: TextFormField(
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            maxLength: 20,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordCtrl,
            validator: (value) {
              if (value == null) {
                return 'password is required';
              } else if (value.length < 3) {
                return 'password must be more than 3 char';
              } else {
                return null;
              }
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              userData.changeUserPass(_passwordCtrl.text);
            }
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
