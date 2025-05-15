import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/add_item.dart/item_model.dart';
import 'package:myapp/favorite.dart/favorite_model.dart';
import 'package:myapp/details/details_screen/details_page.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              final favModel = Provider.of<FavoriteModel>(context, listen: false);
              final itemModel = Provider.of<ItemModel>(context, listen: false);
              
              // Remove all favorites from both models
              for (var item in favModel.fav) {
                itemModel.toggleFavorite(item);
              }
              favModel.fav.clear();
            },
          ),
        ],
      ),



   body: Consumer<FavoriteModel>(
  child: Text(
    'No favorite items',
    style: TextStyle(fontSize: 18, color: Colors.grey),
  ),
  builder: (context, favModel, child) {
    if (favModel.fav.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child!, 
            SizedBox(height: 8),
          
          ],
        ),
      );
    }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: favModel.fav.length,
            itemBuilder: (context, index) {
              final item = favModel.fav[index];
              return GestureDetector(
                onTap: () {
                  Provider.of<ItemModel>(context, listen: false).selectItem(item);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: item.images.isNotEmpty
                              ? Image.memory(
                                  item.images.first,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.body.length > 30
                                        ? '${item.body.substring(0, 30)}...'
                                        : item.body,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Provider.of<ItemModel>(context, listen: false)
                                        .toggleFavorite(item);
                                    favModel.remove(item);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}