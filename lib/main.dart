import 'package:flutter/material.dart';
import 'package:ninjain/sharedFiles/app_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ninja-In',
      // theme: ThemeData.dark(),
      theme: ThemeData(
          // primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            ///////////////////////////////////////////////////////////////////
            // // dark mode / / /
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            color: Colors.black12, //<-- SEE HERE
          ),
          colorScheme:
              const ColorScheme.dark().copyWith(primary: Colors.white)),
      ///////////////////////////////////////////////////////////////////
      ///////////////////////////////////////////////////////////////////
      //   // Light mode \/ \/ \/
      //   iconTheme: IconThemeData(color: Colors.black),
      //   titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      //   color: Colors.white54, //<-- SEE HERE
      // ),
      // colorScheme:
      //     const ColorScheme.light().copyWith(primary: Colors.black)),
      ///////////////////////////////////////////////////////////////////

      home: const MyHomePage(title: 'Ninja-In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // final items = List<ListItem>.generate(
  //   10,
  //   (i) => HeadingItem('Heading $i'),
  //   // : MessageItem('Sender $i', 'Message body $i'),
  // );

  final List<String> items = ['Home', 'page1', 'page2'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(),
      drawer: AppDrawer(
        items: items,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// /// The base class for the different types of items the list can contain.
// abstract class ListItem {
//   /// The title line to show in a list item.
//   Widget buildTitle(BuildContext context);

//   /// The subtitle line, if any, to show in a list item.
//   Widget buildSubtitle(BuildContext context);
// }

// /// A ListItem that contains data to display a heading.
// class HeadingItem implements ListItem {
//   final String heading;

//   HeadingItem(this.heading);

//   @override
//   Widget buildTitle(BuildContext context) {
//     return Text(
//       heading,
//       style: Theme.of(context).textTheme.titleLarge,
//     );
//   }

//   @override
//   Widget buildSubtitle(BuildContext context) {
//     return const SizedBox.shrink();
//   }
// }

// // A ListItem that contains data to display a message.
// class MessageItem implements ListItem {
//   final String sender;
//   final String body;

//   MessageItem(this.sender, this.body);

//   @override
//   Widget buildTitle(BuildContext context) {
//     return Text(
//       sender,
//       style: Theme.of(context).textTheme.titleMedium,
//     );
//   }

//   @override
//   Widget buildSubtitle(BuildContext context) {
//     return Text(
//       body,
//       style: Theme.of(context).textTheme.bodyMedium,
//     );
//   }
// }
