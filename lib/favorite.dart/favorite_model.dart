 import 'package:flutter/cupertino.dart';

import 'package:myapp/add_item.dart/item.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Item> _fav = [];
  List<Item> get fav => _fav;

  add(Item item) {
    _fav.add(item);
    notifyListeners();
  }

  remove(Item item) {
    _fav.remove(item);
    notifyListeners();
  }
  isFavorite(Item item) {
  item.favorite = !item.favorite;
  item.favorite ? add(item) : remove(item);
  notifyListeners();
}
}