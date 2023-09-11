import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_and_development/src/model/news/article.dart';

import '../../../res/values/strings.dart';
import '../../../res/values/styles.dart';
import '../../domain/cubit/saved_headlines/saved_headlines_cubit.dart';
import '../../domain/cubit/saved_headlines/saved_headlines_state.dart';

class SavedHeadlines extends StatefulWidget {
  final SavedHeadlinesCubit savedHeadlinesCubit;

  const SavedHeadlines({super.key, required this.savedHeadlinesCubit});

  @override
  State<SavedHeadlines> createState() => _SavedHeadlinesState();
}

class _SavedHeadlinesState extends State<SavedHeadlines> {
  SavedHeadlinesCubit get _cubit => widget.savedHeadlinesCubit;

  @override
  void initState() {
    super.initState();
    _cubit.getSavedHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.saved),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<SavedHeadlinesCubit, SavedHeadlinesState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case Loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Success:
              return _buildSavedCards(state.dataList);
            default:
              return const Placeholder();
          }
        },
      ),
    );
  }

  Widget _buildSavedCards(List<Article> dataList) {
    if (dataList.isEmpty) {
      return Center(
        child: Text(
          'Empty',
          style: Styles.titleTextStyle,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dataList.length,
      itemBuilder: (context, index) =>
          SavedCard(article: dataList[index], cubit: _cubit),
    );
  }
}

class SavedCard extends StatelessWidget {
  final Article article;
  final SavedHeadlinesCubit cubit;

  const SavedCard({super.key, required this.article, required this.cubit});

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
                        print('delete article');
                        cubit.deleteArticle(article);
                      },
                      child: const Text(Strings.delete),
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
