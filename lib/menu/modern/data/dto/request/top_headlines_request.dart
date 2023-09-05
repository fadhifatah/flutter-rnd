import '../../../config/configuration.dart';

class TopHeadlinesRequest {
  final String? country;
  final String? category;
  final String? source;
  final String? keyword;
  final int pageSize;
  final int page;

  const TopHeadlinesRequest({
    this.category = 'general',
    this.country = Configuration.countryDefault,
    this.source,
    this.keyword,
    this.page = 1,
    this.pageSize = Configuration.pageSizeDefault,
  });
}
