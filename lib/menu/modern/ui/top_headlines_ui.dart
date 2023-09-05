import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../domain/remote_artible_cubit.dart';
import '../domain/remote_article_state.dart';
import '../model/article.dart';

@RoutePage()
class TopHeadlinesUi extends StatefulWidget {
  const TopHeadlinesUi({super.key});

  @override
  State<TopHeadlinesUi> createState() => _TopHeadlinesUiState();
}

class _TopHeadlinesUiState extends State<TopHeadlinesUi> {
  final _remoteArticleController =
      PagingController<int, Article>(firstPageKey: 1);

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
    return BlocListener(
      listener: (context, state) {
        switch (state) {
          case RemoteArticleLoading:
            break;
          default:
            break;
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) => const CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  Text('Top Headlines'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
