import 'package:flutter/material.dart';
import 'package:ninjain/models/user.dart';
import 'package:provider/provider.dart';

import '../user_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppUser user;
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is AppUser) {
      user = arguments;
      nameController.text = user.uName!;
      emailController.text = user.uEmail!;
      passwordController.text = user.uPassword!;
    } else {
      nameController.text = '';
      emailController.text = '';
      passwordController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
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
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
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
                    // controller: _emailCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    validator: (value) {
                      if (value == null) {
                        return 'null value';
                      } else if (value.length < 5) {
                        return 'email must be more than 5 char';
                      } else if (!value.contains('@')) {
                        return 'email must contain @';
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
                      labelStyle: const TextStyle(
                          // color: Colors.black,
                          ),
                      // focusColor: Colors.black87,
                      // hintText: 'example@example.com',
                      labelText: 'E-mail',
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
                    obscureText: true,
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'null value';
                      } else if (value.length < 5) {
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
                      userData.setUsername(nameController.text);
                      userData.setUserEmail(emailController.text);
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Text('Submit'),
                  ),
                ),
                const Text(
                  'Didn\'t have an account?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  child: const Text(
                    'sign up',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
