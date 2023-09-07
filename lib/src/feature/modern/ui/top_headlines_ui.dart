import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/link.dart';

import '../../../../res/values/configs.dart';
import '../../../domain/cubit/top_headlines/top_headlines_cubit.dart';
import '../../../domain/cubit/top_headlines/top_headlines_state.dart';
import '../../../model/news/article.dart';

class TopHeadlinesUi extends StatefulWidget {
  const TopHeadlinesUi({super.key});

  @override
  State<TopHeadlinesUi> createState() => _TopHeadlinesUiState();
}

class _TopHeadlinesUiState extends State<TopHeadlinesUi> {
  final _remoteArticleController =
      PagingController<int, Article>(firstPageKey: Configuration.firstPage);

  late final TopHeadlinesCubit? _remoteArticleCubit;

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
              title: const Text('Top Headlines'),
              actions: [
                Link(
                  uri: Uri.parse('http://frnd.fadhifatah.dev/'),
                  builder: (context, followLink) => ElevatedButton(
                    onPressed: followLink,
                    child: const Icon(Icons.home),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: PagedSliverList(
                pagingController: _remoteArticleController,
                builderDelegate: PagedChildBuilderDelegate<Article>(
                  itemBuilder: (context, item, index) =>
                      _buildItem(context, item),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _remoteArticleController.dispose();
  }
}

Widget _buildItem(BuildContext context, Article article) {
  final titleStyle = Theme.of(context).textTheme.titleSmall;
  final descriptionStyle = Theme.of(context).textTheme.bodyMedium;
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
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
              children: [
                Text(article.title ?? '', style: titleStyle),
                Text(article.description ?? '', style: descriptionStyle),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
    ),
  );
}
