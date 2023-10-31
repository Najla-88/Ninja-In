import 'package:flutter/material.dart';
import 'package:ninjain/models/user_model.dart';

import '../../repositories/user_repository.dart';

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
  bool isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final user = Users();

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
                      } else if (!regExp.hasMatch(value)) {
                        return 'invali characters or space';
                      }
                      return null;
                    },
                    maxLength: 30,
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
                    maxLength: 30,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
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
                    obscureText: _obscurePassword,
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
                    maxLength: 20,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
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
                    obscureText: _obscureConfirm,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                      labelText: 'Confirm',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: isLoading
                      ? Visibility(
                          visible: isLoading,
                          child: const CircularProgressIndicator(),
                        )
                      : TextButton(
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              user.name = _nameCtrl.text;
                              user.email = _emailCtrl.text;
                              user.password = _passwordCtrl.text;
                              Users apiUser =
                                  await UserRepository().signup(user);
                              if (apiUser.name != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                  arguments: Users(
                                      name: _nameCtrl.text,
                                      email: _emailCtrl.text,
                                      password: _passwordCtrl.text),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "User name or email is already exist"),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: const Text('Submit'),
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
