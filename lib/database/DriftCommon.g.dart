// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriftCommon.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DBServiceCompanion extends UpdateCompanion<Service> {
  final Value<String> id;
  const DBServiceCompanion({
    this.id = const Value.absent(),
  });
  DBServiceCompanion.insert({
    required String id,
  }) : id = Value(id);
  static Insertable<Service> custom({
    Expression<String>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  DBServiceCompanion copyWith({Value<String>? id}) {
    return DBServiceCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBServiceCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $DBServiceTable extends DBService
    with TableInfo<$DBServiceTable, Service> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBServiceTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'd_b_service';
  @override
  String get actualTableName => 'd_b_service';
  @override
  VerificationContext validateIntegrity(Insertable<Service> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Service map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Service.fromDB();
  }

  @override
  $DBServiceTable createAlias(String alias) {
    return $DBServiceTable(attachedDatabase, alias);
  }
}

class DBShortUrlCompanion extends UpdateCompanion<ShortUrl> {
  final Value<String> id;
  const DBShortUrlCompanion({
    this.id = const Value.absent(),
  });
  DBShortUrlCompanion.insert({
    required String id,
  }) : id = Value(id);
  static Insertable<ShortUrl> custom({
    Expression<String>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  DBShortUrlCompanion copyWith({Value<String>? id}) {
    return DBShortUrlCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBShortUrlCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $DBShortUrlTable extends DBShortUrl
    with TableInfo<$DBShortUrlTable, ShortUrl> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBShortUrlTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'd_b_short_url';
  @override
  String get actualTableName => 'd_b_short_url';
  @override
  VerificationContext validateIntegrity(Insertable<ShortUrl> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortUrl map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortUrl.fromDB();
  }

  @override
  $DBShortUrlTable createAlias(String alias) {
    return $DBShortUrlTable(attachedDatabase, alias);
  }
}

class DBShortUrlVisitCompanion extends UpdateCompanion<ShortUrlVisit> {
  final Value<String> id;
  const DBShortUrlVisitCompanion({
    this.id = const Value.absent(),
  });
  DBShortUrlVisitCompanion.insert({
    required String id,
  }) : id = Value(id);
  static Insertable<ShortUrlVisit> custom({
    Expression<String>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  DBShortUrlVisitCompanion copyWith({Value<String>? id}) {
    return DBShortUrlVisitCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBShortUrlVisitCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $DBShortUrlVisitTable extends DBShortUrlVisit
    with TableInfo<$DBShortUrlVisitTable, ShortUrlVisit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBShortUrlVisitTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'd_b_short_url_visit';
  @override
  String get actualTableName => 'd_b_short_url_visit';
  @override
  VerificationContext validateIntegrity(Insertable<ShortUrlVisit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortUrlVisit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortUrlVisit.fromDB();
  }

  @override
  $DBShortUrlVisitTable createAlias(String alias) {
    return $DBShortUrlVisitTable(attachedDatabase, alias);
  }
}

abstract class _$ShortishDatabase extends GeneratedDatabase {
  _$ShortishDatabase(QueryExecutor e) : super(e);
  late final $DBServiceTable dBService = $DBServiceTable(this);
  late final $DBShortUrlTable dBShortUrl = $DBShortUrlTable(this);
  late final $DBShortUrlVisitTable dBShortUrlVisit =
      $DBShortUrlVisitTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dBService, dBShortUrl, dBShortUrlVisit];
}
