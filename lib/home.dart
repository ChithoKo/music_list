import 'package:flutter/material.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:music_list/models/MusicListModel.dart';
import 'package:music_list/models/Music.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_list/details.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.model}) : super(key: key);
  final MusicListModel model;

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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Hero(
            tag: widget.musics[index].title,
            child: Image.network(widget.musics[index].imgSrc + '200'),
          ),
          title: Text(widget.musics[index].title),
          subtitle: Text(widget.musics[index].desc),
          trailing: GestureDetector(
            onTap: () async {
              final status = await Permission.storage.request();

              if (status.isGranted) {
                final appDocDir = await getApplicationDocumentsDirectory();

                await FlutterDownloader.enqueue(
                  url: widget.musics[index].imgSrc + "500.jpg",
                  savedDir: appDocDir.path,
                  fileName: widget.musics[index].title + ".jpg",
                  showNotification: true,
                  openFileFromNotification: true,
                );

                widget.model.insertNewItem(widget.musics[index]);
              } else {
                print("Permission deined");
              }
            },
            child: Icon(Icons.add)
          ),
          onTap: () => _onTap(context, widget.musics[index]),
        );
      }
    );
  }

  void _onTap (BuildContext context, Music music) {
    Navigator.push(
      context, 
      MaterialPageRoute( builder: (context) => MusicDetailsPage(music: music) )
    );
  }
}
