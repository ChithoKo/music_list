import 'package:flutter/material.dart';
import 'package:music_list/details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);
  // dummy list data
  final List<Music> musics = <Music>[
    Music('https://picsum.photos/id/1024/', title: 'Eagle', desc: 'Fly!!'),
    Music('https://picsum.photos/id/1025/', title: 'Pug', desc: 'cozyy'),
    Music('https://picsum.photos/id/1062/', title: 'Pug II', desc: 'more cozyyy'),
    Music('https://picsum.photos/id/1069/', title: 'Jellyfish', desc: 'is swimming'),
    Music('https://picsum.photos/id/1074/', title: 'Lioness', desc: 'WAT YA LOOKING AT?'),
    Music('https://picsum.photos/id/1084/', title: 'Walrus', desc: 'oops'),
    Music('https://picsum.photos/id/169/', title: 'Hounds', desc: 'sniff sniff'),
    Music('https://picsum.photos/id/200/', title: 'Buffalo', desc: '(Jay Chow)'),
    Music('https://picsum.photos/id/219/', title: 'Leopard', desc: 'WATCHA LOOKING AT??'),
    Music('https://picsum.photos/id/237/', title: 'Labrador', desc: 'u can‘t resist me'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: musics[index].title,
              child: Image.network(musics[index].imgSrc + '200'),
            ),
            title: Text(musics[index].title),
            subtitle: Text(musics[index].desc),
            onTap: () => _onTap(context, musics[index]),
          );
        }
      ),
    );
  }

  void _onTap (BuildContext context, Music music) {
    Navigator.push(
      context, 
      MaterialPageRoute( builder: (context) => MusicDetailsPage(music: music) )
    );
  }
}

class Music {
  Music(this.imgSrc, {this.title = '', this.desc = ''});
  String imgSrc;
  String title;
  String desc;
}