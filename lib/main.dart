import 'package:flutter/material.dart';
import 'package:myapp/add_item.dart/item_model.dart';
import 'package:myapp/dashboard/dashboard_screan.dart';
import 'package:myapp/dashboard/nav_bar.dart';
import 'package:myapp/details/details_screen/details_page.dart';
import 'package:myapp/add_item.dart/add_item_screen.dart';
import 'package:myapp/favorite.dart/favorite_model.dart';
import 'package:myapp/profile%20/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ), // ChangeNotifierProvider
        ChangeNotifierProvider(
          create: (context) => ItemModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteModel(),
        ), // ChangeNot // ChangeNotifierProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tree App',
      theme: ThemeData(primarySwatch: Colors.green),

      home:
          const NavBar(), // Make sure you replace DashboardScreen() with the actual home page widget you want
      routes: {'/first': (context) => AddItemScreen()},
    );
  }
}
