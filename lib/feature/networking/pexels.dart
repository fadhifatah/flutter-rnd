import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:research_and_development/feature/networking/model/photo.dart';
import 'package:research_and_development/feature/networking/remote/repository.dart';

/// Based on existed available REST API in Photos category from Pexels
/// https://www.pexels.com/api/documentation/#photos
enum PexelsMenu { curated, search }

/// Display a collection of Photos. It has infinite scroll with pagination.
/// https://pub.dev/packages/infinite_scroll_pagination
///
/// Using CustomScrollView with Sliver to handling rich animation and transition.
class Pexels extends StatefulWidget {
  @override
  State<Pexels> createState() => _PexelsState();
}

class _PexelsState extends State<Pexels> {
  // Defined PagingController, both for curated and search page
  final _curatedPageController = PagingController<int, Photo>(firstPageKey: 1);
  final _searchPageController = PagingController<int, Photo>(firstPageKey: 1);
  // Also a TextEditingController for search bar :)
  final _searchController = TextEditingController();

  // Some useful flags or states(?)
  var _selected = PexelsMenu.curated;
  var _currentSearch = '';

  // PopupMenuButton listener
  void _onMenuSelected(PexelsMenu value) {
    setState(() {
      _selected = value;
    });
  }

  // Whether to show search bar based on _selected
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
                    textInputAction: TextInputAction.search,
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

  // PagedSliverGrid item which is used both for curated and search page
  Widget _buildItem(Photo photo) {
    return GestureDetector(
      onTap: () {
        print('onTap item: ${photo.url}');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PexelsDetail(photo: photo),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Positioned.fill(
              // A tasty Hero implementation :p
              child: Hero(
                tag: photo,
                child: Image.network(
                  photo.src.portrait,
                  fit: BoxFit.cover,
                ),
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
      ),
    );
  }

  /// StatefulWidget will intiate these first. It sets up a PagingController
  /// listener: [_searchPageController] and [_curatedPageController]
  @override
  void initState() {
    super.initState();
    _curatedPageController.addPageRequestListener((pageKey) {
      // Still using old [http] package module. 
      // For next project, will be using Dio and/or Retrofit with MVVM :))
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
        // Try a new CustomScrollView. Must using Sliver object!
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
                // This Widget is automatically converted into Icons.more_vert
                // inside AppBar actions.
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
                          child: Text('Reset'),
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

  /// For every controller that exist in this StatefulWidget must be disposed!
  @override
  void dispose() {
    _curatedPageController.dispose();
    _searchPageController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

/// Simple Hero application when PagedSliverGrid item clicked (tapped)
class PexelsDetail extends StatelessWidget {
  final Photo photo;

  const PexelsDetail({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    var avgColor =
        (photo.avgColor.isEmpty) ? 'FFFFFFFF' : photo.avgColor.substring(1);
    var fixAvgColor = (avgColor.length < 8) ? 'FF$avgColor' : avgColor;
    var hexColor = int.parse(fixAvgColor, radix: 16);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          print('onTap item back');
          Navigator.pop(context);
        },
        child: Container(
          color: Color(hexColor),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Hero(
                tag: photo,
                child: Image.network(
                  photo.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
