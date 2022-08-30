// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavouriteDAO? _favouriteDAOInstance;

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
            'CREATE TABLE IF NOT EXISTS `Favourite` (`id` INTEGER NOT NULL, `uid` TEXT NOT NULL, `all` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavouriteDAO get favouriteDAO {
    return _favouriteDAOInstance ??= _$FavouriteDAO(database, changeListener);
  }
}

class _$FavouriteDAO extends FavouriteDAO {
  _$FavouriteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favouriteInsertionAdapter = InsertionAdapter(
            database,
            'Favourite',
            (Favourite item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'all': item.all
                }),
        _favouriteDeletionAdapter = DeletionAdapter(
            database,
            'Favourite',
            ['id'],
            (Favourite item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'all': item.all
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favourite> _favouriteInsertionAdapter;

  final DeletionAdapter<Favourite> _favouriteDeletionAdapter;

  @override
  Future<List<Favourite?>> getAllFav() async {
    return _queryAdapter.queryList('SELECT * FROM Favourite',
        mapper: (Map<String, Object?> row) => Favourite(
            id: row['id'] as int,
            uid: row['uid'] as String,
            all: row['all'] as String));
  }

  @override
  Future<Favourite?> getFavByUid(String uid, int id) async {
    return _queryAdapter.query('SELECT * FROM Favourite WHERE uid=?1 AND id=?2',
        mapper: (Map<String, Object?> row) => Favourite(
            id: row['id'] as int,
            uid: row['uid'] as String,
            all: row['all'] as String),
        arguments: [uid, id]);
  }

  @override
  Future<void> insertFav(Favourite fav) async {
    await _favouriteInsertionAdapter.insert(fav, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFav(Favourite fav) {
    return _favouriteDeletionAdapter.deleteAndReturnChangedRows(fav);
  }
}
