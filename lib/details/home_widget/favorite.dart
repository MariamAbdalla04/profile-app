import 'package:flutter/material.dart';
import 'package:myapp/add_item.dart/item_model.dart';
import 'package:myapp/favorite.dart/favorite_model.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({required this.index, super.key});

   final index;
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(
      builder:
          (context, item, child) => IconButton(
            onPressed: () {
              Provider.of<FavoriteModel>(context, listen: false).isFavorite(item.items[index]);// Add your onPressed logic here
            },

            icon: Icon(
              Icons.favorite,
              color: item.items[index].favorite ? Colors.red : Colors.grey,
            ),
          ),
    );
  }
}
