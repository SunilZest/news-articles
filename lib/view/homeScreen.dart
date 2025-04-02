import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/resources/drawer.dart';
import 'package:news/view/add_articals.dart';
import 'package:news/view/music_screen.dart';
import 'package:news/view/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    NewsScreen(),
    MusicHomePage(),
    CommonDrawer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _pages[_selectedIndex.value],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.teal,
          buttonBackgroundColor: Colors.teal,
          height: 70,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          index: _selectedIndex.value,
          onTap: (index) => _selectedIndex.value = index,
          items: const [
            Icon(Icons.article, size: 30, color: Colors.white),
            Icon(Icons.music_note, size: 30, color: Colors.white),
            Icon(Icons.settings, size: 30, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
