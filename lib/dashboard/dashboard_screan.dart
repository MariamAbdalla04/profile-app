import 'package:flutter/material.dart';
import 'package:myapp/favorite.dart/favorite_screen.dart';
import 'package:myapp/profile%20/profile_page/profile_page.dart';
import 'package:myapp/profile%20/user_model.dart';
import 'package:provider/provider.dart';
import 'package:myapp/add_item.dart/item_model.dart';

import 'package:myapp/favorite.dart/favorite_model.dart';
import 'package:myapp/details/details_screen/details_page.dart';
import 'package:myapp/add_item.dart/add_item_screen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageData = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final favModel = Provider.of<FavoriteModel>(context);

    return Scaffold(
      appBar: AppBar(
  title: const Text("Dashboard"),


  actions: [
    Consumer<FavoriteModel>(
      builder: (context, favModel, child) {
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(), // your screen
                  ),);},
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
            if (favModel.fav.isNotEmpty)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
           padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ) ],),
                  child: Text(
                    '${favModel.fav.length}',
                    style: const TextStyle(
                  fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
               ),
          ),
       ),
              ),
          ], );},),

    IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        ); },
      icon: profileImageData == null
          ? const Icon(Icons.account_box)
          : CircleAvatar(
              radius: 20,
              backgroundImage: MemoryImage(profileImageData),
            ),),
  ],
),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: items.items.length,
        itemBuilder: (context, index) {
          final item = items.items[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                items.selectItem(item);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailsPage()),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10)),
                      child: item.images.isNotEmpty
                          ? Image.memory(
                              item.images.first,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image, size: 50),
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}