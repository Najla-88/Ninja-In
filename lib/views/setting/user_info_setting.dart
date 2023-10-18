import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ninjain/repositories/user_repository.dart';
import 'package:ninjain/views/setting/password_dialog.dart';
import 'package:ninjain/views/setting/profile_img.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/providers/user_data.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _nameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showPasswordDialog = false;
  bool _obscurePassword = true;
  UserRepository userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    Uint8List? userpicData = userData.user.img;
    return WillPopScope(
      onWillPop: () async {
        if (userData.isUpdated == true) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Save changes?'),
                  insetPadding: const EdgeInsets.all(10),
                  content: isLoading
                      ? Visibility(
                          visible: isLoading,
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        userData.user =
                            await userRepo.getUserById(userData.user.id!);
                        userData.isUpdated = false;
                        Navigator.of(context).popUntil((route) => false);
                        Navigator.of(context).pushNamed('/setting');
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        int result = await userRepo.updateUser(userData.user);
                        if (result == 1) {
                          Navigator.of(context).popUntil((route) => false);
                          Navigator.of(context).pushNamed('/setting');
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
        return true; // Allow default back button behavior
      },
      child: Scaffold(
        appBar: AppAppbar(context, 'User info'),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: CircleAvatar(
                      maxRadius: MediaQuery.of(context).size.width * 0.201,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                        backgroundImage: userData.user.img != null &&
                                userData.user.img!.isNotEmpty
                            ? MemoryImage(userpicData!)
                            : AssetImage('assets/images/product_image.png')
                                as ImageProvider<Object>?,
                        maxRadius: MediaQuery.of(context).size.width * 0.2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    pickImage(context);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: SizedBox(
                height: 0.2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: Icon(
                      Icons.account_circle_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    subtitle: Text(
                      userData.user.name.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(
                      Icons.edit,
                    ),
                  ),
                  onTap: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          _nameCtrl.text = userData.user.name ?? '';
                          return AlertDialog(
                            title: Text('Enter your name'),
                            insetPadding: const EdgeInsets.all(10),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'User name',
                                  ),
                                  maxLength: 20,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _nameCtrl,
                                  validator: (value) {
                                    RegExp regExp = RegExp(
                                        r'^[a-zA-Z0-9_\-.@$!#%&+أ-ي٠-٩]*$');
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
                                    userData.changeUserName(_nameCtrl.text);
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
                        });
                  },
                ),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Icon(
                    Icons.alternate_email_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    userData.user.email.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: Icon(
                      Icons.password,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    subtitle: Text(
                      '*******',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(
                      Icons.edit,
                    ),
                  ),
                  onTap: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Enter your name'),
                            insetPadding: const EdgeInsets.all(10),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                        ),
                                        controller: _passwordCtrl,
                                        validator: (value) {
                                          if (_passwordCtrl.text !=
                                              userData.user.password) {
                                            return 'Incorrect password';
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ),
                                );
                              },
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
                                    showPasswordDialog = true;
                                    Navigator.of(context).pop();
                                  }
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
                        }).then((_) {
                      if (showPasswordDialog) {
                        showPasswordDialog = false;
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return PasswordDialog();
                            });
                      }
                    });
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: isLoading
                      ? Visibility(
                          visible: isLoading,
                          child: CircularProgressIndicator(),
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
                            setState(() {
                              isLoading = true;
                            });
                            int result =
                                await userRepo.updateUser(userData.user);
                            if (result == 1) {
                              Navigator.of(context).popUntil((route) => false);
                              Navigator.of(context).pushNamed('/setting');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text('Save'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
