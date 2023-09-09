import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_and_development/src/domain/cubit/saved_headlines/saved_headlines_cubit.dart';

import '../../../res/values/themes.dart';
import '../../data/repository/news_api_repository.dart';
import '../../data/repository/news_db_repository.dart';
import '../../domain/cubit/top_headlines/top_headlines_cubit.dart';
import '../../injection/locator.dart';
import 'ui/top_headlines_ui.dart';

class ModernApp extends StatelessWidget {
  const ModernApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopHeadlinesCubit(
            locator<NewsApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SavedHeadlinesCubit(
            locator<NewsDbRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Navigation',
        theme: Themes.modern,
        home: const TopHeadlinesUi(),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
      ),
    );
  }
}
