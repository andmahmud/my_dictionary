import 'package:flutter/material.dart';
import 'word.dart';
import 'word_storage_service.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Word> favoriteWords;

  const FavoritesScreen({super.key, required this.favoriteWords});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final storageService = WordStorageService();

  Future<void> saveWords() async {
    await storageService.saveWords(widget.favoriteWords);
  }

  void toggleFavorite(int index) {
    setState(() {
      widget.favoriteWords[index].isFavorite =
          !widget.favoriteWords[index].isFavorite;
    });
    saveWords();
  }

  void deleteWord(int index) {
    setState(() {
      widget.favoriteWords.removeAt(index);
    });
    saveWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: widget.favoriteWords.isEmpty
          ? const Center(child: Text("No favorite words to display."))
          : ListView.builder(
              itemCount: widget.favoriteWords.length,
              itemBuilder: (context, index) {
                final word = widget.favoriteWords[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("${word.text} = ${word.bangla}"),  // Corrected to use 'text' instead of 'english'
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          deleteWord(index);
                        } else if (value == 'favorite') {
                          toggleFavorite(index);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                        const PopupMenuItem(value: 'favorite', child: Text('Unfavorite')),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
