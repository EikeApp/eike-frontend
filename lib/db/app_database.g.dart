// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TeamContactsTable extends TeamContacts
    with TableInfo<$TeamContactsTable, TeamContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamNameMeta = const VerificationMeta(
    'teamName',
  );
  @override
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
    'team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, teamName, phone, email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamContact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_name')) {
      context.handle(
        _teamNameMeta,
        teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamContact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      teamName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
    );
  }

  @override
  $TeamContactsTable createAlias(String alias) {
    return $TeamContactsTable(attachedDatabase, alias);
  }
}

class TeamContact extends DataClass implements Insertable<TeamContact> {
  final int id;
  final String teamName;
  final String phone;
  final String email;
  const TeamContact({
    required this.id,
    required this.teamName,
    required this.phone,
    required this.email,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['team_name'] = Variable<String>(teamName);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    return map;
  }

  TeamContactsCompanion toCompanion(bool nullToAbsent) {
    return TeamContactsCompanion(
      id: Value(id),
      teamName: Value(teamName),
      phone: Value(phone),
      email: Value(email),
    );
  }

  factory TeamContact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamContact(
      id: serializer.fromJson<int>(json['id']),
      teamName: serializer.fromJson<String>(json['teamName']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'teamName': serializer.toJson<String>(teamName),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
    };
  }

  TeamContact copyWith({
    int? id,
    String? teamName,
    String? phone,
    String? email,
  }) => TeamContact(
    id: id ?? this.id,
    teamName: teamName ?? this.teamName,
    phone: phone ?? this.phone,
    email: email ?? this.email,
  );
  TeamContact copyWithCompanion(TeamContactsCompanion data) {
    return TeamContact(
      id: data.id.present ? data.id.value : this.id,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamContact(')
          ..write('id: $id, ')
          ..write('teamName: $teamName, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, teamName, phone, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamContact &&
          other.id == this.id &&
          other.teamName == this.teamName &&
          other.phone == this.phone &&
          other.email == this.email);
}

class TeamContactsCompanion extends UpdateCompanion<TeamContact> {
  final Value<int> id;
  final Value<String> teamName;
  final Value<String> phone;
  final Value<String> email;
  const TeamContactsCompanion({
    this.id = const Value.absent(),
    this.teamName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  TeamContactsCompanion.insert({
    this.id = const Value.absent(),
    this.teamName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  static Insertable<TeamContact> custom({
    Expression<int>? id,
    Expression<String>? teamName,
    Expression<String>? phone,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamName != null) 'team_name': teamName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    });
  }

  TeamContactsCompanion copyWith({
    Value<int>? id,
    Value<String>? teamName,
    Value<String>? phone,
    Value<String>? email,
  }) {
    return TeamContactsCompanion(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamContactsCompanion(')
          ..write('id: $id, ')
          ..write('teamName: $teamName, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeamContactsTable teamContacts = $TeamContactsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [teamContacts];
}

typedef $$TeamContactsTableCreateCompanionBuilder =
    TeamContactsCompanion Function({
      Value<int> id,
      Value<String> teamName,
      Value<String> phone,
      Value<String> email,
    });
typedef $$TeamContactsTableUpdateCompanionBuilder =
    TeamContactsCompanion Function({
      Value<int> id,
      Value<String> teamName,
      Value<String> phone,
      Value<String> email,
    });

class $$TeamContactsTableFilterComposer
    extends Composer<_$AppDatabase, $TeamContactsTable> {
  $$TeamContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamContactsTable> {
  $$TeamContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamContactsTable> {
  $$TeamContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);
}

class $$TeamContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamContactsTable,
          TeamContact,
          $$TeamContactsTableFilterComposer,
          $$TeamContactsTableOrderingComposer,
          $$TeamContactsTableAnnotationComposer,
          $$TeamContactsTableCreateCompanionBuilder,
          $$TeamContactsTableUpdateCompanionBuilder,
          (
            TeamContact,
            BaseReferences<_$AppDatabase, $TeamContactsTable, TeamContact>,
          ),
          TeamContact,
          PrefetchHooks Function()
        > {
  $$TeamContactsTableTableManager(_$AppDatabase db, $TeamContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> teamName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
              }) => TeamContactsCompanion(
                id: id,
                teamName: teamName,
                phone: phone,
                email: email,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> teamName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
              }) => TeamContactsCompanion.insert(
                id: id,
                teamName: teamName,
                phone: phone,
                email: email,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamContactsTable,
      TeamContact,
      $$TeamContactsTableFilterComposer,
      $$TeamContactsTableOrderingComposer,
      $$TeamContactsTableAnnotationComposer,
      $$TeamContactsTableCreateCompanionBuilder,
      $$TeamContactsTableUpdateCompanionBuilder,
      (
        TeamContact,
        BaseReferences<_$AppDatabase, $TeamContactsTable, TeamContact>,
      ),
      TeamContact,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeamContactsTableTableManager get teamContacts =>
      $$TeamContactsTableTableManager(_db, _db.teamContacts);
}
