import 'package:flutter/material.dart';
import 'package:ninjain/models/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Ninja-In',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _nameCtrl,
                    validator: (value) {
                      RegExp regExp =
                          RegExp(r'^[a-zA-Z0-9_\-.@$!#%&+أ-ي٠-٩]*$');
                      if (value == null) {
                        return 'user name is required';
                      } else if (value.length < 3) {
                        return 'user name must be more than 3 char';
                      } else if (value.length > 20) {
                        return 'user name must be less than 20 char';
                      } else if (!regExp.hasMatch(value)) {
                        return 'invali characters or space';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorLight),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'User name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailCtrl,
                    validator: (value) {
                      RegExp emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (value == null) {
                        return 'email is required';
                      } else if (value.length < 10) {
                        return 'email must be more than 10 char';
                      } else if (!value.contains('@')) {
                        return 'email must contain @';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'invalid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'password is required';
                      } else if (value.length < 3) {
                        return 'password must be more than 5 char';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Confirm is required';
                      } else if (value.length < 3) {
                        return 'password must be more than 5 char';
                      } else if (value != _passwordCtrl.text) {
                        return 'confirm not match';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Confirm',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColorDark,
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/login',
                          arguments: AppUser(
                              uName: _nameCtrl.text,
                              uEmail: _emailCtrl.text,
                              uPassword: _passwordCtrl.text),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
