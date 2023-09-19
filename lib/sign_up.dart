import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
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
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'null value';
                      } else if (value.length < 5) {
                        return 'email must be more than 5 char';
                      } else if (!value.contains('@')) {
                        return 'email must contain @';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusColor: Colors.black87,
                      hintText: 'example@example.com',
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    obscureText: true,
                    // controller: _emailCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'null value';
                      } else if (value.length < 5) {
                        return 'password must be more than 5 char';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: '*******',
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.black87,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'null value';
                      } else if (value.length < 5) {
                        return 'password must be more than 5 char';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: '*******',
                      labelText: 'Confirm',
                      labelStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.black87,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  // color: Colors.black,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as desired
                      ),
                    ),
                    onPressed: () {
                      // ! is the null check operator
                      if (formKey.currentState!.validate()) {
                        print('======= Email => ${_emailCtrl.text}');
                      } else {
                        print('=========== form not valid ===========');
                      }
                    },
                    child: Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
