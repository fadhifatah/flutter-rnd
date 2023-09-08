import 'package:floor/floor.dart';

import '../entity/top_headlines_entity.dart';

@dao
abstract class TopHeadlinesDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(List<TopHeadlinesEntity> dataList);
}