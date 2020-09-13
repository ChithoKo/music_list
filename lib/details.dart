import 'package:flutter/material.dart';
import 'package:music_list/models/Music.dart';

class MusicDetailsPage extends StatelessWidget {
  const MusicDetailsPage({Key key, this.music}) : super(key: key);
  final Music music;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details')
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: this.music.title,
            child: Image.network(this.music.imgSrc + '500'),
          ),
          Container(
            margin: new EdgeInsets.only(top: 50.0),
            child: Text(
              this.music.title,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            )
          ),
          Container(
            margin: new EdgeInsets.only(top: 30.0),
            child: Text(
              this.music.desc,
              style: TextStyle(fontSize: 16.0),
            )
          ),
        ],
      ),
    );
  }
}