import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/add_item.dart/item.dart';
import 'package:provider/provider.dart';
import 'package:myapp/add_item.dart/item_model.dart';
import 'package:myapp/dashboard/dashboard_screan.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Oak-tree-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ItemModel>(
          builder: (context, itemModel, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                itemModel.selectedImages.isEmpty
                    ? GestureDetector(
                        onTap: itemModel.imageSelector,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 50, color: Colors.white),
                              SizedBox(height: 8),
                              Text('Add Images', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: itemModel.selectedImages.length + 1,
                              itemBuilder: (context, index) {
                                if (index == itemModel.selectedImages.length) {
                                  return GestureDetector(
                                    onTap: itemModel.imageSelector,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 100,
                                      child: const Center(
                                        child: Icon(Icons.camera_alt, size: 40, color: Colors.black),
                                      ),
                                    ),
                                  );
                                }
                                return Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          itemModel.selectedImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap: () => itemModel.removeImage(index),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                const SizedBox(height: 20),
                TextField(
                  controller: title,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: body,
                  minLines: 5,
                  maxLines: 8,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.save, color: Colors.white),
        onPressed: () {
          if (title.text.isEmpty || body.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fill all fields'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          final itemModel = Provider.of<ItemModel>(context, listen: false);
          itemModel.addItem(
            Item(
              images: List.from(itemModel.selectedImages),
              title: title.text,
              body: body.text,
              favorite: false,
            ),
          );
          itemModel.selectedImages.clear();
          title.clear();
          body.clear();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
      ),
    );
  }
}