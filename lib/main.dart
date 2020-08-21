import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Word game',

      home:new RandomSentences(),

      );

  }
}
class RandomSentences extends StatefulWidget{
  @override
  createState()=> new _RandomSentenceSTATE();
  }


class _RandomSentenceSTATE extends State<RandomSentences>{
  final _sentence=<String>[];
  final _biggerfont=const TextStyle(fontSize: 14.0);
  final _funny=new Set<String>();
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('WARD GAME'),
        actions: <Widget>[
          new IconButton(
              icon:new Icon(Icons.list) ,
              onPressed: _pushfunny)
        ],
        

      ),
      body:_buildsentence(),
    );

  }
  void _pushfunny(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context){
        final tiles=_funny.map(
        (_sentence){
          return new ListTile(
          title: new Text(
          _sentence,
            style:_biggerfont
          ),
          );
    },
        );
        final divided=ListTile.divideTiles(
    context:context,
    tiles:tiles,
    ).toList();
        return new Scaffold(
               appBar:new AppBar(
                 title:new Text('fun saved'),

    ),
                    body: new ListView(children: divided,),
    );
    },

    ),
    );

  }




    String _getSentence() {
    final noun = new WordNoun.random();
    final adjective = new WordAdjective.random();
    return"The programmer wrote a ${adjective.asCapitalized}"" apk in Flutter and showed it"" off to his ${noun.asCapitalized}";
  }


  Widget _buildrow(String sentence){
    final alreadyfound=_funny.contains(sentence);
    return new ListTile(
      title: new Text(
        sentence,
        style: _biggerfont,
      ),
      trailing: new Icon(
        alreadyfound ? Icons.thumb_up: Icons.thumb_down,
        color: alreadyfound ?Colors.green : null,
      ),
      onTap: (){
        setState(() {
          if(alreadyfound){
            _funny.remove(sentence);

          }
          else{
            _funny.add(sentence);
          }
        });
      },
    );

  }

  Widget _buildsentence(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        if(i.isOdd) return new Divider();
        final index = i~/2;
        if(index >= _sentence.length){
          for(int x=0;x<10;x++){
            _sentence.add(_getSentence( ));
          }
        }
        return _buildrow(_sentence[index]);
      },
    );

  }

}