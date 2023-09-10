import 'package:flutter/material.dart';
import 'package:ninjain/sharedFiles/profile_header.dart';

class AppDrawer extends StatelessWidget {
  final List<String> drawerItems;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppDrawer({
    Key? key,
    required this.drawerItems,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: ProfileHeader(),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: drawerItems.length,
            itemBuilder: (context, index) {
              final item = drawerItems[index];

              return ListTile(
                title: Text(item),
                selected: selectedIndex == index,
                // tileColor: selectedIndex == index ? Colors.grey[600] : null,
                textColor: Colors.grey[600],
                onTap: () {
                  onItemTapped(index);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
