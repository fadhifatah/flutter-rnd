import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';
import 'data/repository/api_repository.dart';
import 'domain/remote_artible_cubit.dart';
import 'injection/locator.dart';
import 'ui/top_headlines_ui.dart';

class ModernApp extends StatelessWidget {
  const ModernApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteArtibleCubit(
            locator<ApiRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Navigation',
        theme: AppTheme.light,
        home: const TopHeadlinesUi(),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
      ),
    );
  }
}
