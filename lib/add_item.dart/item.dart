import 'dart:typed_data';

class Item {
  @override
bool operator ==(Object other) {
  return other is Item && other.title == title;
}

@override


int get hashCode => title.hashCode;
  Item({
    required this.images,
    required this.title,
    required this.body,
    required this.favorite,
  });

  List<Uint8List> images;
  String title;
  String body;
  bool favorite;
}