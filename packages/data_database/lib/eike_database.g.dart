// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eike_database.dart';

// ignore_for_file: type=lint
class $TeamContactTableTable extends TeamContactTable
    with TableInfo<$TeamContactTableTable, TeamContactEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamContactTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<TeamContactId, int> id =
      GeneratedColumn<int>(
        'id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<TeamContactId>($TeamContactTableTable.$converterid);
  @override
  late final GeneratedColumnWithTypeConverter<TeamContactTeamName, String>
  teamName =
      GeneratedColumn<String>(
        'team_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TeamContactTeamName>(
        $TeamContactTableTable.$converterteamName,
      );
  @override
  late final GeneratedColumnWithTypeConverter<TeamContactPhone, String> phone =
      GeneratedColumn<String>(
        'phone',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TeamContactPhone>($TeamContactTableTable.$converterphone);
  @override
  late final GeneratedColumnWithTypeConverter<TeamContactEmail, String> email =
      GeneratedColumn<String>(
        'email',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TeamContactEmail>($TeamContactTableTable.$converteremail);
  @override
  List<GeneratedColumn> get $columns => [id, teamName, phone, email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_contact_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamContactEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamContactEntity(
      id: $TeamContactTableTable.$converterid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}id'],
        )!,
      ),
      teamName: $TeamContactTableTable.$converterteamName.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}team_name'],
        )!,
      ),
      phone: $TeamContactTableTable.$converterphone.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}phone'],
        )!,
      ),
      email: $TeamContactTableTable.$converteremail.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}email'],
        )!,
      ),
    );
  }

  @override
  $TeamContactTableTable createAlias(String alias) {
    return $TeamContactTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TeamContactId, int> $converterid =
      const TeamContactIdConverter();
  static TypeConverter<TeamContactTeamName, String> $converterteamName =
      const TeamContactTeamNameConverter();
  static TypeConverter<TeamContactPhone, String> $converterphone =
      const TeamContactPhoneConverter();
  static TypeConverter<TeamContactEmail, String> $converteremail =
      const TeamContactEmailConverter();
}

class TeamContactEntity extends DataClass
    implements Insertable<TeamContactEntity> {
  final TeamContactId id;
  final TeamContactTeamName teamName;
  final TeamContactPhone phone;
  final TeamContactEmail email;
  const TeamContactEntity({
    required this.id,
    required this.teamName,
    required this.phone,
    required this.email,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['id'] = Variable<int>($TeamContactTableTable.$converterid.toSql(id));
    }
    {
      map['team_name'] = Variable<String>(
        $TeamContactTableTable.$converterteamName.toSql(teamName),
      );
    }
    {
      map['phone'] = Variable<String>(
        $TeamContactTableTable.$converterphone.toSql(phone),
      );
    }
    {
      map['email'] = Variable<String>(
        $TeamContactTableTable.$converteremail.toSql(email),
      );
    }
    return map;
  }

  TeamContactTableCompanion toCompanion(bool nullToAbsent) {
    return TeamContactTableCompanion(
      id: Value(id),
      teamName: Value(teamName),
      phone: Value(phone),
      email: Value(email),
    );
  }

  factory TeamContactEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamContactEntity(
      id: serializer.fromJson<TeamContactId>(json['id']),
      teamName: serializer.fromJson<TeamContactTeamName>(json['teamName']),
      phone: serializer.fromJson<TeamContactPhone>(json['phone']),
      email: serializer.fromJson<TeamContactEmail>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<TeamContactId>(id),
      'teamName': serializer.toJson<TeamContactTeamName>(teamName),
      'phone': serializer.toJson<TeamContactPhone>(phone),
      'email': serializer.toJson<TeamContactEmail>(email),
    };
  }

  TeamContactEntity copyWith({
    TeamContactId? id,
    TeamContactTeamName? teamName,
    TeamContactPhone? phone,
    TeamContactEmail? email,
  }) => TeamContactEntity(
    id: id ?? this.id,
    teamName: teamName ?? this.teamName,
    phone: phone ?? this.phone,
    email: email ?? this.email,
  );
  TeamContactEntity copyWithCompanion(TeamContactTableCompanion data) {
    return TeamContactEntity(
      id: data.id.present ? data.id.value : this.id,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamContactEntity(')
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
      (other is TeamContactEntity &&
          other.id == this.id &&
          other.teamName == this.teamName &&
          other.phone == this.phone &&
          other.email == this.email);
}

class TeamContactTableCompanion extends UpdateCompanion<TeamContactEntity> {
  final Value<TeamContactId> id;
  final Value<TeamContactTeamName> teamName;
  final Value<TeamContactPhone> phone;
  final Value<TeamContactEmail> email;
  const TeamContactTableCompanion({
    this.id = const Value.absent(),
    this.teamName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  TeamContactTableCompanion.insert({
    this.id = const Value.absent(),
    required TeamContactTeamName teamName,
    required TeamContactPhone phone,
    required TeamContactEmail email,
  }) : teamName = Value(teamName),
       phone = Value(phone),
       email = Value(email);
  static Insertable<TeamContactEntity> custom({
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

  TeamContactTableCompanion copyWith({
    Value<TeamContactId>? id,
    Value<TeamContactTeamName>? teamName,
    Value<TeamContactPhone>? phone,
    Value<TeamContactEmail>? email,
  }) {
    return TeamContactTableCompanion(
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
      map['id'] = Variable<int>(
        $TeamContactTableTable.$converterid.toSql(id.value),
      );
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(
        $TeamContactTableTable.$converterteamName.toSql(teamName.value),
      );
    }
    if (phone.present) {
      map['phone'] = Variable<String>(
        $TeamContactTableTable.$converterphone.toSql(phone.value),
      );
    }
    if (email.present) {
      map['email'] = Variable<String>(
        $TeamContactTableTable.$converteremail.toSql(email.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamContactTableCompanion(')
          ..write('id: $id, ')
          ..write('teamName: $teamName, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $TipTableTable extends TipTable
    with TableInfo<$TipTableTable, TipEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TipTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<TipId, int> id =
      GeneratedColumn<int>(
        'id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<TipId>($TipTableTable.$converterid);
  @override
  late final GeneratedColumnWithTypeConverter<TipPosition, int> position =
      GeneratedColumn<int>(
        'position',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TipPosition>($TipTableTable.$converterposition);
  @override
  late final GeneratedColumnWithTypeConverter<TipTitle, String> title =
      GeneratedColumn<String>(
        'title',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipTitle>($TipTableTable.$convertertitle);
  @override
  late final GeneratedColumnWithTypeConverter<TipDescription, String>
  description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<TipDescription>($TipTableTable.$converterdescription);
  @override
  late final GeneratedColumnWithTypeConverter<TipImagePath, String> imagePath =
      GeneratedColumn<String>(
        'image_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipImagePath>($TipTableTable.$converterimagePath);
  @override
  late final GeneratedColumnWithTypeConverter<TipImageDescription, String>
  imageDescription =
      GeneratedColumn<String>(
        'image_description',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipImageDescription>(
        $TipTableTable.$converterimageDescription,
      );
  @override
  late final GeneratedColumnWithTypeConverter<TipUserNote, String> userNote =
      GeneratedColumn<String>(
        'user_note',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipUserNote>($TipTableTable.$converteruserNote);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    position,
    title,
    description,
    imagePath,
    imageDescription,
    userNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tip_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TipEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TipEntity(
      id: $TipTableTable.$converterid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}id'],
        )!,
      ),
      position: $TipTableTable.$converterposition.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}position'],
        )!,
      ),
      title: $TipTableTable.$convertertitle.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}title'],
        )!,
      ),
      description: $TipTableTable.$converterdescription.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}description'],
        )!,
      ),
      imagePath: $TipTableTable.$converterimagePath.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_path'],
        )!,
      ),
      imageDescription: $TipTableTable.$converterimageDescription.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_description'],
        )!,
      ),
      userNote: $TipTableTable.$converteruserNote.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}user_note'],
        )!,
      ),
    );
  }

  @override
  $TipTableTable createAlias(String alias) {
    return $TipTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TipId, int> $converterid = const TipIdConverter();
  static TypeConverter<TipPosition, int> $converterposition =
      const TipPositionConverter();
  static TypeConverter<TipTitle, String> $convertertitle =
      const TipTitleConverter();
  static TypeConverter<TipDescription, String> $converterdescription =
      const TipDescriptionConverter();
  static TypeConverter<TipImagePath, String> $converterimagePath =
      const TipImagePathConverter();
  static TypeConverter<TipImageDescription, String> $converterimageDescription =
      const TipImageDescriptionConverter();
  static TypeConverter<TipUserNote, String> $converteruserNote =
      const TipUserNoteConverter();
}

class TipEntity extends DataClass implements Insertable<TipEntity> {
  final TipId id;
  final TipPosition position;
  final TipTitle title;
  final TipDescription description;
  final TipImagePath imagePath;
  final TipImageDescription imageDescription;
  final TipUserNote userNote;
  const TipEntity({
    required this.id,
    required this.position,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.imageDescription,
    required this.userNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['id'] = Variable<int>($TipTableTable.$converterid.toSql(id));
    }
    {
      map['position'] = Variable<int>(
        $TipTableTable.$converterposition.toSql(position),
      );
    }
    {
      map['title'] = Variable<String>(
        $TipTableTable.$convertertitle.toSql(title),
      );
    }
    {
      map['description'] = Variable<String>(
        $TipTableTable.$converterdescription.toSql(description),
      );
    }
    {
      map['image_path'] = Variable<String>(
        $TipTableTable.$converterimagePath.toSql(imagePath),
      );
    }
    {
      map['image_description'] = Variable<String>(
        $TipTableTable.$converterimageDescription.toSql(imageDescription),
      );
    }
    {
      map['user_note'] = Variable<String>(
        $TipTableTable.$converteruserNote.toSql(userNote),
      );
    }
    return map;
  }

  TipTableCompanion toCompanion(bool nullToAbsent) {
    return TipTableCompanion(
      id: Value(id),
      position: Value(position),
      title: Value(title),
      description: Value(description),
      imagePath: Value(imagePath),
      imageDescription: Value(imageDescription),
      userNote: Value(userNote),
    );
  }

  factory TipEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TipEntity(
      id: serializer.fromJson<TipId>(json['id']),
      position: serializer.fromJson<TipPosition>(json['position']),
      title: serializer.fromJson<TipTitle>(json['title']),
      description: serializer.fromJson<TipDescription>(json['description']),
      imagePath: serializer.fromJson<TipImagePath>(json['imagePath']),
      imageDescription: serializer.fromJson<TipImageDescription>(
        json['imageDescription'],
      ),
      userNote: serializer.fromJson<TipUserNote>(json['userNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<TipId>(id),
      'position': serializer.toJson<TipPosition>(position),
      'title': serializer.toJson<TipTitle>(title),
      'description': serializer.toJson<TipDescription>(description),
      'imagePath': serializer.toJson<TipImagePath>(imagePath),
      'imageDescription': serializer.toJson<TipImageDescription>(
        imageDescription,
      ),
      'userNote': serializer.toJson<TipUserNote>(userNote),
    };
  }

  TipEntity copyWith({
    TipId? id,
    TipPosition? position,
    TipTitle? title,
    TipDescription? description,
    TipImagePath? imagePath,
    TipImageDescription? imageDescription,
    TipUserNote? userNote,
  }) => TipEntity(
    id: id ?? this.id,
    position: position ?? this.position,
    title: title ?? this.title,
    description: description ?? this.description,
    imagePath: imagePath ?? this.imagePath,
    imageDescription: imageDescription ?? this.imageDescription,
    userNote: userNote ?? this.userNote,
  );
  TipEntity copyWithCompanion(TipTableCompanion data) {
    return TipEntity(
      id: data.id.present ? data.id.value : this.id,
      position: data.position.present ? data.position.value : this.position,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      imageDescription: data.imageDescription.present
          ? data.imageDescription.value
          : this.imageDescription,
      userNote: data.userNote.present ? data.userNote.value : this.userNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TipEntity(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageDescription: $imageDescription, ')
          ..write('userNote: $userNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    position,
    title,
    description,
    imagePath,
    imageDescription,
    userNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TipEntity &&
          other.id == this.id &&
          other.position == this.position &&
          other.title == this.title &&
          other.description == this.description &&
          other.imagePath == this.imagePath &&
          other.imageDescription == this.imageDescription &&
          other.userNote == this.userNote);
}

class TipTableCompanion extends UpdateCompanion<TipEntity> {
  final Value<TipId> id;
  final Value<TipPosition> position;
  final Value<TipTitle> title;
  final Value<TipDescription> description;
  final Value<TipImagePath> imagePath;
  final Value<TipImageDescription> imageDescription;
  final Value<TipUserNote> userNote;
  const TipTableCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageDescription = const Value.absent(),
    this.userNote = const Value.absent(),
  });
  TipTableCompanion.insert({
    this.id = const Value.absent(),
    required TipPosition position,
    required TipTitle title,
    required TipDescription description,
    required TipImagePath imagePath,
    required TipImageDescription imageDescription,
    required TipUserNote userNote,
  }) : position = Value(position),
       title = Value(title),
       description = Value(description),
       imagePath = Value(imagePath),
       imageDescription = Value(imageDescription),
       userNote = Value(userNote);
  static Insertable<TipEntity> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? imagePath,
    Expression<String>? imageDescription,
    Expression<String>? userNote,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imagePath != null) 'image_path': imagePath,
      if (imageDescription != null) 'image_description': imageDescription,
      if (userNote != null) 'user_note': userNote,
    });
  }

  TipTableCompanion copyWith({
    Value<TipId>? id,
    Value<TipPosition>? position,
    Value<TipTitle>? title,
    Value<TipDescription>? description,
    Value<TipImagePath>? imagePath,
    Value<TipImageDescription>? imageDescription,
    Value<TipUserNote>? userNote,
  }) {
    return TipTableCompanion(
      id: id ?? this.id,
      position: position ?? this.position,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      imageDescription: imageDescription ?? this.imageDescription,
      userNote: userNote ?? this.userNote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>($TipTableTable.$converterid.toSql(id.value));
    }
    if (position.present) {
      map['position'] = Variable<int>(
        $TipTableTable.$converterposition.toSql(position.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(
        $TipTableTable.$convertertitle.toSql(title.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(
        $TipTableTable.$converterdescription.toSql(description.value),
      );
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(
        $TipTableTable.$converterimagePath.toSql(imagePath.value),
      );
    }
    if (imageDescription.present) {
      map['image_description'] = Variable<String>(
        $TipTableTable.$converterimageDescription.toSql(imageDescription.value),
      );
    }
    if (userNote.present) {
      map['user_note'] = Variable<String>(
        $TipTableTable.$converteruserNote.toSql(userNote.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipTableCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageDescription: $imageDescription, ')
          ..write('userNote: $userNote')
          ..write(')'))
        .toString();
  }
}

abstract class _$EikeDatabase extends GeneratedDatabase {
  _$EikeDatabase(QueryExecutor e) : super(e);
  $EikeDatabaseManager get managers => $EikeDatabaseManager(this);
  late final $TeamContactTableTable teamContactTable = $TeamContactTableTable(
    this,
  );
  late final $TipTableTable tipTable = $TipTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teamContactTable,
    tipTable,
  ];
}

typedef $$TeamContactTableTableCreateCompanionBuilder =
    TeamContactTableCompanion Function({
      Value<TeamContactId> id,
      required TeamContactTeamName teamName,
      required TeamContactPhone phone,
      required TeamContactEmail email,
    });
typedef $$TeamContactTableTableUpdateCompanionBuilder =
    TeamContactTableCompanion Function({
      Value<TeamContactId> id,
      Value<TeamContactTeamName> teamName,
      Value<TeamContactPhone> phone,
      Value<TeamContactEmail> email,
    });

class $$TeamContactTableTableFilterComposer
    extends Composer<_$EikeDatabase, $TeamContactTableTable> {
  $$TeamContactTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<TeamContactId, TeamContactId, int> get id =>
      $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<
    TeamContactTeamName,
    TeamContactTeamName,
    String
  >
  get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TeamContactPhone, TeamContactPhone, String>
  get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TeamContactEmail, TeamContactEmail, String>
  get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TeamContactTableTableOrderingComposer
    extends Composer<_$EikeDatabase, $TeamContactTableTable> {
  $$TeamContactTableTableOrderingComposer({
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

class $$TeamContactTableTableAnnotationComposer
    extends Composer<_$EikeDatabase, $TeamContactTableTable> {
  $$TeamContactTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<TeamContactId, int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TeamContactTeamName, String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TeamContactPhone, String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TeamContactEmail, String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);
}

class $$TeamContactTableTableTableManager
    extends
        RootTableManager<
          _$EikeDatabase,
          $TeamContactTableTable,
          TeamContactEntity,
          $$TeamContactTableTableFilterComposer,
          $$TeamContactTableTableOrderingComposer,
          $$TeamContactTableTableAnnotationComposer,
          $$TeamContactTableTableCreateCompanionBuilder,
          $$TeamContactTableTableUpdateCompanionBuilder,
          (
            TeamContactEntity,
            BaseReferences<
              _$EikeDatabase,
              $TeamContactTableTable,
              TeamContactEntity
            >,
          ),
          TeamContactEntity,
          PrefetchHooks Function()
        > {
  $$TeamContactTableTableTableManager(
    _$EikeDatabase db,
    $TeamContactTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamContactTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamContactTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamContactTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<TeamContactId> id = const Value.absent(),
                Value<TeamContactTeamName> teamName = const Value.absent(),
                Value<TeamContactPhone> phone = const Value.absent(),
                Value<TeamContactEmail> email = const Value.absent(),
              }) => TeamContactTableCompanion(
                id: id,
                teamName: teamName,
                phone: phone,
                email: email,
              ),
          createCompanionCallback:
              ({
                Value<TeamContactId> id = const Value.absent(),
                required TeamContactTeamName teamName,
                required TeamContactPhone phone,
                required TeamContactEmail email,
              }) => TeamContactTableCompanion.insert(
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

typedef $$TeamContactTableTableProcessedTableManager =
    ProcessedTableManager<
      _$EikeDatabase,
      $TeamContactTableTable,
      TeamContactEntity,
      $$TeamContactTableTableFilterComposer,
      $$TeamContactTableTableOrderingComposer,
      $$TeamContactTableTableAnnotationComposer,
      $$TeamContactTableTableCreateCompanionBuilder,
      $$TeamContactTableTableUpdateCompanionBuilder,
      (
        TeamContactEntity,
        BaseReferences<
          _$EikeDatabase,
          $TeamContactTableTable,
          TeamContactEntity
        >,
      ),
      TeamContactEntity,
      PrefetchHooks Function()
    >;
typedef $$TipTableTableCreateCompanionBuilder = TipTableCompanion Function({
  Value<TipId> id,
  required TipPosition position,
  required TipTitle title,
  required TipDescription description,
  required TipImagePath imagePath,
  required TipImageDescription imageDescription,
  required TipUserNote userNote,
});
typedef $$TipTableTableUpdateCompanionBuilder = TipTableCompanion Function({
  Value<TipId> id,
  Value<TipPosition> position,
  Value<TipTitle> title,
  Value<TipDescription> description,
  Value<TipImagePath> imagePath,
  Value<TipImageDescription> imageDescription,
  Value<TipUserNote> userNote,
});

class $$TipTableTableFilterComposer
    extends Composer<_$EikeDatabase, $TipTableTable> {
  $$TipTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<TipId, TipId, int> get id =>
      $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TipPosition, TipPosition, int> get position =>
      $composableBuilder(
        column: $table.position,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TipTitle, TipTitle, String> get title =>
      $composableBuilder(
        column: $table.title,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TipDescription, TipDescription, String>
  get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TipImagePath, TipImagePath, String>
  get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    TipImageDescription,
    TipImageDescription,
    String
  >
  get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TipUserNote, TipUserNote, String>
  get userNote => $composableBuilder(
    column: $table.userNote,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TipTableTableOrderingComposer
    extends Composer<_$EikeDatabase, $TipTableTable> {
  $$TipTableTableOrderingComposer({
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

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userNote => $composableBuilder(
    column: $table.userNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TipTableTableAnnotationComposer
    extends Composer<_$EikeDatabase, $TipTableTable> {
  $$TipTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<TipId, int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipPosition, int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipTitle, String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipDescription, String> get description =>
      $composableBuilder(
        column: $table.description,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TipImagePath, String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipImageDescription, String>
  get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TipUserNote, String> get userNote =>
      $composableBuilder(column: $table.userNote, builder: (column) => column);
}

class $$TipTableTableTableManager
    extends
        RootTableManager<
          _$EikeDatabase,
          $TipTableTable,
          TipEntity,
          $$TipTableTableFilterComposer,
          $$TipTableTableOrderingComposer,
          $$TipTableTableAnnotationComposer,
          $$TipTableTableCreateCompanionBuilder,
          $$TipTableTableUpdateCompanionBuilder,
          (
            TipEntity,
            BaseReferences<_$EikeDatabase, $TipTableTable, TipEntity>,
          ),
          TipEntity,
          PrefetchHooks Function()
        > {
  $$TipTableTableTableManager(_$EikeDatabase db, $TipTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TipTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TipTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TipTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<TipId> id = const Value.absent(),
                Value<TipPosition> position = const Value.absent(),
                Value<TipTitle> title = const Value.absent(),
                Value<TipDescription> description = const Value.absent(),
                Value<TipImagePath> imagePath = const Value.absent(),
                Value<TipImageDescription> imageDescription =
                    const Value.absent(),
                Value<TipUserNote> userNote = const Value.absent(),
              }) => TipTableCompanion(
                id: id,
                position: position,
                title: title,
                description: description,
                imagePath: imagePath,
                imageDescription: imageDescription,
                userNote: userNote,
              ),
          createCompanionCallback:
              ({
                Value<TipId> id = const Value.absent(),
                required TipPosition position,
                required TipTitle title,
                required TipDescription description,
                required TipImagePath imagePath,
                required TipImageDescription imageDescription,
                required TipUserNote userNote,
              }) => TipTableCompanion.insert(
                id: id,
                position: position,
                title: title,
                description: description,
                imagePath: imagePath,
                imageDescription: imageDescription,
                userNote: userNote,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TipTableTableProcessedTableManager =
    ProcessedTableManager<
      _$EikeDatabase,
      $TipTableTable,
      TipEntity,
      $$TipTableTableFilterComposer,
      $$TipTableTableOrderingComposer,
      $$TipTableTableAnnotationComposer,
      $$TipTableTableCreateCompanionBuilder,
      $$TipTableTableUpdateCompanionBuilder,
      (TipEntity, BaseReferences<_$EikeDatabase, $TipTableTable, TipEntity>),
      TipEntity,
      PrefetchHooks Function()
    >;

class $EikeDatabaseManager {
  final _$EikeDatabase _db;
  $EikeDatabaseManager(this._db);
  $$TeamContactTableTableTableManager get teamContactTable =>
      $$TeamContactTableTableTableManager(_db, _db.teamContactTable);
  $$TipTableTableTableManager get tipTable =>
      $$TipTableTableTableManager(_db, _db.tipTable);
}
