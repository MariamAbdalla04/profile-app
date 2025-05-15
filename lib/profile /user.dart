import 'dart:typed_data';

class User {
  User({
    required this.name,
    required this.bio,
    required this.image,
  });

  String name;
  String bio;
  Uint8List? image;
}