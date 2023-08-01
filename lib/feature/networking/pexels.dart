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
  final _searchPageController = PagingController<int, Photo>(firstPageKey: 1);
  final _searchController = TextEditingController();

  var _selected = PexelsMenu.search;
  var _currentSearch = '';

  void _onMenuSelected(PexelsMenu value) {
    setState(() {
      _selected = value;
    });
  }

  PreferredSize? _buildSearchBar() {
    return (_selected != PexelsMenu.search)
        ? null
        : PreferredSize(
            preferredSize: Size.fromHeight(72.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What to search?',
                    ),
                    onSubmitted: (value) {
                      print('search bar submit');
                      if (_currentSearch != value) {
                        _currentSearch = value;
                        _searchPageController.refresh();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildItem(Photo photo) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          Positioned.fill(
            child: Image.network(
              photo.src.portrait,
              fit: BoxFit.cover,
            ),
          ),
          if (photo.alt.isNotEmpty)
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
                        photo.alt,
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
  }

  @override
  void initState() {
    super.initState();
    _curatedPageController.addPageRequestListener((pageKey) {
      getCuratedPexels(pageKey, 11, _curatedPageController);
    });

    _searchPageController.addPageRequestListener((pageKey) {
      getSearchPexels(
          _searchController.text, pageKey, 9, _searchPageController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  Text('Pexels'),
                  SizedBox(width: 2.0),
                  Text(
                    '(${_selected.name})',
                    style: TextStyle(fontSize: 12.0),
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
                                    ? Icon(Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)
                                    : SizedBox(height: 24.0, width: 24.0),
                                SizedBox(width: 16.0),
                                Text(value.name),
                              ],
                            ),
                          ))
                      .toList(),
                )
              ],
              bottom: _buildSearchBar(),
              snap: false,
              floating: true,
            ),
            SliverVisibility(
              visible: _selected == PexelsMenu.curated,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: PagedSliverGrid(
                  pagingController: _curatedPageController,
                  builderDelegate: PagedChildBuilderDelegate<Photo>(
                    itemBuilder: (context, item, index) => _buildItem(item),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constrains.maxWidth >= 600 ? 4 : 2,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                ),
              ),
            ),
            SliverVisibility(
              visible: _selected == PexelsMenu.search,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: PagedSliverGrid(
                  pagingController: _searchPageController,
                  builderDelegate: PagedChildBuilderDelegate<Photo>(
                    itemBuilder: (context, item, index) => _buildItem(item),
                    firstPageProgressIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Loading...'),
                        SizedBox(height: 16.0),
                        CircularProgressIndicator()
                      ],
                    ),
                    newPageProgressIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Getting new image. \nPlease wait!'),
                        SizedBox(height: 16.0),
                        CircularProgressIndicator(),
                      ],
                    ),
                    noItemsFoundIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('No item found. \nCheck your keyword or refresh!'),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            print('_searchPageController first page no item');
                            _searchPageController.refresh();
                          },
                          child: Text('Refresh'),
                        )
                      ],
                    ),
                    noMoreItemsIndicatorBuilder: (context) =>
                        Center(child: Text('This is the end :)')),
                    firstPageErrorIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ERROR! \nCheck your keyword!'),
                        SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(
                                '_searchPageController first page error: retry');
                            _searchPageController.retryLastFailedRequest();
                          },
                          child: Text('Retry'),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(
                                '_searchPageController first page error: reset');
                            _searchController.clear();
                            _searchPageController.refresh();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                    newPageErrorIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ERROR! \nSomething went wrong!'),
                        SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(
                                '_searchPageController new page error: retry');
                            _searchPageController.retryLastFailedRequest();
                          },
                          child: Text('Retry'),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print(
                                '_searchPageController new page error: reset');
                            _searchController.clear();
                            _searchPageController.refresh();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constrains.maxWidth >= 600 ? 4 : 2,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
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
    _searchPageController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
