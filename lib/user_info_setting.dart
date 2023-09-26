import 'package:flutter/material.dart';
import 'package:ninjain/alert_dialog.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/shared/app_drawer.dart';
import 'package:ninjain/user_data.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    print(userData.uemail);
    return Scaffold(
      appBar: AppAppbar(context, 'User info'),
      // drawer: AppDrawer(title: 'Setting'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/product_image.png'),
                    maxRadius: MediaQuery.of(context).size.width * 0.2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ],
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
          ListTile(
            leading: Icon(
              Icons.account_circle_sharp,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'User Name',
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
        ],
      ),
    );
  }
}
