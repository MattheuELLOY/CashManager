import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          backgroundColor: Colors.teal),
      body: const RandomWords(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
          },
        tooltip: 'Increment Counter',
        child: Text("Favorite"),
      ),
    );
  }
}


class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}
class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          backgroundColor: Colors.blueAccent),
      body: ListView.builder(
        itemCount: favorite._saved.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              favorite._saved.toList().elementAt(i).toString(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
          },
        tooltip: 'Increment Counter',
        child: Text("Choose"),
      ),
    );
  }
}

class favorite {
  static final _suggestions = <WordPair>[];
  static final _saved = <WordPair>{};
  static final _biggerFont = const TextStyle(fontSize: 18);
}


class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {


  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= favorite._suggestions.length) {
          favorite._suggestions.addAll(generateWordPairs().take(10));
        }
        final alreadySaved = favorite._saved.contains(favorite._suggestions[index]);
        return ListTile(
          title: Text(
            favorite._suggestions[index].asPascalCase,
            style: favorite._biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                favorite._saved.remove(favorite._suggestions[index]);
              } else {
                favorite._saved.add(favorite._suggestions[index]);
              }
            });
          },
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = favorite._saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: favorite._biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

}