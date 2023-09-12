import 'package:flutter/material.dart';

// import '../theme.dart';

class AppDrawer extends StatefulWidget {
  final List<String> drawerItems;
  final int selectedIndex;
  final Function(int) onItemTapped;
  const AppDrawer({
    Key? key,
    required this.drawerItems,
    required this.selectedIndex,
    required this.onItemTapped,
    // required this.onThemeChanged,
  }) : super(key: key);
  // Function onThemeChanged;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
  // _AppDrawerState(onThemeChanged: onThemeChanged);
}

class _AppDrawerState extends State<AppDrawer> {
  // _AppDrawerState({required this.onThemeChanged});
  // Function onThemeChanged;
  bool isDayMode = true;

  void toggleMode() {
    // onThemeChanged(!MyThemes.isDark);
    setState(() {
      isDayMode = !isDayMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  // backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Neejo Dattebayo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'neejo-ninja@example.com',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: toggleMode,
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Icon(
                              isDayMode
                                  ? Icons.wb_sunny
                                  : Icons.nightlight_round,
                              color: Colors.black,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.drawerItems.length,
            itemBuilder: (context, index) {
              final item = widget.drawerItems[index];

              return ListTile(
                title: Text(item),
                selected: widget.selectedIndex == index,
                // tileColor: selectedIndex == index ? Colors.grey[600] : null,
                textColor: Colors.grey[600],
                onTap: () {
                  widget.onItemTapped(index);
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
