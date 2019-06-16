// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReorderableListDemo extends StatefulWidget {
  const ReorderableListDemo({ Key key }) : super(key: key);

  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListItem {
  _ListItem(this.value, this.checkState);

  final String value;

  bool checkState;
}

class _ListDemoState extends State<ReorderableListDemo> {
  final List<_ListItem> _items = <String>[
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  ].map<_ListItem>((String item) => _ListItem(item, false)).toList();

  Widget buildListTile(_ListItem item) {
    return CheckboxListTile(
      key: Key(item.value),
      isThreeLine: true,
      value: item.checkState ?? false,
      onChanged: (bool newValue) {
        setState(() {
          item.checkState = newValue;
        });
      },
      title: Text('This item represents ${item.value}.'),
      subtitle: Text(
        'Even more additional list item information appears on line three.',
      ),
      secondary: const Icon(Icons.drag_handle),
    );
//    return CheckboxListCell(key: Key(item.value), item: item);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorderable list'),
      ),
      body: Scrollbar(
        child: ReorderableListView(
          header: null,
          onReorder: _onReorder,
          reverse: false,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _items.map<Widget>(buildListTile).toList(),
        ),
      ),
    );
  }
}

class CheckboxListCell extends StatefulWidget {
  CheckboxListCell({Key key, this.item}) : super(key: key);

  final _ListItem item;
  @override
  _CheckboxListCellState createState() => _CheckboxListCellState();
}

class _CheckboxListCellState extends State<CheckboxListCell> {
  _ListItem _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        key: Key(_item.value),
        isThreeLine: true,
        value: _item.checkState ?? false,
        onChanged: (bool newValue) {
          setState(() {
            _item.checkState = newValue;
          });
        },
        title: Text('This item represents ${_item.value}.'),
        subtitle: const Text(
          'Even more additional list item information appears on line three.',
        ),
        secondary: const Icon(Icons.drag_handle)
    );
  }
}
