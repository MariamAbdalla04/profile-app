import 'package:flutter/material.dart';
import 'package:myapp/dashboard/dashboard_screan.dart';
import 'package:myapp/dashboard/newpage.dart';
import 'package:myapp/favorite.dart/favorite_screen.dart';
import 'package:myapp/profile%20/profile_page/profile_page.dart';
import 'package:myapp/quote/quote_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        DashboardScreen(),
        QuoteScreen(),
        FavoriteScreen(),
        ProfilePage(),
        Newpage(),
      ][_selectedIndex], // use _selectedIndex instead of selectedIndex

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.format_quote),
            label: "Quote",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: "New",
          ),
        ],
      ),
    );
  }
}
