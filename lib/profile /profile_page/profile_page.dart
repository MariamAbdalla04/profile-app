import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Profile Demo', home: ProfilePage());
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker imagePicker = ImagePicker();
  Uint8List? selectedImage;

 Future<void> imageSelector(ImageSource source) async {
  final XFile? image = await imagePicker.pickImage(source: source);

  if (image != null && mounted) {
    final Uint8List bytes = await image.readAsBytes(); // read image data
    setState(() {
      selectedImage = bytes; // store in memory
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade500,
                  radius: 100,
                  child: selectedImage == null
    ? const Icon(
        Icons.person,
        size: 200,
        color: Colors.white38,
      )
    : ClipOval(
        child: Image.memory(
          selectedImage!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Options(
                                    title: "Camera",
                                    icon: Icons.camera_alt,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      imageSelector(ImageSource.camera);
                                    },
                                  ),
                                  Options(
                                    title: "Gallery",
                                    icon: Icons.image,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      imageSelector(ImageSource.gallery);
                                    },
                                  ),
                                 Options(
  title: "Delete",
  icon: Icons.delete,
  color: Colors.red, //
  onPressed: () {
    Navigator.pop(context);
    setState(() {
      selectedImage = null;
    });
  },
),
                                ],
                              ),
                        ],
                          ),
                        ),
                      );
               },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const Options({
    required this.onPressed,
    this.color,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color ?? Colors.black),
        ),
        Text(title),
      ],
    );
  }
}





