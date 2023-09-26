import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final int typeOfValidation;
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  const MyForm({
    super.key,
    required this.typeOfValidation,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  late TextEditingController _controller;
  bool _isValid = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    switch (widget.typeOfValidation) {
      case 1:
        _controller.addListener(_checkNameValidity);
        break;
      case 2:
        _controller.addListener(_checkEmailValidity);
        break;
      case 3:
        _controller.addListener(_checkPasswordValidity);
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkNameValidity() {
    final input = _controller.text;
    String error = '';
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_\-.@$!#%&+أ-ي٠-٩]*$');

    if (input.isEmpty) {
      error = 'Username is required';
    } else if (input.length < 3) {
      error = 'Username must be more than 3 characters';
    } else if (input.length > 20) {
      error = 'Username must be less than 20 characters';
    } else if (!regExp.hasMatch(input)) {
      error = 'Invalid characters or spaces';
    }

    setState(() {
      _isValid = error.isEmpty;
      _errorText = error.isNotEmpty ? error : null;
    });
  }

  void _checkEmailValidity() {
    final input = _controller.text;
    String error = '';
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_\-.@$!#%&+أ-ي٠-٩]*$');

    if (input.isEmpty) {
      error = 'null value';
    } else if (input.length < 5) {
      error = 'email must be more than 5 char';
    } else if (!input.contains('@')) {
      error = 'email must contain @';
    }

    setState(() {
      _isValid = error.isEmpty;
      _errorText = error.isNotEmpty ? error : null;
    });
  }

  void _checkPasswordValidity() {
    final input = _controller.text;
    String error = '';
    if (input.isEmpty) {
      error = 'null value';
    } else if (input.length < 5) {
      error = 'password must be more than 5 char';
    }

    setState(() {
      _isValid = error.isEmpty;
      _errorText = error.isNotEmpty ? error : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = _isValid ? Theme.of(context).primaryColor : Colors.red;
    final borderColor = _isValid ? Theme.of(context).primaryColor : Colors.red;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: widget.typeOfValidation == 2
                ? TextInputType.emailAddress
                : TextInputType.text,
            obscureText: widget.typeOfValidation == 3 ? true : false,
            controller: _controller,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: labelColor),
              labelText: widget.typeOfValidation == 1
                  ? 'Username'
                  : widget.typeOfValidation == 2
                      ? 'Email'
                      : 'Password',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: borderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          Text(
            _errorText ?? '',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
