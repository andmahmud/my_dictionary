class Word {
  String text;
  String bangla;
  bool isFavorite;

  Word({required this.text, required this.bangla, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {'text': text, 'bangla': bangla, 'isFavorite': isFavorite};
  }


  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      text: map['text'],
      bangla: map['bangla'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
