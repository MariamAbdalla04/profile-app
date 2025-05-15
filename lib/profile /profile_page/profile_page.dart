   import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile%20/user_model.dart';
import 'package:provider/provider.dart';
import '../profile_widget/options.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Consumer<UserModel>(
        builder: (context, userModel, child) {
          final user = userModel.user;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey.shade400,
                        backgroundImage: user?.image != null
                            ? MemoryImage(user!.image!)  // Use MemoryImage for Uint8List
                            : null,
                        child: user?.image == null
                            ? const Icon(Icons.person,
                                size: 100, color: Colors.white)
                            : null,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 20, color: Colors.white),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text("Update Profile Picture",
                                        style: TextStyle(fontSize: 18)),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Options(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            userModel.imageSelector(
                                                ImageSource.camera);
                                          },
                                          title: "Camera",
                                          icon: Icons.camera_alt,
                                        ),
                                        Options(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            userModel.imageSelector(
                                                ImageSource.gallery);
                                          },
                                          title: "Gallery",
                                          icon: Icons.image,
                                        ),
                                        if (user?.image != null)
                                          Options(
                                            onPressed: () {
                                              userModel.removeImage();
                                              Navigator.pop(context);
                                            },
                                            title: "Delete",
                                            icon: Icons.delete,
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Name",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user?.name ?? "No name set"),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text("Bio",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user?.bio ?? "No bio set"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}