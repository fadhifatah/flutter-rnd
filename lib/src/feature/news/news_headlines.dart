import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../res/values/configs.dart';
import '../../../res/values/strings.dart';
import '../../domain/cubit/saved_headlines/saved_headlines_cubit.dart';
import '../../domain/cubit/top_headlines/top_headlines_cubit.dart';
import '../../domain/cubit/top_headlines/top_headlines_state.dart';
import '../../model/news/article.dart';
import 'saved_headlines.dart';

class NewsHeadlines extends StatefulWidget {
  const NewsHeadlines({super.key});

  @override
  State<NewsHeadlines> createState() => _NewsHeadlinesState();
}

class _NewsHeadlinesState extends State<NewsHeadlines> {
  final _remoteArticleController =
      PagingController<int, Article>(firstPageKey: Configuration.firstPage);

  late final TopHeadlinesCubit? _remoteArticleCubit;
  late final SavedHeadlinesCubit? _savedHeadlinesCubit;

  @override
  void initState() {
    super.initState();
    _remoteArticleController.addPageRequestListener((pageKey) {
      _remoteArticleCubit?.fetchTopHeadlines(pageKey);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _remoteArticleCubit = BlocProvider.of<TopHeadlinesCubit>(context);
    _savedHeadlinesCubit = BlocProvider.of<SavedHeadlinesCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopHeadlinesCubit, TopHeadlinesState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case Loading:
            print('top_headlines loading');
            break;
          case Content:
            print('top_headlines content');
            if (state.isLastPage) {
              _remoteArticleController.appendLastPage(state.articles);
            } else {
              _remoteArticleController.appendPage(
                  state.articles, state.nextPage);
            }
            break;
          case Failed:
            print('top_headlines failed');
            break;
          default:
            break;
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) => CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              title: const Text('Top Headlines'),
              pinned: true,
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: Strings.saved,
                      child: Text(
                        Strings.saved,
                      ),
                    ),
                  ],
                  onSelected: (value) => _onMenuSelected(context, value),
                )
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: PagedSliverList(
                pagingController: _remoteArticleController,
                builderDelegate: PagedChildBuilderDelegate<Article>(
                  itemBuilder: (context, item, index) =>
                      _buildItem(context, item, _savedHeadlinesCubit),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    Article article,
    SavedHeadlinesCubit? savedHeadlinesCubit,
  ) {
    return NewsCard(article: article, cubit: savedHeadlinesCubit);
  }

  @override
  void dispose() {
    super.dispose();
    _remoteArticleController.dispose();
  }

  void _onMenuSelected(BuildContext context, String value) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SavedHeadlines(
            savedHeadlinesCubit: BlocProvider.of<SavedHeadlinesCubit>(context),
          ),
        ));
  }
}

class NewsCard extends StatelessWidget {
  final Article article;
  final SavedHeadlinesCubit? cubit;

  const NewsCard({super.key, required this.article, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final descriptionStyle = Theme.of(context).textTheme.bodyMedium;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: AspectRatio(
                aspectRatio: 3.0 / 4.0,
                child: Image.network(
                  article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Placeholder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? '',
                    style: titleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? '',
                    style: descriptionStyle,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        print('save article');
                        cubit?.saveArticle(article);
                      },
                      child: const Text(Strings.save),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
}
