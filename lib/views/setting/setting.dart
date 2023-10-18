import 'package:flutter/material.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/shared/app_drawer.dart';
import 'package:ninjain/providers/user_data.dart';
import 'package:ninjain/views/setting/delete_account.dart';
import 'package:provider/provider.dart';

// import 'alert_dialog.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final cartData = Provider.of<CartData>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => false);
        Navigator.of(context).pushNamed('/');
        return true; // Allow default back button behavior
      },
      child: Scaffold(
        appBar: AppAppbar(context, 'Setting'),
        drawer: AppDrawer(title: 'Setting'),
        body: ListView(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: userData.user.img != null &&
                              userData.user.img!.isNotEmpty
                          ? MemoryImage(userData.user.img!)
                          : AssetImage('assets/images/product_image.png')
                              as ImageProvider<Object>?,
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
                              userData.user.name ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            userData.user.email ?? '',
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
              onTap: () {
                Navigator.of(context).pushNamed('/userInfo');
              },
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
                                cartData.resetObject();
                                Navigator.of(context)
                                    .popUntil((route) => false);
                                Navigator.of(context).pushNamed('/');
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
              title: GestureDetector(
                child: Text(
                  'Delete account',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              onTap: () async {
                final isDeleted = await showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteAcoount(user: userData.user);
                    });
                if (isDeleted == 1) {
                  userData.resetObject();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Account deleted Succefully",
                        style: TextStyle(
                            // color: Colors.black,
                            ),
                      ),
                      backgroundColor: Colors.green[20],
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).popUntil((route) => false);
                  Navigator.of(context).pushNamed('/');
                } else if (isDeleted == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "ERROR: Account Didn\'t Deleted!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              iconColor: Colors.red[400],
              textColor: Colors.red[400],
            ),
          ],
        ),
      ),
    );
  }
}
