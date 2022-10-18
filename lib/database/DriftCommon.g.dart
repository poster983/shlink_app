// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriftCommon.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DBShortUrlCompanion extends UpdateCompanion<ShortUrl> {
  final Value<String> id;
  final Value<String> longUrl;
  final Value<String> shortUrl;
  final Value<String> slug;
  final Value<DateTime> dateCreated;
  final Value<int?> visitCount;
  final Value<String?> notes;
  final Value<String> serviceId;
  final Value<String?> title;
  const DBShortUrlCompanion({
    this.id = const Value.absent(),
    this.longUrl = const Value.absent(),
    this.shortUrl = const Value.absent(),
    this.slug = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.visitCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.title = const Value.absent(),
  });
  DBShortUrlCompanion.insert({
    required String id,
    required String longUrl,
    required String shortUrl,
    required String slug,
    required DateTime dateCreated,
    this.visitCount = const Value.absent(),
    this.notes = const Value.absent(),
    required String serviceId,
    this.title = const Value.absent(),
  })  : id = Value(id),
        longUrl = Value(longUrl),
        shortUrl = Value(shortUrl),
        slug = Value(slug),
        dateCreated = Value(dateCreated),
        serviceId = Value(serviceId);
  static Insertable<ShortUrl> custom({
    Expression<String>? id,
    Expression<String>? longUrl,
    Expression<String>? shortUrl,
    Expression<String>? slug,
    Expression<DateTime>? dateCreated,
    Expression<int>? visitCount,
    Expression<String>? notes,
    Expression<String>? serviceId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (longUrl != null) 'long_url': longUrl,
      if (shortUrl != null) 'short_url': shortUrl,
      if (slug != null) 'slug': slug,
      if (dateCreated != null) 'date_created': dateCreated,
      if (visitCount != null) 'visit_count': visitCount,
      if (notes != null) 'notes': notes,
      if (serviceId != null) 'service_id': serviceId,
      if (title != null) 'title': title,
    });
  }

  DBShortUrlCompanion copyWith(
      {Value<String>? id,
      Value<String>? longUrl,
      Value<String>? shortUrl,
      Value<String>? slug,
      Value<DateTime>? dateCreated,
      Value<int?>? visitCount,
      Value<String?>? notes,
      Value<String>? serviceId,
      Value<String?>? title}) {
    return DBShortUrlCompanion(
      id: id ?? this.id,
      longUrl: longUrl ?? this.longUrl,
      shortUrl: shortUrl ?? this.shortUrl,
      slug: slug ?? this.slug,
      dateCreated: dateCreated ?? this.dateCreated,
      visitCount: visitCount ?? this.visitCount,
      notes: notes ?? this.notes,
      serviceId: serviceId ?? this.serviceId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (longUrl.present) {
      map['long_url'] = Variable<String>(longUrl.value);
    }
    if (shortUrl.present) {
      map['short_url'] = Variable<String>(shortUrl.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (visitCount.present) {
      map['visit_count'] = Variable<int>(visitCount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBShortUrlCompanion(')
          ..write('id: $id, ')
          ..write('longUrl: $longUrl, ')
          ..write('shortUrl: $shortUrl, ')
          ..write('slug: $slug, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('visitCount: $visitCount, ')
          ..write('notes: $notes, ')
          ..write('serviceId: $serviceId, ')
          ..write('title: $title')
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
  final VerificationMeta _longUrlMeta = const VerificationMeta('longUrl');
  @override
  late final GeneratedColumn<String> longUrl = GeneratedColumn<String>(
      'long_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _shortUrlMeta = const VerificationMeta('shortUrl');
  @override
  late final GeneratedColumn<String> shortUrl = GeneratedColumn<String>(
      'short_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  @override
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
      'date_created', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _visitCountMeta = const VerificationMeta('visitCount');
  @override
  late final GeneratedColumn<int> visitCount = GeneratedColumn<int>(
      'visit_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _serviceIdMeta = const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        longUrl,
        shortUrl,
        slug,
        dateCreated,
        visitCount,
        notes,
        serviceId,
        title
      ];
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
    if (data.containsKey('long_url')) {
      context.handle(_longUrlMeta,
          longUrl.isAcceptableOrUnknown(data['long_url']!, _longUrlMeta));
    } else if (isInserting) {
      context.missing(_longUrlMeta);
    }
    if (data.containsKey('short_url')) {
      context.handle(_shortUrlMeta,
          shortUrl.isAcceptableOrUnknown(data['short_url']!, _shortUrlMeta));
    } else if (isInserting) {
      context.missing(_shortUrlMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    } else if (isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (data.containsKey('visit_count')) {
      context.handle(
          _visitCountMeta,
          visitCount.isAcceptableOrUnknown(
              data['visit_count']!, _visitCountMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortUrl map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortUrl.fromDB(
      longUrl: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}long_url'])!,
      shortUrl: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}short_url'])!,
      slug: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      dateCreated: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!,
      visitCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}visit_count']),
      serviceId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      notes: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
    );
  }

  @override
  $DBShortUrlTable createAlias(String alias) {
    return $DBShortUrlTable(attachedDatabase, alias);
  }
}

class DBShortUrlVisitCompanion extends UpdateCompanion<ShortUrlVisit> {
  final Value<String> id;
  final Value<String> shortUrlId;
  final Value<String?> referrer;
  final Value<String?> userAgent;
  final Value<bool?> potentialBot;
  final Value<DateTime> date;
  final Value<String?> locationCountry;
  final Value<String?> locationRegion;
  final Value<String?> locationCity;
  final Value<String?> locationTimezone;
  final Value<double?> locationLatitude;
  final Value<double?> locationLongitude;
  const DBShortUrlVisitCompanion({
    this.id = const Value.absent(),
    this.shortUrlId = const Value.absent(),
    this.referrer = const Value.absent(),
    this.userAgent = const Value.absent(),
    this.potentialBot = const Value.absent(),
    this.date = const Value.absent(),
    this.locationCountry = const Value.absent(),
    this.locationRegion = const Value.absent(),
    this.locationCity = const Value.absent(),
    this.locationTimezone = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
  });
  DBShortUrlVisitCompanion.insert({
    required String id,
    required String shortUrlId,
    this.referrer = const Value.absent(),
    this.userAgent = const Value.absent(),
    this.potentialBot = const Value.absent(),
    required DateTime date,
    this.locationCountry = const Value.absent(),
    this.locationRegion = const Value.absent(),
    this.locationCity = const Value.absent(),
    this.locationTimezone = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
  })  : id = Value(id),
        shortUrlId = Value(shortUrlId),
        date = Value(date);
  static Insertable<ShortUrlVisit> custom({
    Expression<String>? id,
    Expression<String>? shortUrlId,
    Expression<String>? referrer,
    Expression<String>? userAgent,
    Expression<bool>? potentialBot,
    Expression<DateTime>? date,
    Expression<String>? locationCountry,
    Expression<String>? locationRegion,
    Expression<String>? locationCity,
    Expression<String>? locationTimezone,
    Expression<double>? locationLatitude,
    Expression<double>? locationLongitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shortUrlId != null) 'short_url_id': shortUrlId,
      if (referrer != null) 'referrer': referrer,
      if (userAgent != null) 'user_agent': userAgent,
      if (potentialBot != null) 'potential_bot': potentialBot,
      if (date != null) 'date': date,
      if (locationCountry != null) 'location_country': locationCountry,
      if (locationRegion != null) 'location_region': locationRegion,
      if (locationCity != null) 'location_city': locationCity,
      if (locationTimezone != null) 'location_timezone': locationTimezone,
      if (locationLatitude != null) 'location_latitude': locationLatitude,
      if (locationLongitude != null) 'location_longitude': locationLongitude,
    });
  }

  DBShortUrlVisitCompanion copyWith(
      {Value<String>? id,
      Value<String>? shortUrlId,
      Value<String?>? referrer,
      Value<String?>? userAgent,
      Value<bool?>? potentialBot,
      Value<DateTime>? date,
      Value<String?>? locationCountry,
      Value<String?>? locationRegion,
      Value<String?>? locationCity,
      Value<String?>? locationTimezone,
      Value<double?>? locationLatitude,
      Value<double?>? locationLongitude}) {
    return DBShortUrlVisitCompanion(
      id: id ?? this.id,
      shortUrlId: shortUrlId ?? this.shortUrlId,
      referrer: referrer ?? this.referrer,
      userAgent: userAgent ?? this.userAgent,
      potentialBot: potentialBot ?? this.potentialBot,
      date: date ?? this.date,
      locationCountry: locationCountry ?? this.locationCountry,
      locationRegion: locationRegion ?? this.locationRegion,
      locationCity: locationCity ?? this.locationCity,
      locationTimezone: locationTimezone ?? this.locationTimezone,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shortUrlId.present) {
      map['short_url_id'] = Variable<String>(shortUrlId.value);
    }
    if (referrer.present) {
      map['referrer'] = Variable<String>(referrer.value);
    }
    if (userAgent.present) {
      map['user_agent'] = Variable<String>(userAgent.value);
    }
    if (potentialBot.present) {
      map['potential_bot'] = Variable<bool>(potentialBot.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (locationCountry.present) {
      map['location_country'] = Variable<String>(locationCountry.value);
    }
    if (locationRegion.present) {
      map['location_region'] = Variable<String>(locationRegion.value);
    }
    if (locationCity.present) {
      map['location_city'] = Variable<String>(locationCity.value);
    }
    if (locationTimezone.present) {
      map['location_timezone'] = Variable<String>(locationTimezone.value);
    }
    if (locationLatitude.present) {
      map['location_latitude'] = Variable<double>(locationLatitude.value);
    }
    if (locationLongitude.present) {
      map['location_longitude'] = Variable<double>(locationLongitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBShortUrlVisitCompanion(')
          ..write('id: $id, ')
          ..write('shortUrlId: $shortUrlId, ')
          ..write('referrer: $referrer, ')
          ..write('userAgent: $userAgent, ')
          ..write('potentialBot: $potentialBot, ')
          ..write('date: $date, ')
          ..write('locationCountry: $locationCountry, ')
          ..write('locationRegion: $locationRegion, ')
          ..write('locationCity: $locationCity, ')
          ..write('locationTimezone: $locationTimezone, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude')
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
  final VerificationMeta _shortUrlIdMeta = const VerificationMeta('shortUrlId');
  @override
  late final GeneratedColumn<String> shortUrlId = GeneratedColumn<String>(
      'short_url_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES "d_b_short_url" ("id") ON DELETE CASCADE');
  final VerificationMeta _referrerMeta = const VerificationMeta('referrer');
  @override
  late final GeneratedColumn<String> referrer = GeneratedColumn<String>(
      'referrer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _userAgentMeta = const VerificationMeta('userAgent');
  @override
  late final GeneratedColumn<String> userAgent = GeneratedColumn<String>(
      'user_agent', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _potentialBotMeta =
      const VerificationMeta('potentialBot');
  @override
  late final GeneratedColumn<bool> potentialBot = GeneratedColumn<bool>(
      'potential_bot', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("potential_bot" IN (0, 1))');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _locationCountryMeta =
      const VerificationMeta('locationCountry');
  @override
  late final GeneratedColumn<String> locationCountry = GeneratedColumn<String>(
      'location_country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _locationRegionMeta =
      const VerificationMeta('locationRegion');
  @override
  late final GeneratedColumn<String> locationRegion = GeneratedColumn<String>(
      'location_region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _locationCityMeta =
      const VerificationMeta('locationCity');
  @override
  late final GeneratedColumn<String> locationCity = GeneratedColumn<String>(
      'location_city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _locationTimezoneMeta =
      const VerificationMeta('locationTimezone');
  @override
  late final GeneratedColumn<String> locationTimezone = GeneratedColumn<String>(
      'location_timezone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _locationLatitudeMeta =
      const VerificationMeta('locationLatitude');
  @override
  late final GeneratedColumn<double> locationLatitude = GeneratedColumn<double>(
      'location_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  final VerificationMeta _locationLongitudeMeta =
      const VerificationMeta('locationLongitude');
  @override
  late final GeneratedColumn<double> locationLongitude =
      GeneratedColumn<double>('location_longitude', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shortUrlId,
        referrer,
        userAgent,
        potentialBot,
        date,
        locationCountry,
        locationRegion,
        locationCity,
        locationTimezone,
        locationLatitude,
        locationLongitude
      ];
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
    if (data.containsKey('short_url_id')) {
      context.handle(
          _shortUrlIdMeta,
          shortUrlId.isAcceptableOrUnknown(
              data['short_url_id']!, _shortUrlIdMeta));
    } else if (isInserting) {
      context.missing(_shortUrlIdMeta);
    }
    if (data.containsKey('referrer')) {
      context.handle(_referrerMeta,
          referrer.isAcceptableOrUnknown(data['referrer']!, _referrerMeta));
    }
    if (data.containsKey('user_agent')) {
      context.handle(_userAgentMeta,
          userAgent.isAcceptableOrUnknown(data['user_agent']!, _userAgentMeta));
    }
    if (data.containsKey('potential_bot')) {
      context.handle(
          _potentialBotMeta,
          potentialBot.isAcceptableOrUnknown(
              data['potential_bot']!, _potentialBotMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('location_country')) {
      context.handle(
          _locationCountryMeta,
          locationCountry.isAcceptableOrUnknown(
              data['location_country']!, _locationCountryMeta));
    }
    if (data.containsKey('location_region')) {
      context.handle(
          _locationRegionMeta,
          locationRegion.isAcceptableOrUnknown(
              data['location_region']!, _locationRegionMeta));
    }
    if (data.containsKey('location_city')) {
      context.handle(
          _locationCityMeta,
          locationCity.isAcceptableOrUnknown(
              data['location_city']!, _locationCityMeta));
    }
    if (data.containsKey('location_timezone')) {
      context.handle(
          _locationTimezoneMeta,
          locationTimezone.isAcceptableOrUnknown(
              data['location_timezone']!, _locationTimezoneMeta));
    }
    if (data.containsKey('location_latitude')) {
      context.handle(
          _locationLatitudeMeta,
          locationLatitude.isAcceptableOrUnknown(
              data['location_latitude']!, _locationLatitudeMeta));
    }
    if (data.containsKey('location_longitude')) {
      context.handle(
          _locationLongitudeMeta,
          locationLongitude.isAcceptableOrUnknown(
              data['location_longitude']!, _locationLongitudeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortUrlVisit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortUrlVisit.fromDB(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      referrer: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}referrer']),
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      userAgent: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}user_agent']),
      shortUrlId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}short_url_id'])!,
      potentialBot: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}potential_bot']),
      locationCountry: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}location_country']),
      locationRegion: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}location_region']),
      locationCity: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}location_city']),
      locationTimezone: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}location_timezone']),
      locationLatitude: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}location_latitude']),
      locationLongitude: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}location_longitude']),
    );
  }

  @override
  $DBShortUrlVisitTable createAlias(String alias) {
    return $DBShortUrlVisitTable(attachedDatabase, alias);
  }
}

abstract class _$ShortishDatabase extends GeneratedDatabase {
  _$ShortishDatabase(QueryExecutor e) : super(e);
  late final $DBShortUrlTable dBShortUrl = $DBShortUrlTable(this);
  late final $DBShortUrlVisitTable dBShortUrlVisit =
      $DBShortUrlVisitTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dBShortUrl, dBShortUrlVisit];
}
