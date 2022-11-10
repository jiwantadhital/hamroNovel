// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likedatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorLikeDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LikeDatabaseBuilder databaseBuilder(String name) =>
      _$LikeDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LikeDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$LikeDatabaseBuilder(null);
}

class _$LikeDatabaseBuilder {
  _$LikeDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$LikeDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$LikeDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<LikeDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LikeDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$LikeDatabase extends LikeDatabase {
  _$LikeDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LikeDAO? _likeDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `UserLike` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `image` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LikeDAO get likeDAO {
    return _likeDAOInstance ??= _$LikeDAO(database, changeListener);
  }
}

class _$LikeDAO extends LikeDAO {
  _$LikeDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userLikeInsertionAdapter = InsertionAdapter(
            database,
            'UserLike',
            (UserLike item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image
                }),
        _userLikeDeletionAdapter = DeletionAdapter(
            database,
            'UserLike',
            ['id'],
            (UserLike item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserLike> _userLikeInsertionAdapter;

  final DeletionAdapter<UserLike> _userLikeDeletionAdapter;

  @override
  Future<List<UserLike?>> getAllFav() async {
    return _queryAdapter.queryList('SELECT * FROM UserLike',
        mapper: (Map<String, Object?> row) => UserLike(
            id: row['id'] as int,
            name: row['name'] as String,
            image: row['image'] as String));
  }

  @override
  Future<void> insertFav(UserLike fav) async {
    await _userLikeInsertionAdapter.insert(fav, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFav(UserLike fav) {
    return _userLikeDeletionAdapter.deleteAndReturnChangedRows(fav);
  }
}
