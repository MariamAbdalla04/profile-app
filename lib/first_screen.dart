
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/home/home_screen/home_page.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<Firstscreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<Uint8List> selectedImages = [];

  Future<void> imageSelector() async {
    List<XFile>? images = await imagePicker.pickMultiImage();

    if (images != null && mounted) {
      List<Uint8List> imageBytes =
          await Future.wait(images.map((xfile) => xfile.readAsBytes()));
      setState(() {
        selectedImages.addAll(imageBytes);
      });
    }
  }

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Oak-tree-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            selectedImages.isEmpty
                ? Container(
                    color: Colors.white38,
                    height: 150,
                    width: MediaQuery.of(context).size.width - 20,
                    child: IconButton(
                      onPressed: imageSelector,
                      icon: const Icon(Icons.camera_alt),
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        color: Colors.white38,
                        height: 100,
                        width: 100,
                        child: IconButton(
                          onPressed: imageSelector,
                          icon: const Icon(Icons.camera_alt),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 20,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Image.memory(
                                    selectedImages[index],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: body,
                    minLines: 3,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: "Body",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                title: title.text,
                body: body.text,
                image: selectedImages, // ✅ pass images here!
              ),
            ),
          );
        },
      ),
    );
  }
}
