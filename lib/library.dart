import 'package:flutter/material.dart';
import 'package:music_list/models/Music.dart';
import 'package:music_list/details.dart';
import 'package:music_list/models/MusicListModel.dart';


class LibraryPage extends StatelessWidget {
  // const LibraryPage({Key key, model.musicItems[index]}) : super(key: key);
  // final Music music;
  
  LibraryPage({Key key, this.model}) : super(key: key);
  final MusicListModel model;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      childAspectRatio: 0.65,
      children:  List.generate(model.musicItems.length, (index) {
        return Column(
          children: <Widget>[
            // Hero(
            //   tag: model.musicItems[index].title,
            //   child: Image.network(model.musicItems[index].imgSrc + '300'),
            // ),
            Image.network(model.musicItems[index].imgSrc + '300'),
            Container(
              margin: new EdgeInsets.only(top: 10.0),
              child: Text(
                model.musicItems[index].title,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              )
            ),
            Container(
              margin: new EdgeInsets.only(top: 10.0),
              child: Text(
                model.musicItems[index].desc,
                style: TextStyle(fontSize: 16.0),
              )
            ),
          ],
        );
      }),
    );
  }
}