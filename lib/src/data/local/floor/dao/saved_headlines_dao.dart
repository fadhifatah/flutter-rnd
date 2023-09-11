import 'package:floor/floor.dart';

import '../entity/saved_headlines_entity.dart';

@dao
abstract class SavedHeadlinesDao {
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertAll(List<SavedHeadlinesEntity> dataList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(SavedHeadlinesEntity data);

  @Query('SELECT * FROM SavedHeadlinesEntity')
  Future<List<SavedHeadlinesEntity>> getList();

  @delete
  Future<void> remove(SavedHeadlinesEntity data);
}
