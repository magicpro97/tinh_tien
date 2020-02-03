// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Activity extends DataClass implements Insertable<Activity> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final String name;
  Activity(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.name});
  factory Activity.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Activity(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updateAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory Activity.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Activity(
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
  ActivitiesCompanion createCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
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

  Activity copyWith(
          {String id, DateTime createdAt, DateTime updateAt, String name}) =>
      Activity(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Activity(')
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
          (other is Activity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.name == this.name);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<String> name;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    @required String id,
    @required DateTime createdAt,
    @required DateTime updateAt,
    @required String name,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt),
        name = Value(name);
  ActivitiesCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<String> name}) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      name: name ?? this.name,
    );
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  final GeneratedDatabase _db;
  final String _alias;
  $ActivitiesTable(this._db, [this._alias]);
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
  $ActivitiesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'activities';
  @override
  final String actualTableName = 'activities';
  @override
  VerificationContext validateIntegrity(ActivitiesCompanion d,
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
  Activity map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Activity.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ActivitiesCompanion d) {
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
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(_db, alias);
  }
}

class ActivityMember extends DataClass implements Insertable<ActivityMember> {
  final String activityRef;
  final String personRef;
  ActivityMember({@required this.activityRef, @required this.personRef});
  factory ActivityMember.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ActivityMember(
      activityRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}activity_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ActivityMember.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ActivityMember(
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
  ActivityMembersCompanion createCompanion(bool nullToAbsent) {
    return ActivityMembersCompanion(
      activityRef: activityRef == null && nullToAbsent
          ? const Value.absent()
          : Value(activityRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ActivityMember copyWith({String activityRef, String personRef}) =>
      ActivityMember(
        activityRef: activityRef ?? this.activityRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ActivityMember(')
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
          (other is ActivityMember &&
          other.activityRef == this.activityRef &&
          other.personRef == this.personRef);
}

class ActivityMembersCompanion extends UpdateCompanion<ActivityMember> {
  final Value<String> activityRef;
  final Value<String> personRef;
  const ActivityMembersCompanion({
    this.activityRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ActivityMembersCompanion.insert({
    @required String activityRef,
    @required String personRef,
  })  : activityRef = Value(activityRef),
        personRef = Value(personRef);
  ActivityMembersCompanion copyWith(
      {Value<String> activityRef, Value<String> personRef}) {
    return ActivityMembersCompanion(
      activityRef: activityRef ?? this.activityRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ActivityMembersTable extends ActivityMembers
    with TableInfo<$ActivityMembersTable, ActivityMember> {
  final GeneratedDatabase _db;
  final String _alias;
  $ActivityMembersTable(this._db, [this._alias]);
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
  $ActivityMembersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'activity_members';
  @override
  final String actualTableName = 'activity_members';
  @override
  VerificationContext validateIntegrity(ActivityMembersCompanion d,
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
  ActivityMember map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ActivityMember.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ActivityMembersCompanion d) {
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
  $ActivityMembersTable createAlias(String alias) {
    return $ActivityMembersTable(_db, alias);
  }
}

class ExpenseParticipant extends DataClass
    implements Insertable<ExpenseParticipant> {
  final String expenseRef;
  final String personRef;
  ExpenseParticipant({@required this.expenseRef, @required this.personRef});
  factory ExpenseParticipant.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ExpenseParticipant(
      expenseRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ExpenseParticipant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExpenseParticipant(
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
  ExpenseParticipantsCompanion createCompanion(bool nullToAbsent) {
    return ExpenseParticipantsCompanion(
      expenseRef: expenseRef == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ExpenseParticipant copyWith({String expenseRef, String personRef}) =>
      ExpenseParticipant(
        expenseRef: expenseRef ?? this.expenseRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseParticipant(')
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
          (other is ExpenseParticipant &&
          other.expenseRef == this.expenseRef &&
          other.personRef == this.personRef);
}

class ExpenseParticipantsCompanion extends UpdateCompanion<ExpenseParticipant> {
  final Value<String> expenseRef;
  final Value<String> personRef;
  const ExpenseParticipantsCompanion({
    this.expenseRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ExpenseParticipantsCompanion.insert({
    @required String expenseRef,
    @required String personRef,
  })  : expenseRef = Value(expenseRef),
        personRef = Value(personRef);
  ExpenseParticipantsCompanion copyWith(
      {Value<String> expenseRef, Value<String> personRef}) {
    return ExpenseParticipantsCompanion(
      expenseRef: expenseRef ?? this.expenseRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ExpenseParticipantsTable extends ExpenseParticipants
    with TableInfo<$ExpenseParticipantsTable, ExpenseParticipant> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpenseParticipantsTable(this._db, [this._alias]);
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
  $ExpenseParticipantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expense_participants';
  @override
  final String actualTableName = 'expense_participants';
  @override
  VerificationContext validateIntegrity(ExpenseParticipantsCompanion d,
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
  ExpenseParticipant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExpenseParticipant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpenseParticipantsCompanion d) {
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
  $ExpenseParticipantsTable createAlias(String alias) {
    return $ExpenseParticipantsTable(_db, alias);
  }
}

class ExpensePayer extends DataClass implements Insertable<ExpensePayer> {
  final String expenseRef;
  final String personRef;
  ExpensePayer({@required this.expenseRef, @required this.personRef});
  factory ExpensePayer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ExpensePayer(
      expenseRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_ref']),
      personRef: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_ref']),
    );
  }
  factory ExpensePayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExpensePayer(
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
  ExpensePayersCompanion createCompanion(bool nullToAbsent) {
    return ExpensePayersCompanion(
      expenseRef: expenseRef == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseRef),
      personRef: personRef == null && nullToAbsent
          ? const Value.absent()
          : Value(personRef),
    );
  }

  ExpensePayer copyWith({String expenseRef, String personRef}) =>
      ExpensePayer(
        expenseRef: expenseRef ?? this.expenseRef,
        personRef: personRef ?? this.personRef,
      );
  @override
  String toString() {
    return (StringBuffer('ExpensePayer(')
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
          (other is ExpensePayer &&
          other.expenseRef == this.expenseRef &&
          other.personRef == this.personRef);
}

class ExpensePayersCompanion extends UpdateCompanion<ExpensePayer> {
  final Value<String> expenseRef;
  final Value<String> personRef;
  const ExpensePayersCompanion({
    this.expenseRef = const Value.absent(),
    this.personRef = const Value.absent(),
  });
  ExpensePayersCompanion.insert({
    @required String expenseRef,
    @required String personRef,
  })  : expenseRef = Value(expenseRef),
        personRef = Value(personRef);
  ExpensePayersCompanion copyWith(
      {Value<String> expenseRef, Value<String> personRef}) {
    return ExpensePayersCompanion(
      expenseRef: expenseRef ?? this.expenseRef,
      personRef: personRef ?? this.personRef,
    );
  }
}

class $ExpensePayersTable extends ExpensePayers
    with TableInfo<$ExpensePayersTable, ExpensePayer> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpensePayersTable(this._db, [this._alias]);
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
  $ExpensePayersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expense_payers';
  @override
  final String actualTableName = 'expense_payers';
  @override
  VerificationContext validateIntegrity(ExpensePayersCompanion d,
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
  ExpensePayer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExpensePayer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpensePayersCompanion d) {
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
  $ExpensePayersTable createAlias(String alias) {
    return $ExpensePayersTable(_db, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final double amount;
  final String paidFor;
  Expense(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.amount,
      @required this.paidFor});
  factory Expense.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Expense(
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
  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Expense(
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
  ExpensesCompanion createCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
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

  Expense copyWith(
          {String id,
          DateTime createdAt,
          DateTime updateAt,
          double amount,
          String paidFor}) =>
      Expense(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        amount: amount ?? this.amount,
        paidFor: paidFor ?? this.paidFor,
      );
  @override
  String toString() {
    return (StringBuffer('Expense(')
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
          (other is Expense &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.amount == this.amount &&
          other.paidFor == this.paidFor);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<double> amount;
  final Value<String> paidFor;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.amount = const Value.absent(),
    this.paidFor = const Value.absent(),
  });
  ExpensesCompanion.insert({
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
  ExpensesCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<double> amount,
      Value<String> paidFor}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      amount: amount ?? this.amount,
      paidFor: paidFor ?? this.paidFor,
    );
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExpensesTable(this._db, [this._alias]);
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
  $ExpensesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'expenses';
  @override
  final String actualTableName = 'expenses';
  @override
  VerificationContext validateIntegrity(ExpensesCompanion d,
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
  Expense map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Expense.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ExpensesCompanion d) {
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
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(_db, alias);
  }
}

class PeopleData extends DataClass implements Insertable<PeopleData> {
  final String id;
  final DateTime createdAt;
  final DateTime updateAt;
  final String name;
  PeopleData(
      {@required this.id,
      @required this.createdAt,
      @required this.updateAt,
      @required this.name});
  factory PeopleData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PeopleData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updateAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory PeopleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PeopleData(
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
  PeopleCompanion createCompanion(bool nullToAbsent) {
    return PeopleCompanion(
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

  PeopleData copyWith(
          {String id, DateTime createdAt, DateTime updateAt, String name}) =>
      PeopleData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('PeopleData(')
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
          (other is PeopleData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.name == this.name);
}

class PeopleCompanion extends UpdateCompanion<PeopleData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<String> name;
  const PeopleCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  PeopleCompanion.insert({
    @required String id,
    @required DateTime createdAt,
    @required DateTime updateAt,
    @required String name,
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt),
        name = Value(name);
  PeopleCompanion copyWith(
      {Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updateAt,
      Value<String> name}) {
    return PeopleCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      name: name ?? this.name,
    );
  }
}

class $PeopleTable extends People with TableInfo<$PeopleTable, PeopleData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PeopleTable(this._db, [this._alias]);
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
  $PeopleTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'people';
  @override
  final String actualTableName = 'people';
  @override
  VerificationContext validateIntegrity(PeopleCompanion d,
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
  PeopleData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PeopleData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PeopleCompanion d) {
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
  $PeopleTable createAlias(String alias) {
    return $PeopleTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ActivitiesTable _activities;
  $ActivitiesTable get activities => _activities ??= $ActivitiesTable(this);
  $ActivityMembersTable _activityMembers;
  $ActivityMembersTable get activityMembers =>
      _activityMembers ??= $ActivityMembersTable(this);
  $ExpenseParticipantsTable _expenseParticipants;
  $ExpenseParticipantsTable get expenseParticipants =>
      _expenseParticipants ??= $ExpenseParticipantsTable(this);
  $ExpensePayersTable _expensePayers;
  $ExpensePayersTable get expensePayers =>
      _expensePayers ??= $ExpensePayersTable(this);
  $ExpensesTable _expenses;
  $ExpensesTable get expenses => _expenses ??= $ExpensesTable(this);
  $PeopleTable _people;
  $PeopleTable get people => _people ??= $PeopleTable(this);
  ActivityLocalDataSource _activityLocalDataSource;

  ActivityLocalDataSource get activityLocalDataSource =>
      _activityLocalDataSource ??=
          ActivityLocalDataSource(this as LocalDatabase);
  PeopleLocalDataSource _peopleLocalDataSource;

  PeopleLocalDataSource get peopleLocalDataSource =>
      _peopleLocalDataSource ??= PeopleLocalDataSource(this as LocalDatabase);
  ExpenseLocalDataSource _expenseLocalDataSource;

  ExpenseLocalDataSource get expenseLocalDataSource =>
      _expenseLocalDataSource ??= ExpenseLocalDataSource(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    activities,
    activityMembers,
    expenseParticipants,
    expensePayers,
    expenses,
    people
      ];
}
