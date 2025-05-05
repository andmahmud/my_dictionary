class Word {
  String text;
  String bangla;
  bool isFavorite;

  Word({required this.text, required this.bangla, this.isFavorite = false});

  // Method to convert Word to map (for saving in SharedPreferences)
  Map<String, dynamic> toMap() {
    return {'text': text, 'bangla': bangla, 'isFavorite': isFavorite};
  }

  // Method to convert map to Word (for loading from SharedPreferences)
  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      text: map['text'],
      bangla: map['bangla'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
