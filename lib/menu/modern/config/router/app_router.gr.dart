// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    TopHeadlinesUi.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TopHeadlinesUi(),
      );
    }
  };
}

/// generated route for
/// [TopHeadlinesUi]
class TopHeadlinesUi extends PageRouteInfo<void> {
  const TopHeadlinesUi({List<PageRouteInfo>? children})
      : super(
          TopHeadlinesUi.name,
          initialChildren: children,
        );

  static const String name = 'TopHeadlinesUi';

  static const PageInfo<void> page = PageInfo<void>(name);
}
