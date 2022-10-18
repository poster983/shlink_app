//MARK: Location
import 'package:drift/drift.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/services/Service.dart';

part 'DriftCommon.g.dart';



//MARK: Short Urls
@UseRowClass(ShortUrl, constructor: "fromDB")
class DBShortUrl extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get longUrl => text()();
  TextColumn get shortUrl => text()();
  TextColumn get slug => text()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get visitCount => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get serviceId => text()();
  TextColumn get title => text().nullable()();

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
  TextColumn get shortUrlId => text().withLength(min: 36, max: 36).references(DBShortUrl, #id, onDelete: KeyAction.cascade)();
  
  //visit info 
  TextColumn get referrer => text().nullable()();
  TextColumn get userAgent => text().nullable()();
  BoolColumn get potentialBot => boolean().nullable()();
  DateTimeColumn get date => dateTime()();

  //location info
  TextColumn get locationCountry => text().nullable()();
  TextColumn get locationRegion => text().nullable()();
  TextColumn get locationCity => text().nullable()();
  TextColumn get locationTimezone => text().nullable()();
  RealColumn get locationLatitude => real().nullable()();
  RealColumn get locationLongitude => real().nullable()();


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



@DriftDatabase(tables: [DBShortUrl, DBShortUrlVisit])
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

