// import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Music.dart';
// import 'package:todo_list/components/AnimatedTodoListTile.dart';

class MusicListModel extends Model {
  List<Music> _musicItems = <Music>[];

  // [TO-DO]: Find out why use get & _?
  List<Music> get musicItems => _musicItems;

  void insertNewItem (Music m) {
    _musicItems.add(m);

    notifyListeners();
  }

//   void updateItem (Music item, {String title, String subTitle, String note}) {
//     item.title = title ?? item.title;
//     item.subTitle = subTitle ?? item.subTitle;
//     item.note = note ?? item.note;

//     // notifyListeners();
//   }

//   void expandItem (Music item) {
//     _activeItem = item;

//     notifyListeners();
//   }

//   void hideAllItems () {
//     _activeItem = null;

//     notifyListeners();
//   }
}