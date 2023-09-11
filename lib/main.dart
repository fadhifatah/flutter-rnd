import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_and_development/src/injection/locator.dart';

import 'res/values/routes.dart';
import 'res/values/strings.dart';
import 'res/values/themes.dart';
import 'src/data/repository/news_api_repository.dart';
import 'src/data/repository/news_db_repository.dart';
import 'src/domain/cubit/saved_headlines/saved_headlines_cubit.dart';
import 'src/domain/cubit/top_headlines/top_headlines_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;

  await initializeDependencies();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
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
        ),
    ],
    child: MaterialApp.router(
          title: Strings.appName,
          theme: Themes.mainDefault,
          routerConfig: Routes.routerConfig,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
        ),
  );
}
