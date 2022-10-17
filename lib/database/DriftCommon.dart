//MARK: Location
import 'package:drift/drift.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/services/Service.dart';

part 'DriftCommon.g.dart';

///MARK Service
@UseRowClass(Service, constructor: "fromDB")
class DBService extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  // TextColumn get passId => text().withLength(min: 36, max: 36).references(DBPasses, #id, onDelete: KeyAction.cascade)();
  // TextColumn get address => text().nullable()();
  // RealColumn get latitude => real()();
  // RealColumn get longitude => real()();

  @override
  Set < Column > get primaryKey => {
    id
  };
}

//MARK: Short Urls
@UseRowClass(ShortUrl, constructor: "fromDB")
class DBShortUrl extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().withLength(min: 36, max: 36)();
  // TextColumn get format => text()();
  // TextColumn get dataType => text()();
  // TextColumn get rawData => text()();
  // IntColumn get color => integer()();
  // TextColumn get name => text()();
  // TextColumn get notes => text().nullable()();
  // DateTimeColumn get expirationDate => dateTime().nullable()();
  // DateTimeColumn get relevantDate => dateTime().nullable()();
  // DateTimeColumn get creationDate => dateTime()();
  // DateTimeColumn get modifiedDate => dateTime().nullable()();
  // TextColumn get style => text()();
  // BoolColumn get pinned => boolean()();
  // BoolColumn get archived => boolean()();
  // BoolColumn get autoArchive => boolean()();
  // BoolColumn get sharedFromImport => boolean()();
  // TextColumn get icon => text().nullable()();
  // BoolColumn get locked => boolean().withDefault(const Constant(false))();

  // @override
  // Set<Column> get secon => {id};
  @override
  Set < Column > get primaryKey => {
    id
  };
}

//MARK: Short Url Visits
@UseRowClass(ShortUrlVisit, constructor: "fromDB")
class DBShortUrlVisit extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  @override
  Set < Column > get primaryKey => {
    id
  };
}


// //MARK: Deleted
// @UseRowClass(Deleted, generateInsertable: true)
// class DBDeleted extends Table {
//   TextColumn get id => text().withLength(min: 36, max: 36)();

//   DateTimeColumn get deleteDate => dateTime()();
  
//   TextColumn get table => text()();

//   @override
//   Set < Column > get primaryKey => {
//     id
//   };
// }



@DriftDatabase(tables: [DBService, DBShortUrl, DBShortUrlVisit])
class ShortishDatabase extends _$ShortishDatabase {
  // we tell the database where to store the data with this constructor

  // ShortishDatabase.connect(DatabaseConnection connection) : super.connect(connection);
  ShortishDatabase(QueryExecutor e): super(e);


  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      beforeOpen: (details) async {
        // if (details.wasCreated) {
        //   // ...
        // }
        await customStatement('PRAGMA foreign_keys = ON');
      },

      onUpgrade: (Migrator m, int from, int to) async {
        // Log.i("Upgrading Database from $from to $to");
      
        // if (from < 3) {
        //   // we added the priority property in the change from version 1 or 2
        //   // to version 3
        //   await m.addColumn(todos, todos.priority);
        // }
      },
    );
  }
}

