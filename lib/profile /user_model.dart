import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile%20/user.dart';

class UserModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();

  UserModel() {
    _user = User(
      name: "Mariam Abdalla",
      bio: "Code. Sleep. Eat. Repeat.",
      image: null,  // Will be stored as Uint8List
    );
  }

  User? _user;
  User? get user => _user;

  // Pick an image from camera or gallery
  Future<void> imageSelector(ImageSource source) async {
    try {
      final XFile? pickedImage = await imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        final bytes = await pickedImage.readAsBytes();
        _user = User(
          name: _user?.name ?? "Ereeny Nassef",
          bio: _user?.bio ?? "Code. Sleep. Eat. Repeat.",
          image: bytes,  // Store the image as Uint8List
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image selection error: $e");
    }
  }

  // Remove the profile image
  void removeImage() {
    if (_user != null) {
      _user = User(
        name: _user!.name,
        bio: _user!.bio,
        image: null,  // Remove the image
      );
      notifyListeners();
    }
  }
}
