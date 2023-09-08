// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorNewsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsDatabaseBuilder databaseBuilder(String name) =>
      _$NewsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NewsDatabaseBuilder(null);
}

class _$NewsDatabaseBuilder {
  _$NewsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NewsDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NewsDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NewsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NewsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NewsDatabase extends NewsDatabase {
  _$NewsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TopHeadlinesDao? _topHeadlinesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TopHeadlinesEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `article` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TopHeadlinesDao get topHeadlinesDao {
    return _topHeadlinesDaoInstance ??=
        _$TopHeadlinesDao(database, changeListener);
  }
}

class _$TopHeadlinesDao extends TopHeadlinesDao {
  _$TopHeadlinesDao(
    this.database,
    this.changeListener,
  ) : _topHeadlinesEntityInsertionAdapter = InsertionAdapter(
            database,
            'TopHeadlinesEntity',
            (TopHeadlinesEntity item) => <String, Object?>{
                  'id': item.id,
                  'article': _articleConverter.encode(item.article)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<TopHeadlinesEntity>
      _topHeadlinesEntityInsertionAdapter;

  @override
  Future<void> insert(List<TopHeadlinesEntity> dataList) async {
    await _topHeadlinesEntityInsertionAdapter.insertList(
        dataList, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _sourceConverter = SourceConverter();
final _articleConverter = ArticleConverter();
