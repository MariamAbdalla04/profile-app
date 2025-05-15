import 'package:flutter/material.dart';
import 'package:myapp/profile%20/profile_page/profile_page.dart';
import 'package:myapp/profile%20/user_model.dart';
import 'package:provider/provider.dart';
import 'package:myapp/add_item.dart/item_model.dart';

import 'package:myapp/favorite.dart/favorite_model.dart';
import 'package:myapp/add_item.dart/add_item_screen.dart';


class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageData = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final favModel = Provider.of<FavoriteModel>(context);

    if (items.selectedItem == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: const Center(
          child: Text('No item selected', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final item = items.selectedItem!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The ${item.title}"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: profileImageData == null
                ? const Icon(Icons.account_box)
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(profileImageData),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.images.isNotEmpty)
              Hero(
                tag: 'imageHero${item.title}',
                child: Image.memory(
                  item.images.first,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          items.toggleFavorite(item);
                          if (item.favorite) {
                            favModel.add(item);
                          } else {
                            favModel.remove(item);
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: item.favorite ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share functionality would go here
                        },
                        icon: const Icon(Icons.share, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                item.body,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),

            if (item.images.length > 1) ...[
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'More Images',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: item.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          item.images[index],
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}