import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum PexelsMenu { curated, search }

class Pexels extends StatefulWidget {
  @override
  State<Pexels> createState() => _PexelsState();
}

class _PexelsState extends State<Pexels> {
  var _selected = PexelsMenu.curated;

  void _onMenuSelected(PexelsMenu value) {
    setState(() {
      _selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            title: Row(
              children: [
                Text('Pexels'),
                SizedBox(width: 8.0),
                Text(
                  '(${_selected.name})',
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            ),
            actions: [
              PopupMenuButton(
                onSelected: _onMenuSelected,
                itemBuilder: (context) => PexelsMenu.values
                    .map((value) => PopupMenuItem(
                          value: value,
                          child: Row(
                            children: [
                              (_selected == value)
                                  ? Icon(Icons.check, color: Colors.teal)
                                  : SizedBox(height: 24.0, width: 24.0),
                              SizedBox(width: 16.0),
                              Text(value.name),
                            ],
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
          /* PagedSliverList(
            pagingController: PagingController(firstPageKey: 1),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                return Text('Text');
              },
            ),
          ), */ //TODO: Implement PagingController and set up request first
        ],
      ),
    );
  }
}
