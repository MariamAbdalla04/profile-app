import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:myapp/add_item.dart/item.dart';

class ItemModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<Uint8List> selectedImages = [];

  Future<void> imageSelector() async {
    List<XFile>? images = await imagePicker.pickMultiImage();
    
    if (images != null) {
      List<Uint8List> imageBytes = await Future.wait(
        images.map((xfile) => xfile.readAsBytes()),
      );
      
      selectedImages.addAll(imageBytes);
    }
    notifyListeners();
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  Item? _selectedItem;
  Item? get selectedItem => _selectedItem;

  void selectItem(Item item) {
    _selectedItem = item;
    notifyListeners();
  }

  void toggleFavorite(Item item) {
    item.favorite = !item.favorite;
    notifyListeners();
  }
}