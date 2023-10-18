// you need to add this code in FlutterProject\ninjain\android\app\src\main\AndroidManifest.xml

// <activity
//             android:name="com.yalantis.ucrop.UCropActivity"
//             android:screenOrientation="portrait"
//             android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/user_data.dart';

Future<void> pickImage(BuildContext context) async {
  final userData = Provider.of<UserData>(context, listen: false);

  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    final imageCropper = ImageCropper();
    final croppedImage = await imageCropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio:
          CropAspectRatio(ratioX: 1, ratioY: 1), // Set desired aspect ratio
      compressQuality: 100, // Set compression quality
      maxWidth: 800, // Set maximum width
      maxHeight: 800, // Set maximum height
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Profile photo',
          toolbarColor: Theme.of(context).primaryColorDark,
          toolbarWidgetColor: Theme.of(context).primaryColor,
        ),
      ],
    );

    if (croppedImage != null) {
      final bytes = await croppedImage.readAsBytes();
      userData.setUserPic(bytes);
    }
  }
}
