// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:music_list/library.dart';
import 'package:music_list/home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:music_list/models/MusicListModel.dart';

import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true // optional: set false to disable printing logs to console
  );

  runApp(MyApp(
    model: MusicListModel()
  ));
}

class MyApp extends StatefulWidget {
  final MusicListModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[HomePage(model: widget.model), LibraryPage(model: widget.model)];
    
    return ScopedModel<MusicListModel>(
      model: widget.model,
      child: MaterialApp(
        title: 'Music App Demo',
        home: Scaffold(
          body: ScopedModelDescendant<MusicListModel>(
            builder: (context, child, model) {
              return _pages[_selectedIdx];
              // return LibraryPage(model: model);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                title: Text('Library'),
              ),
            ],
            currentIndex: _selectedIdx,
            selectedItemColor: Colors.amber[800],
            onTap: (int i) {
              setState(() {
                _selectedIdx = i;
              });
            },
          ),
        ),
      ),
    );
  }
}

