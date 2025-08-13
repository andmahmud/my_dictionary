import 'package:flutter/material.dart';
import 'package:my_dictionary/core/network_coller/word_controller.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Word> words = [];
  List<Word> filteredWords = [];
  final storageService = WordStorageService();
  bool showFavoritesOnly = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadWords();
    searchController.addListener(_filterWords);
  }

  Future<void> loadWords() async {
    final loaded = await storageService.loadWords();
    setState(() {
      words = loaded;
      filteredWords = loaded; // Initialize with all words
    });
  }

  Future<void> saveWords() async {
    await storageService.saveWords(words);
  }

  void _filterWords() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredWords =
          words.where((word) {
            bool matchesSearch =
                word.text.toLowerCase().contains(query) ||
                word.bangla.toLowerCase().contains(query);
            bool matchesFavorites = !showFavoritesOnly || word.isFavorite;
            return matchesSearch && matchesFavorites;
          }).toList();
    });
  }

  void addOrEditWord({Word? word, int? index}) {
    final englishController = TextEditingController(text: word?.text ?? '');
    final banglaController = TextEditingController(text: word?.bangla ?? '');

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(word == null ? 'Add Word' : 'Edit Word'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: englishController,
                  decoration: const InputDecoration(labelText: 'First Word'),
                ),
                TextField(
                  controller: banglaController,
                  decoration: const InputDecoration(labelText: 'Sceond Word'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (englishController.text.isEmpty ||
                      banglaController.text.isEmpty)
                    return;

                  setState(() {
                    if (word == null) {
                      words.add(
                        Word(
                          text: englishController.text,
                          bangla: banglaController.text,
                        ),
                      );
                    } else {
                      words[index!] = Word(
                        text: englishController.text,
                        bangla: banglaController.text,
                        isFavorite: word.isFavorite,
                      );
                    }
                    _filterWords(); 
                  });
                  saveWords();
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void toggleFavorite(int index) {
    setState(() {
      words[index].isFavorite = !words[index].isFavorite;
      _filterWords(); 
    });
    saveWords();
  }

  void deleteWord(int index) {
    setState(() {
      words.removeAt(index);
      _filterWords(); 
    });
    saveWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: searchController,
            onChanged: (_) => _filterWords(),
            decoration: InputDecoration(
              hintText: "Search English or Bangla...",
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditWord(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          
          Row(
            children: [
              Checkbox(
                value: showFavoritesOnly,
                onChanged: (value) {
                  setState(() {
                    showFavoritesOnly = value!;
                    _filterWords(); 
                  });
                },
              ),
              const Text("Show Favorites Only"),
            ],
          ),
         
          Expanded(
            child:
                filteredWords.isEmpty
                    ? const Center(child: Text("No words to display."))
                    : ListView.builder(
                      itemCount: filteredWords.length,
                      itemBuilder: (context, index) {
                        final word = filteredWords[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              "${word.text} = ${word.bangla}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'favorite') {
                                  toggleFavorite(index);
                                } else if (value == 'edit') {
                                  addOrEditWord(word: word, index: index);
                                } else if (value == 'delete') {
                                  deleteWord(index);
                                }
                              },
                              itemBuilder:
                                  (context) => [
                                    PopupMenuItem(
                                      value: 'favorite',
                                      child: Row(
                                        children: [
                                          Icon(
                                            word.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                word.isFavorite
                                                    ? Colors.red
                                                    : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            word.isFavorite
                                                ? 'Unfavorite'
                                                : 'Favorite',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: Colors.blue),
                                          SizedBox(width: 8),
                                          Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text('Delete'),
                                        ],
                                      ),
                                    ),
                                  ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
