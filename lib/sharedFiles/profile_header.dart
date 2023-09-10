import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          // backgroundImage: AssetImage('assets/profile_image.jpg'),
        ),
        SizedBox(height: 10),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'john.doe@example.com',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
