// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ActivityTableData extends DataClass
    implements Insertable<ActivityTableData> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final String name;
  ActivityTableData(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.name});
  factory ActivityTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ActivityTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updateAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory ActivityTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ActivityTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  ActivityTableCompanion createCompanion(bool nullToAbsent) {
    return ActivityTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updateAt: updateAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updateAt),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  ActivityTableData copyWith(
          {String id, DateTime createdAt, DateTime updateAt, String name}) =>
      ActivityTableData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ActivityTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(createdAt.hashCode, $mrjc(updateAt.hashCode, name.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ActivityTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.name == this.name);
}

class ActivityTableCompanion extends UpdateCompanion<ActivityTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<String> name;
  const ActivityTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  ActivityTableCompanion.insert({
    @required String id,
    @required DateTime createdAt,
    @required DateTime updateAt,
    @required String name,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt),
        name = Value(name);
  ActivityTableCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<String> name}) {
    return ActivityTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      name: name ?? this.name,
    );
  }
}

class $ActivityTableTable extends ActivityTable
    with TableInfo<$ActivityTableTable, ActivityTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ActivityTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  GeneratedDateTimeColumn _updateAt;
  @override
  GeneratedDateTimeColumn get updateAt => _updateAt ??= _constructUpdateAt();
  GeneratedDateTimeColumn _constructUpdateAt() {
    return GeneratedDateTimeColumn(
      'update_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updateAt, name];
  @override
  $ActivityTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'activity_table';
  @override
  final String actualTableName = 'activity_table';
  @override
  VerificationContext validateIntegrity(ActivityTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updateAt.present) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableValue(d.updateAt.value, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ActivityTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ActivityTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updateAt.present) {
      map['update_at'] = Variable<DateTime, DateTimeType>(d.updateAt.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $ActivityTableTable createAlias(String alias) {
    return $ActivityTableTable(_db, alias);
  }
}

class ActivityMemberTableData extends DataClass
    implements Insertable<ActivityMemberTableData> {
  final String activityRef;
  final String personRef;
  ActivityMemberTableData(
      {@required this.activityRef, @required this.personRef});
  factory ActivityMemberTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ActivityMemberTableData(
      activityRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}activity_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ActivityMemberTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ActivityMemberTableData(
      activityRef: serializer.fromJson<String>(json['activityRef']),
      personRef: serializer.fromJson<String>(json['personRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'activityRef': serializer.toJson<String>(activityRef),
      'personRef': serializer.toJson<String>(personRef),
    };
  }

  @override
  ActivityMemberTableCompanion createCompanion(bool nullToAbsent) {
    return ActivityMemberTableCompanion(
      activityRef: activityRef == null && nullToAbsent
          ? const Value.absent()
          : Value(activityRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ActivityMemberTableData copyWith({String activityRef, String personRef}) =>
      ActivityMemberTableData(
        activityRef: activityRef ?? this.activityRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ActivityMemberTableData(')
          ..write('activityRef: $activityRef, ')
          ..write('personRef: $personRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(activityRef.hashCode, personRef.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ActivityMemberTableData &&
          other.activityRef == this.activityRef &&
          other.personRef == this.personRef);
}

class ActivityMemberTableCompanion
    extends UpdateCompanion<ActivityMemberTableData> {
  final Value<String> activityRef;
  final Value<String> personRef;
  const ActivityMemberTableCompanion({
    this.activityRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ActivityMemberTableCompanion.insert({
    @required String activityRef,
    @required String personRef,
  })  : activityRef = Value(activityRef),
        personRef = Value(personRef);
  ActivityMemberTableCompanion copyWith(
      {Value<String> activityRef, Value<String> personRef}) {
    return ActivityMemberTableCompanion(
      activityRef: activityRef ?? this.activityRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ActivityMemberTableTable extends ActivityMemberTable
    with TableInfo<$ActivityMemberTableTable, ActivityMemberTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ActivityMemberTableTable(this._db, [this._alias]);
  final VerificationMeta _activityRefMeta =
      const VerificationMeta('activityRef');
  GeneratedTextColumn _activityRef;
  @override
  GeneratedTextColumn get activityRef =>
      _activityRef ??= _constructActivityRef();
  GeneratedTextColumn _constructActivityRef() {
    return GeneratedTextColumn(
      'activity_ref',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personRefMeta = const VerificationMeta('personRef');
  GeneratedTextColumn _personRef;
  @override
  GeneratedTextColumn get personRef => _personRef ??= _constructPersonRef();
  GeneratedTextColumn _constructPersonRef() {
    return GeneratedTextColumn(
      'person_ref',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [activityRef, personRef];
  @override
  $ActivityMemberTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'activity_member_table';
  @override
  final String actualTableName = 'activity_member_table';
  @override
  VerificationContext validateIntegrity(ActivityMemberTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.activityRef.present) {
      context.handle(_activityRefMeta,
          activityRef.isAcceptableValue(d.activityRef.value, _activityRefMeta));
    } else if (isInserting) {
      context.missing(_activityRefMeta);
    }
    if (d.personRef.present) {
      context.handle(_personRefMeta,
          personRef.isAcceptableValue(d.personRef.value, _personRefMeta));
    } else if (isInserting) {
      context.missing(_personRefMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {activityRef, personRef};
  @override
  ActivityMemberTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ActivityMemberTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ActivityMemberTableCompanion d) {
    final map = <String, Variable>{};
    if (d.activityRef.present) {
      map['activity_ref'] = Variable<String, StringType>(d.activityRef.value);
    }
    if (d.personRef.present) {
      map['person_ref'] = Variable<String, StringType>(d.personRef.value);
    }
    return map;
  }

  @override
  $ActivityMemberTableTable createAlias(String alias) {
    return $ActivityMemberTableTable(_db, alias);
  }
}

class ExpenseParticipantTableData extends DataClass
    implements Insertable<ExpenseParticipantTableData> {
  final String expenseRef;
  final String personRef;
  ExpenseParticipantTableData(
      {@required this.expenseRef, @required this.personRef});
  factory ExpenseParticipantTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ExpenseParticipantTableData(
      expenseRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ExpenseParticipantTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExpenseParticipantTableData(
      expenseRef: serializer.fromJson<String>(json['expenseRef']),
      personRef: serializer.fromJson<String>(json['personRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'expenseRef': serializer.toJson<String>(expenseRef),
      'personRef': serializer.toJson<String>(personRef),
    };
  }

  @override
  ExpenseParticipantTableCompanion createCompanion(bool nullToAbsent) {
    return ExpenseParticipantTableCompanion(
      expenseRef: expenseRef == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ExpenseParticipantTableData copyWith({String expenseRef, String personRef}) =>
      ExpenseParticipantTableData(
        expenseRef: expenseRef ?? this.expenseRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseParticipantTableData(')
          ..write('expenseRef: $expenseRef, ')
          ..write('personRef: $personRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(expenseRef.hashCode, personRef.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ExpenseParticipantTableData &&
          other.expenseRef == this.expenseRef &&
          other.personRef == this.personRef);
}

class ExpenseParticipantTableCompanion
    extends UpdateCompanion<ExpenseParticipantTableData> {
  final Value<String> expenseRef;
  final Value<String> personRef;
  const ExpenseParticipantTableCompanion({
    this.expenseRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ExpenseParticipantTableCompanion.insert({
    @required String expenseRef,
    @required String personRef,
  })  : expenseRef = Value(expenseRef),
        personRef = Value(personRef);
  ExpenseParticipantTableCompanion copyWith(
      {Value<String> expenseRef, Value<String> personRef}) {
    return ExpenseParticipantTableCompanion(
      expenseRef: expenseRef ?? this.expenseRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ExpenseParticipantTableTable extends ExpenseParticipantTable
    with TableInfo<$ExpenseParticipantTableTable, ExpenseParticipantTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpenseParticipantTableTable(this._db, [this._alias]);
  final VerificationMeta _expenseRefMeta = const VerificationMeta('expenseRef');
  GeneratedTextColumn _expenseRef;
  @override
  GeneratedTextColumn get expenseRef => _expenseRef ??= _constructExpenseRef();
  GeneratedTextColumn _constructExpenseRef() {
    return GeneratedTextColumn(
      'expense_ref',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personRefMeta = const VerificationMeta('personRef');
  GeneratedTextColumn _personRef;
  @override
  GeneratedTextColumn get personRef => _personRef ??= _constructPersonRef();
  GeneratedTextColumn _constructPersonRef() {
    return GeneratedTextColumn(
      'person_ref',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [expenseRef, personRef];
  @override
  $ExpenseParticipantTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expense_participant_table';
  @override
  final String actualTableName = 'expense_participant_table';
  @override
  VerificationContext validateIntegrity(ExpenseParticipantTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.expenseRef.present) {
      context.handle(_expenseRefMeta,
          expenseRef.isAcceptableValue(d.expenseRef.value, _expenseRefMeta));
    } else if (isInserting) {
      context.missing(_expenseRefMeta);
    }
    if (d.personRef.present) {
      context.handle(_personRefMeta,
          personRef.isAcceptableValue(d.personRef.value, _personRefMeta));
    } else if (isInserting) {
      context.missing(_personRefMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {expenseRef, personRef};
  @override
  ExpenseParticipantTableData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExpenseParticipantTableData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpenseParticipantTableCompanion d) {
    final map = <String, Variable>{};
    if (d.expenseRef.present) {
      map['expense_ref'] = Variable<String, StringType>(d.expenseRef.value);
    }
    if (d.personRef.present) {
      map['person_ref'] = Variable<String, StringType>(d.personRef.value);
    }
    return map;
  }

  @override
  $ExpenseParticipantTableTable createAlias(String alias) {
    return $ExpenseParticipantTableTable(_db, alias);
  }
}

class ExpensePayerTableData extends DataClass
    implements Insertable<ExpensePayerTableData> {
  final String expenseRef;
  final String personRef;
  ExpensePayerTableData({@required this.expenseRef, @required this.personRef});
  factory ExpensePayerTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ExpensePayerTableData(
      expenseRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ExpensePayerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExpensePayerTableData(
      expenseRef: serializer.fromJson<String>(json['expenseRef']),
      personRef: serializer.fromJson<String>(json['personRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'expenseRef': serializer.toJson<String>(expenseRef),
      'personRef': serializer.toJson<String>(personRef),
    };
  }

  @override
  ExpensePayerTableCompanion createCompanion(bool nullToAbsent) {
    return ExpensePayerTableCompanion(
      expenseRef: expenseRef == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ExpensePayerTableData copyWith({String expenseRef, String personRef}) =>
      ExpensePayerTableData(
        expenseRef: expenseRef ?? this.expenseRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ExpensePayerTableData(')
          ..write('expenseRef: $expenseRef, ')
          ..write('personRef: $personRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(expenseRef.hashCode, personRef.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ExpensePayerTableData &&
          other.expenseRef == this.expenseRef &&
          other.personRef == this.personRef);
}

class ExpensePayerTableCompanion
    extends UpdateCompanion<ExpensePayerTableData> {
  final Value<String> expenseRef;
  final Value<String> personRef;
  const ExpensePayerTableCompanion({
    this.expenseRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ExpensePayerTableCompanion.insert({
    @required String expenseRef,
    @required String personRef,
  })  : expenseRef = Value(expenseRef),
        personRef = Value(personRef);
  ExpensePayerTableCompanion copyWith(
      {Value<String> expenseRef, Value<String> personRef}) {
    return ExpensePayerTableCompanion(
      expenseRef: expenseRef ?? this.expenseRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ExpensePayerTableTable extends ExpensePayerTable
    with TableInfo<$ExpensePayerTableTable, ExpensePayerTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpensePayerTableTable(this._db, [this._alias]);
  final VerificationMeta _expenseRefMeta = const VerificationMeta('expenseRef');
  GeneratedTextColumn _expenseRef;
  @override
  GeneratedTextColumn get expenseRef => _expenseRef ??= _constructExpenseRef();
  GeneratedTextColumn _constructExpenseRef() {
    return GeneratedTextColumn(
      'expense_ref',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personRefMeta = const VerificationMeta('personRef');
  GeneratedTextColumn _personRef;
  @override
  GeneratedTextColumn get personRef => _personRef ??= _constructPersonRef();
  GeneratedTextColumn _constructPersonRef() {
    return GeneratedTextColumn(
      'person_ref',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [expenseRef, personRef];
  @override
  $ExpensePayerTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expense_payer_table';
  @override
  final String actualTableName = 'expense_payer_table';
  @override
  VerificationContext validateIntegrity(ExpensePayerTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.expenseRef.present) {
      context.handle(_expenseRefMeta,
          expenseRef.isAcceptableValue(d.expenseRef.value, _expenseRefMeta));
    } else if (isInserting) {
      context.missing(_expenseRefMeta);
    }
    if (d.personRef.present) {
      context.handle(_personRefMeta,
          personRef.isAcceptableValue(d.personRef.value, _personRefMeta));
    } else if (isInserting) {
      context.missing(_personRefMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {expenseRef, personRef};
  @override
  ExpensePayerTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExpensePayerTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpensePayerTableCompanion d) {
    final map = <String, Variable>{};
    if (d.expenseRef.present) {
      map['expense_ref'] = Variable<String, StringType>(d.expenseRef.value);
    }
    if (d.personRef.present) {
      map['person_ref'] = Variable<String, StringType>(d.personRef.value);
    }
    return map;
  }

  @override
  $ExpensePayerTableTable createAlias(String alias) {
    return $ExpensePayerTableTable(_db, alias);
  }
}

class ExpenseTableData extends DataClass
    implements Insertable<ExpenseTableData> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final double amount;
  final String paidFor;
  ExpenseTableData(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.amount,
      @required this.paidFor});
  factory ExpenseTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return ExpenseTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updateAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      paidFor: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}paid_for']),
    );
  }
  factory ExpenseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExpenseTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
      amount: serializer.fromJson<double>(json['amount']),
      paidFor: serializer.fromJson<String>(json['paidFor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
      'amount': serializer.toJson<double>(amount),
      'paidFor': serializer.toJson<String>(paidFor),
    };
  }

  @override
  ExpenseTableCompanion createCompanion(bool nullToAbsent) {
    return ExpenseTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updateAt: updateAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updateAt),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      paidFor: paidFor == null && nullToAbsent
          ? const Value.absent()
          : Value(paidFor),
    );
  }

  ExpenseTableData copyWith(
          {String id,
          DateTime createdAt,
          DateTime updateAt,
          double amount,
          String paidFor}) =>
      ExpenseTableData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        amount: amount ?? this.amount,
        paidFor: paidFor ?? this.paidFor,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('amount: $amount, ')
          ..write('paidFor: $paidFor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(createdAt.hashCode,
          $mrjc(updateAt.hashCode, $mrjc(amount.hashCode, paidFor.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ExpenseTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.amount == this.amount &&
          other.paidFor == this.paidFor);
}

class ExpenseTableCompanion extends UpdateCompanion<ExpenseTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<double> amount;
  final Value<String> paidFor;
  const ExpenseTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.amount = const Value.absent(),
    this.paidFor = const Value.absent(),
  });
  ExpenseTableCompanion.insert({
    @required String id,
    @required DateTime createdAt,
    @required DateTime updateAt,
    @required double amount,
    @required String paidFor,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt),
        amount = Value(amount),
        paidFor = Value(paidFor);
  ExpenseTableCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<double> amount,
      Value<String> paidFor}) {
    return ExpenseTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      amount: amount ?? this.amount,
      paidFor: paidFor ?? this.paidFor,
    );
  }
}

class $ExpenseTableTable extends ExpenseTable
    with TableInfo<$ExpenseTableTable, ExpenseTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpenseTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  GeneratedDateTimeColumn _updateAt;
  @override
  GeneratedDateTimeColumn get updateAt => _updateAt ??= _constructUpdateAt();
  GeneratedDateTimeColumn _constructUpdateAt() {
    return GeneratedDateTimeColumn(
      'update_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedRealColumn _amount;
  @override
  GeneratedRealColumn get amount => _amount ??= _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _paidForMeta = const VerificationMeta('paidFor');
  GeneratedTextColumn _paidFor;
  @override
  GeneratedTextColumn get paidFor => _paidFor ??= _constructPaidFor();
  GeneratedTextColumn _constructPaidFor() {
    return GeneratedTextColumn(
      'paid_for',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updateAt, amount, paidFor];
  @override
  $ExpenseTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expense_table';
  @override
  final String actualTableName = 'expense_table';
  @override
  VerificationContext validateIntegrity(ExpenseTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updateAt.present) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableValue(d.updateAt.value, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (d.paidFor.present) {
      context.handle(_paidForMeta,
          paidFor.isAcceptableValue(d.paidFor.value, _paidForMeta));
    } else if (isInserting) {
      context.missing(_paidForMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExpenseTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpenseTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updateAt.present) {
      map['update_at'] = Variable<DateTime, DateTimeType>(d.updateAt.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<double, RealType>(d.amount.value);
    }
    if (d.paidFor.present) {
      map['paid_for'] = Variable<String, StringType>(d.paidFor.value);
    }
    return map;
  }

  @override
  $ExpenseTableTable createAlias(String alias) {
    return $ExpenseTableTable(_db, alias);
  }
}

class PeopleTableData extends DataClass implements Insertable<PeopleTableData> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final String name;
  PeopleTableData(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.name});
  factory PeopleTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PeopleTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updateAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory PeopleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PeopleTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  PeopleTableCompanion createCompanion(bool nullToAbsent) {
    return PeopleTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updateAt: updateAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updateAt),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  PeopleTableData copyWith(
          {String id, DateTime createdAt, DateTime updateAt, String name}) =>
      PeopleTableData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('PeopleTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(createdAt.hashCode, $mrjc(updateAt.hashCode, name.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PeopleTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.name == this.name);
}

class PeopleTableCompanion extends UpdateCompanion<PeopleTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<String> name;
  const PeopleTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  PeopleTableCompanion.insert({
    @required String id,
    @required DateTime createdAt,
    @required DateTime updateAt,
    @required String name,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt),
        name = Value(name);
  PeopleTableCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<String> name}) {
    return PeopleTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      name: name ?? this.name,
    );
  }
}

class $PeopleTableTable extends PeopleTable
    with TableInfo<$PeopleTableTable, PeopleTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PeopleTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  GeneratedDateTimeColumn _updateAt;
  @override
  GeneratedDateTimeColumn get updateAt => _updateAt ??= _constructUpdateAt();
  GeneratedDateTimeColumn _constructUpdateAt() {
    return GeneratedDateTimeColumn(
      'update_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updateAt, name];
  @override
  $PeopleTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'people_table';
  @override
  final String actualTableName = 'people_table';
  @override
  VerificationContext validateIntegrity(PeopleTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.updateAt.present) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableValue(d.updateAt.value, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeopleTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PeopleTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PeopleTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.updateAt.present) {
      map['update_at'] = Variable<DateTime, DateTimeType>(d.updateAt.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $PeopleTableTable createAlias(String alias) {
    return $PeopleTableTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ActivityTableTable _activityTable;
  $ActivityTableTable get activityTable =>
      _activityTable ??= $ActivityTableTable(this);
  $ActivityMemberTableTable _activityMemberTable;
  $ActivityMemberTableTable get activityMemberTable =>
      _activityMemberTable ??= $ActivityMemberTableTable(this);
  $ExpenseParticipantTableTable _expenseParticipantTable;
  $ExpenseParticipantTableTable get expenseParticipantTable =>
      _expenseParticipantTable ??= $ExpenseParticipantTableTable(this);
  $ExpensePayerTableTable _expensePayerTable;
  $ExpensePayerTableTable get expensePayerTable =>
      _expensePayerTable ??= $ExpensePayerTableTable(this);
  $ExpenseTableTable _expenseTable;
  $ExpenseTableTable get expenseTable =>
      _expenseTable ??= $ExpenseTableTable(this);
  $PeopleTableTable _peopleTable;
  $PeopleTableTable get peopleTable => _peopleTable ??= $PeopleTableTable(this);
  ActivityLocalDatasource _activityLocalDatasource;
  ActivityLocalDatasource get activityLocalDatasource =>
      _activityLocalDatasource ??=
          ActivityLocalDatasource(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        activityTable,
        activityMemberTable,
        expenseParticipantTable,
        expensePayerTable,
        expenseTable,
        peopleTable
      ];
}
