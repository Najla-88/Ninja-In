import 'package:flutter/material.dart';
import 'package:ninjain/models/user_model.dart';

import '../../repositories/user_repository.dart';

class DeleteAcoount extends StatefulWidget {
  DeleteAcoount({super.key, required this.user});
  final Users user;

  @override
  State<DeleteAcoount> createState() => _DeleteAcoountState();
}

class _DeleteAcoountState extends State<DeleteAcoount> {
  final UserRepository userRepo = UserRepository();
  String text = 'Are you sure you want to deleet your account?';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Icon(Icons.delete),
      content: Container(
        constraints: BoxConstraints(
          maxWidth: 300,
          minWidth: 150,
          maxHeight: 100,
          minHeight: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading
                ? CircularProgressIndicator()
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            var result = await userRepo.deleteeUser(widget.user);
            if (result > 0) {
              Navigator.of(context).pop(result);
            }
            setState(() {
              isLoading = false;
            });
          },
          child: Text('Yes'),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No')),
      ],
    );
  }
}
