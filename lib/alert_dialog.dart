import 'package:flutter/material.dart';

class MyalertDialog extends StatefulWidget {
  const MyalertDialog({super.key});

  @override
  State<MyalertDialog> createState() => My_alertDialogState();
}

class My_alertDialogState extends State<MyalertDialog> {
  int _selectedRadio = 0;

  setSelectedRadio(int? val) {
    setState(() {
      _selectedRadio = val ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Font size'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setSelectedRadio(1);
            },
            child: ListTile(
              title: Text(
                'Larg',
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Radio(
                value: 1,
                groupValue: _selectedRadio,
                onChanged: (int? val) {
                  setSelectedRadio(val);
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setSelectedRadio(2);
            },
            child: ListTile(
              title: Text(
                'Medium',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Radio(
                value: 2,
                groupValue: _selectedRadio,
                onChanged: (int? val) {
                  setSelectedRadio(val);
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setSelectedRadio(3);
            },
            child: ListTile(
              title: Text(
                'small',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Radio(
                value: 3,
                groupValue: _selectedRadio,
                onChanged: (int? val) {
                  setSelectedRadio(val);
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
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
            // print('Selected Radio: $_selectedRadio');
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
  }
}
