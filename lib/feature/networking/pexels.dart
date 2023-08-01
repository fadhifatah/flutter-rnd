import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:research_and_development/feature/networking/model/photo.dart';
import 'package:research_and_development/feature/networking/remote/repository.dart';

enum PexelsMenu { curated, search }

class Pexels extends StatefulWidget {
  @override
  State<Pexels> createState() => _PexelsState();
}

class _PexelsState extends State<Pexels> {
  final _curatedPageController = PagingController<int, Photo>(firstPageKey: 1);

  var _selected = PexelsMenu.curated;

  void _onMenuSelected(PexelsMenu value) {
    setState(() {
      _selected = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _curatedPageController.addPageRequestListener((pageKey) {
      getCuratedPexels(pageKey, 11, _curatedPageController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
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
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: PagedSliverGrid(
                pagingController: _curatedPageController,
                builderDelegate: PagedChildBuilderDelegate<Photo>(
                  itemBuilder: (context, item, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Stack(
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          Positioned.fill(
                            child: Image.network(
                              item.src.portrait,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (item.alt.isNotEmpty)
                            Positioned(
                              left: 8.0,
                              right: 8.0,
                              bottom: 8.0,
                              child: Wrap(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        item.alt,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constrains.maxWidth >= 600 ? 4 : 2,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _curatedPageController.dispose();
    super.dispose();
  }
}
