import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:food_court_project/';

// for picking up image from gallery
// pickImage(ImageSource source) async {
//   final ImagePicker imagePicker = ImagePicker();
//   XFile? file = await imagePicker.pickImage(source: source);
//   if (file != null) {
//     return await file.readAsBytes();
//   }
// }

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

// const textStyleInput = TextStyle(color: Theme.of(context).colorScheme.primary);
