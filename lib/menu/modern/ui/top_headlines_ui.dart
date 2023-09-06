import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/link.dart';

import '../domain/remote_artible_cubit.dart';
import '../domain/remote_article_state.dart';
import '../model/article.dart';

class TopHeadlinesUi extends StatefulWidget {
  const TopHeadlinesUi({super.key});

  @override
  State<TopHeadlinesUi> createState() => _TopHeadlinesUiState();
}

class _TopHeadlinesUiState extends State<TopHeadlinesUi> {
  final _remoteArticleController = PagingController<int, Article>(
      firstPageKey: RemoteArtibleCubit.firstPage);

  late final RemoteArtibleCubit? _remoteArticleCubit;

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
    _remoteArticleCubit = BlocProvider.of<RemoteArtibleCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteArtibleCubit, RemoteArticleState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case RemoteArticleLoading:
            print('top_headlines loading');
            break;
          case RemoteArticleContent:
            print('top_headlines content');
            if (state.isLastPage) {
              _remoteArticleController.appendLastPage(state.articles);
            } else {
              _remoteArticleController.appendPage(
                  state.articles, state.nextPage);
            }
            break;
          case RemoteArticleFailed:
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
