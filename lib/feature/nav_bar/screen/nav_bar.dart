import 'package:flutter/material.dart';
import 'package:my_dictionary/core/network_coller/word_controller.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';
import 'package:my_dictionary/feature/book_mark/screen/book_mark.dart';
import 'package:my_dictionary/drawer.dart';
import 'package:my_dictionary/feature/home/screen/home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homepage> {
  int _selectedIndex = 0;
  List<Word> _favoriteWords = [];

  final storageService = WordStorageService();

  @override
  void initState() {
    super.initState();
    loadFavoriteWords();
  }

  Future<void> loadFavoriteWords() async {
    final allWords = await storageService.loadWords();
    setState(() {
      _favoriteWords = allWords.where((word) => word.isFavorite).toList();
    });
  }

  void _onItemTapped(int index) async {
    if (index == 1) {
      await loadFavoriteWords(); 
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomeScreen(),
      FavoritesScreen(favoriteWords: _favoriteWords),
    ];

    final List<String> _titles = ["My Dictionary", "Favorite Words"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
