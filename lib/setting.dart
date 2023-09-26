import 'package:flutter/material.dart';
import 'package:ninjain/alert_dialog.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/shared/app_drawer.dart';
import 'package:ninjain/user_data.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    print(userData.uemail);
    return Scaffold(
      appBar: AppAppbar(context, 'Setting'),
      drawer: AppDrawer(title: 'Setting'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/product_image.png'),
                  maxRadius: MediaQuery.of(context).size.width * 0.13,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          'User name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'User email',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
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
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'User info',
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                'name, email, password',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/userInfo');
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.format_size,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Font size',
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                'medium',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            onTap: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return MyalertDialog();
                  });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_sharp,
              color: Theme.of(context).primaryColor,
            ),
            title: GestureDetector(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('LogOut'),
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
                              userData.resetObject();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
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
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text(
              'Delete account',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            iconColor: Colors.red[400],
            textColor: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
