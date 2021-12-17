import 'package:flutter/cupertino.dart';

final String tableWordPair = 'wordPairs';

class WordPairFields {
  static final List<String> values = [id, wordPair];

  static final String id = '_id';
  static final String wordPair = 'wordPair';
}

class Word {
  final int? id;
  final String? wordPair;

  const Word({
    this.id,
    required this.wordPair,
  });

  Word copy({
    int? id,
    String? wordPair,
  }) =>
      Word(
        id: id ?? this.id,
        wordPair: wordPair ?? this.wordPair,
      );

  static Word fromJson(Map<String, Object?> json) => Word(
      id: json[WordPairFields.id] as int?,
      wordPair: json[WordPairFields.wordPair] as String,
  );

  Map<String, Object?> toJson() => {
        WordPairFields.id: id,
        WordPairFields.wordPair: wordPair,
      };
}
