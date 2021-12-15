import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final favouriteWordPairs = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WordPair Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushFavourites,)
        ],
      ),
      body: _buildList(),
    );
  }

  void _pushFavourites(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = favouriteWordPairs.map((WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase),
              );
            });

            final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text("Saved WordPairs")
              ),
              body: ListView(
                children: divided,
              ),
            );
          }
          )
    );
  }


  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              color: Colors.red[100],
              thickness: 1.5,
            );
          }
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadyFavourite = favouriteWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        alreadyFavourite ? Icons.favorite : Icons.favorite_outline,
        color: alreadyFavourite ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadyFavourite) {
            favouriteWordPairs.remove(pair);
          } else {
            favouriteWordPairs.add(pair);
          }
        });
      },
    );
  }
}
