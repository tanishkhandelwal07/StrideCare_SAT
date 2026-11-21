// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_database.dart';

// ignore_for_file: type=lint
class EmergencyContacts extends Table
    with TableInfo<EmergencyContacts, EmergencyContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  EmergencyContacts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (position IN (1, 2))',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _phoneE164Meta = const VerificationMeta(
    'phoneE164',
  );
  late final GeneratedColumn<String> phoneE164 = GeneratedColumn<String>(
    'phone_e164',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(phone_e164) BETWEEN 8 AND 16 AND substr(phone_e164, 1, 1) = \'+\' AND substr(phone_e164, 2, 1) BETWEEN \'1\' AND \'9\' AND substr(phone_e164, 2) NOT GLOB \'*[^0-9]*\')',
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    position,
    name,
    phoneE164,
    relationship,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyContact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_e164')) {
      context.handle(
        _phoneE164Meta,
        phoneE164.isAcceptableOrUnknown(data['phone_e164']!, _phoneE164Meta),
      );
    } else if (isInserting) {
      context.missing(_phoneE164Meta);
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationshipMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, position};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId, phoneE164},
  ];
  @override
  EmergencyContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyContact(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phoneE164: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_e164'],
      )!,
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      )!,
    );
  }

  @override
  EmergencyContacts createAlias(String alias) {
    return EmergencyContacts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(user_id, position)',
    'UNIQUE(user_id, phone_e164)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class EmergencyContact extends DataClass
    implements Insertable<EmergencyContact> {
  final int userId;
  final int position;
  final String name;

  /// Store the canonical international number, so formatted duplicates cannot pass.
  final String phoneE164;
  final String relationship;
  const EmergencyContact({
    required this.userId,
    required this.position,
    required this.name,
    required this.phoneE164,
    required this.relationship,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    map['phone_e164'] = Variable<String>(phoneE164);
    map['relationship'] = Variable<String>(relationship);
    return map;
  }

  EmergencyContactsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyContactsCompanion(
      userId: Value(userId),
      position: Value(position),
      name: Value(name),
      phoneE164: Value(phoneE164),
      relationship: Value(relationship),
    );
  }

  factory EmergencyContact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyContact(
      userId: serializer.fromJson<int>(json['user_id']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      phoneE164: serializer.fromJson<String>(json['phone_e164']),
      relationship: serializer.fromJson<String>(json['relationship']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<int>(userId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'phone_e164': serializer.toJson<String>(phoneE164),
      'relationship': serializer.toJson<String>(relationship),
    };
  }

  EmergencyContact copyWith({
    int? userId,
    int? position,
    String? name,
    String? phoneE164,
    String? relationship,
  }) => EmergencyContact(
    userId: userId ?? this.userId,
    position: position ?? this.position,
    name: name ?? this.name,
    phoneE164: phoneE164 ?? this.phoneE164,
    relationship: relationship ?? this.relationship,
  );
  EmergencyContact copyWithCompanion(EmergencyContactsCompanion data) {
    return EmergencyContact(
      userId: data.userId.present ? data.userId.value : this.userId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      phoneE164: data.phoneE164.present ? data.phoneE164.value : this.phoneE164,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyContact(')
          ..write('userId: $userId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('phoneE164: $phoneE164, ')
          ..write('relationship: $relationship')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, position, name, phoneE164, relationship);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyContact &&
          other.userId == this.userId &&
          other.position == this.position &&
          other.name == this.name &&
          other.phoneE164 == this.phoneE164 &&
          other.relationship == this.relationship);
}

class EmergencyContactsCompanion extends UpdateCompanion<EmergencyContact> {
  final Value<int> userId;
  final Value<int> position;
  final Value<String> name;
  final Value<String> phoneE164;
  final Value<String> relationship;
  final Value<int> rowid;
  const EmergencyContactsCompanion({
    this.userId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneE164 = const Value.absent(),
    this.relationship = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmergencyContactsCompanion.insert({
    required int userId,
    required int position,
    required String name,
    required String phoneE164,
    required String relationship,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       position = Value(position),
       name = Value(name),
       phoneE164 = Value(phoneE164),
       relationship = Value(relationship);
  static Insertable<EmergencyContact> custom({
    Expression<int>? userId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? phoneE164,
    Expression<String>? relationship,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (phoneE164 != null) 'phone_e164': phoneE164,
      if (relationship != null) 'relationship': relationship,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmergencyContactsCompanion copyWith({
    Value<int>? userId,
    Value<int>? position,
    Value<String>? name,
    Value<String>? phoneE164,
    Value<String>? relationship,
    Value<int>? rowid,
  }) {
    return EmergencyContactsCompanion(
      userId: userId ?? this.userId,
      position: position ?? this.position,
      name: name ?? this.name,
      phoneE164: phoneE164 ?? this.phoneE164,
      relationship: relationship ?? this.relationship,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneE164.present) {
      map['phone_e164'] = Variable<String>(phoneE164.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyContactsCompanion(')
          ..write('userId: $userId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('phoneE164: $phoneE164, ')
          ..write('relationship: $relationship, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Users extends Table with TableInfo<Users, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Users(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (height_cm > 0)',
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (age > 0)',
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _firstSlotMeta = const VerificationMeta(
    'firstSlot',
  );
  late final GeneratedColumn<int> firstSlot = GeneratedColumn<int>(
    'first_slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (first_slot = 1)',
    defaultValue: const CustomExpression('1'),
  );
  static const VerificationMeta _secondSlotMeta = const VerificationMeta(
    'secondSlot',
  );
  late final GeneratedColumn<int> secondSlot = GeneratedColumn<int>(
    'second_slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 2 CHECK (second_slot = 2)',
    defaultValue: const CustomExpression('2'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    heightCm,
    age,
    locale,
    firstSlot,
    secondSlot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('first_slot')) {
      context.handle(
        _firstSlotMeta,
        firstSlot.isAcceptableOrUnknown(data['first_slot']!, _firstSlotMeta),
      );
    }
    if (data.containsKey('second_slot')) {
      context.handle(
        _secondSlotMeta,
        secondSlot.isAcceptableOrUnknown(data['second_slot']!, _secondSlotMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      firstSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_slot'],
      )!,
      secondSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}second_slot'],
      )!,
    );
  }

  @override
  Users createAlias(String alias) {
    return Users(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'FOREIGN KEY(id, first_slot)REFERENCES emergency_contacts(user_id, position)DEFERRABLE INITIALLY DEFERRED',
    'FOREIGN KEY(id, second_slot)REFERENCES emergency_contacts(user_id, position)DEFERRABLE INITIALLY DEFERRED',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final double heightCm;
  final int age;
  final String locale;
  final int firstSlot;
  final int secondSlot;
  const User({
    required this.id,
    required this.name,
    required this.heightCm,
    required this.age,
    required this.locale,
    required this.firstSlot,
    required this.secondSlot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['height_cm'] = Variable<double>(heightCm);
    map['age'] = Variable<int>(age);
    map['locale'] = Variable<String>(locale);
    map['first_slot'] = Variable<int>(firstSlot);
    map['second_slot'] = Variable<int>(secondSlot);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      heightCm: Value(heightCm),
      age: Value(age),
      locale: Value(locale),
      firstSlot: Value(firstSlot),
      secondSlot: Value(secondSlot),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      heightCm: serializer.fromJson<double>(json['height_cm']),
      age: serializer.fromJson<int>(json['age']),
      locale: serializer.fromJson<String>(json['locale']),
      firstSlot: serializer.fromJson<int>(json['first_slot']),
      secondSlot: serializer.fromJson<int>(json['second_slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'height_cm': serializer.toJson<double>(heightCm),
      'age': serializer.toJson<int>(age),
      'locale': serializer.toJson<String>(locale),
      'first_slot': serializer.toJson<int>(firstSlot),
      'second_slot': serializer.toJson<int>(secondSlot),
    };
  }

  User copyWith({
    int? id,
    String? name,
    double? heightCm,
    int? age,
    String? locale,
    int? firstSlot,
    int? secondSlot,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    heightCm: heightCm ?? this.heightCm,
    age: age ?? this.age,
    locale: locale ?? this.locale,
    firstSlot: firstSlot ?? this.firstSlot,
    secondSlot: secondSlot ?? this.secondSlot,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      age: data.age.present ? data.age.value : this.age,
      locale: data.locale.present ? data.locale.value : this.locale,
      firstSlot: data.firstSlot.present ? data.firstSlot.value : this.firstSlot,
      secondSlot: data.secondSlot.present
          ? data.secondSlot.value
          : this.secondSlot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('heightCm: $heightCm, ')
          ..write('age: $age, ')
          ..write('locale: $locale, ')
          ..write('firstSlot: $firstSlot, ')
          ..write('secondSlot: $secondSlot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, heightCm, age, locale, firstSlot, secondSlot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.heightCm == this.heightCm &&
          other.age == this.age &&
          other.locale == this.locale &&
          other.firstSlot == this.firstSlot &&
          other.secondSlot == this.secondSlot);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> heightCm;
  final Value<int> age;
  final Value<String> locale;
  final Value<int> firstSlot;
  final Value<int> secondSlot;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.age = const Value.absent(),
    this.locale = const Value.absent(),
    this.firstSlot = const Value.absent(),
    this.secondSlot = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double heightCm,
    required int age,
    required String locale,
    this.firstSlot = const Value.absent(),
    this.secondSlot = const Value.absent(),
  }) : name = Value(name),
       heightCm = Value(heightCm),
       age = Value(age),
       locale = Value(locale);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? heightCm,
    Expression<int>? age,
    Expression<String>? locale,
    Expression<int>? firstSlot,
    Expression<int>? secondSlot,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (heightCm != null) 'height_cm': heightCm,
      if (age != null) 'age': age,
      if (locale != null) 'locale': locale,
      if (firstSlot != null) 'first_slot': firstSlot,
      if (secondSlot != null) 'second_slot': secondSlot,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? heightCm,
    Value<int>? age,
    Value<String>? locale,
    Value<int>? firstSlot,
    Value<int>? secondSlot,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      heightCm: heightCm ?? this.heightCm,
      age: age ?? this.age,
      locale: locale ?? this.locale,
      firstSlot: firstSlot ?? this.firstSlot,
      secondSlot: secondSlot ?? this.secondSlot,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (firstSlot.present) {
      map['first_slot'] = Variable<int>(firstSlot.value);
    }
    if (secondSlot.present) {
      map['second_slot'] = Variable<int>(secondSlot.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('heightCm: $heightCm, ')
          ..write('age: $age, ')
          ..write('locale: $locale, ')
          ..write('firstSlot: $firstSlot, ')
          ..write('secondSlot: $secondSlot')
          ..write(')'))
        .toString();
  }
}

class InjuryProfiles extends Table
    with TableInfo<InjuryProfiles, InjuryProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InjuryProfiles(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL PRIMARY KEY REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _injuryTypeMeta = const VerificationMeta(
    'injuryType',
  );
  late final GeneratedColumn<String> injuryType = GeneratedColumn<String>(
    'injury_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _surgeryDateMeta = const VerificationMeta(
    'surgeryDate',
  );
  late final GeneratedColumn<String> surgeryDate = GeneratedColumn<String>(
    'surgery_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _affectedSideMeta = const VerificationMeta(
    'affectedSide',
  );
  late final GeneratedColumn<String> affectedSide = GeneratedColumn<String>(
    'affected_side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    injuryType,
    surgeryDate,
    affectedSide,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'injury_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<InjuryProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('injury_type')) {
      context.handle(
        _injuryTypeMeta,
        injuryType.isAcceptableOrUnknown(data['injury_type']!, _injuryTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_injuryTypeMeta);
    }
    if (data.containsKey('surgery_date')) {
      context.handle(
        _surgeryDateMeta,
        surgeryDate.isAcceptableOrUnknown(
          data['surgery_date']!,
          _surgeryDateMeta,
        ),
      );
    }
    if (data.containsKey('affected_side')) {
      context.handle(
        _affectedSideMeta,
        affectedSide.isAcceptableOrUnknown(
          data['affected_side']!,
          _affectedSideMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_affectedSideMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  InjuryProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InjuryProfile(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      injuryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}injury_type'],
      )!,
      surgeryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surgery_date'],
      ),
      affectedSide: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}affected_side'],
      )!,
    );
  }

  @override
  InjuryProfiles createAlias(String alias) {
    return InjuryProfiles(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class InjuryProfile extends DataClass implements Insertable<InjuryProfile> {
  final int userId;
  final String injuryType;
  final String? surgeryDate;
  final String affectedSide;
  const InjuryProfile({
    required this.userId,
    required this.injuryType,
    this.surgeryDate,
    required this.affectedSide,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['injury_type'] = Variable<String>(injuryType);
    if (!nullToAbsent || surgeryDate != null) {
      map['surgery_date'] = Variable<String>(surgeryDate);
    }
    map['affected_side'] = Variable<String>(affectedSide);
    return map;
  }

  InjuryProfilesCompanion toCompanion(bool nullToAbsent) {
    return InjuryProfilesCompanion(
      userId: Value(userId),
      injuryType: Value(injuryType),
      surgeryDate: surgeryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(surgeryDate),
      affectedSide: Value(affectedSide),
    );
  }

  factory InjuryProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InjuryProfile(
      userId: serializer.fromJson<int>(json['user_id']),
      injuryType: serializer.fromJson<String>(json['injury_type']),
      surgeryDate: serializer.fromJson<String?>(json['surgery_date']),
      affectedSide: serializer.fromJson<String>(json['affected_side']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<int>(userId),
      'injury_type': serializer.toJson<String>(injuryType),
      'surgery_date': serializer.toJson<String?>(surgeryDate),
      'affected_side': serializer.toJson<String>(affectedSide),
    };
  }

  InjuryProfile copyWith({
    int? userId,
    String? injuryType,
    Value<String?> surgeryDate = const Value.absent(),
    String? affectedSide,
  }) => InjuryProfile(
    userId: userId ?? this.userId,
    injuryType: injuryType ?? this.injuryType,
    surgeryDate: surgeryDate.present ? surgeryDate.value : this.surgeryDate,
    affectedSide: affectedSide ?? this.affectedSide,
  );
  InjuryProfile copyWithCompanion(InjuryProfilesCompanion data) {
    return InjuryProfile(
      userId: data.userId.present ? data.userId.value : this.userId,
      injuryType: data.injuryType.present
          ? data.injuryType.value
          : this.injuryType,
      surgeryDate: data.surgeryDate.present
          ? data.surgeryDate.value
          : this.surgeryDate,
      affectedSide: data.affectedSide.present
          ? data.affectedSide.value
          : this.affectedSide,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InjuryProfile(')
          ..write('userId: $userId, ')
          ..write('injuryType: $injuryType, ')
          ..write('surgeryDate: $surgeryDate, ')
          ..write('affectedSide: $affectedSide')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, injuryType, surgeryDate, affectedSide);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InjuryProfile &&
          other.userId == this.userId &&
          other.injuryType == this.injuryType &&
          other.surgeryDate == this.surgeryDate &&
          other.affectedSide == this.affectedSide);
}

class InjuryProfilesCompanion extends UpdateCompanion<InjuryProfile> {
  final Value<int> userId;
  final Value<String> injuryType;
  final Value<String?> surgeryDate;
  final Value<String> affectedSide;
  const InjuryProfilesCompanion({
    this.userId = const Value.absent(),
    this.injuryType = const Value.absent(),
    this.surgeryDate = const Value.absent(),
    this.affectedSide = const Value.absent(),
  });
  InjuryProfilesCompanion.insert({
    this.userId = const Value.absent(),
    required String injuryType,
    this.surgeryDate = const Value.absent(),
    required String affectedSide,
  }) : injuryType = Value(injuryType),
       affectedSide = Value(affectedSide);
  static Insertable<InjuryProfile> custom({
    Expression<int>? userId,
    Expression<String>? injuryType,
    Expression<String>? surgeryDate,
    Expression<String>? affectedSide,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (injuryType != null) 'injury_type': injuryType,
      if (surgeryDate != null) 'surgery_date': surgeryDate,
      if (affectedSide != null) 'affected_side': affectedSide,
    });
  }

  InjuryProfilesCompanion copyWith({
    Value<int>? userId,
    Value<String>? injuryType,
    Value<String?>? surgeryDate,
    Value<String>? affectedSide,
  }) {
    return InjuryProfilesCompanion(
      userId: userId ?? this.userId,
      injuryType: injuryType ?? this.injuryType,
      surgeryDate: surgeryDate ?? this.surgeryDate,
      affectedSide: affectedSide ?? this.affectedSide,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (injuryType.present) {
      map['injury_type'] = Variable<String>(injuryType.value);
    }
    if (surgeryDate.present) {
      map['surgery_date'] = Variable<String>(surgeryDate.value);
    }
    if (affectedSide.present) {
      map['affected_side'] = Variable<String>(affectedSide.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InjuryProfilesCompanion(')
          ..write('userId: $userId, ')
          ..write('injuryType: $injuryType, ')
          ..write('surgeryDate: $surgeryDate, ')
          ..write('affectedSide: $affectedSide')
          ..write(')'))
        .toString();
  }
}

class WalkSessions extends Table with TableInfo<WalkSessions, WalkSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WalkSessions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (ended_at >= started_at)',
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (steps >= 0)',
  );
  static const VerificationMeta _avgLoadMeta = const VerificationMeta(
    'avgLoad',
  );
  late final GeneratedColumn<double> avgLoad = GeneratedColumn<double>(
    'avg_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _peakLoadMeta = const VerificationMeta(
    'peakLoad',
  );
  late final GeneratedColumn<double> peakLoad = GeneratedColumn<double>(
    'peak_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _avgSpeedMeta = const VerificationMeta(
    'avgSpeed',
  );
  late final GeneratedColumn<double> avgSpeed = GeneratedColumn<double>(
    'avg_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _peakSpeedMeta = const VerificationMeta(
    'peakSpeed',
  );
  late final GeneratedColumn<double> peakSpeed = GeneratedColumn<double>(
    'peak_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _cadenceMeta = const VerificationMeta(
    'cadence',
  );
  late final GeneratedColumn<double> cadence = GeneratedColumn<double>(
    'cadence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _strideLengthMMeta = const VerificationMeta(
    'strideLengthM',
  );
  late final GeneratedColumn<double> strideLengthM = GeneratedColumn<double>(
    'stride_length_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _gaitRegularityMeta = const VerificationMeta(
    'gaitRegularity',
  );
  late final GeneratedColumn<double> gaitRegularity = GeneratedColumn<double>(
    'gait_regularity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    startedAt,
    endedAt,
    steps,
    avgLoad,
    peakLoad,
    avgSpeed,
    peakSpeed,
    cadence,
    strideLengthM,
    distanceM,
    gaitRegularity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walk_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('avg_load')) {
      context.handle(
        _avgLoadMeta,
        avgLoad.isAcceptableOrUnknown(data['avg_load']!, _avgLoadMeta),
      );
    } else if (isInserting) {
      context.missing(_avgLoadMeta);
    }
    if (data.containsKey('peak_load')) {
      context.handle(
        _peakLoadMeta,
        peakLoad.isAcceptableOrUnknown(data['peak_load']!, _peakLoadMeta),
      );
    } else if (isInserting) {
      context.missing(_peakLoadMeta);
    }
    if (data.containsKey('avg_speed')) {
      context.handle(
        _avgSpeedMeta,
        avgSpeed.isAcceptableOrUnknown(data['avg_speed']!, _avgSpeedMeta),
      );
    } else if (isInserting) {
      context.missing(_avgSpeedMeta);
    }
    if (data.containsKey('peak_speed')) {
      context.handle(
        _peakSpeedMeta,
        peakSpeed.isAcceptableOrUnknown(data['peak_speed']!, _peakSpeedMeta),
      );
    } else if (isInserting) {
      context.missing(_peakSpeedMeta);
    }
    if (data.containsKey('cadence')) {
      context.handle(
        _cadenceMeta,
        cadence.isAcceptableOrUnknown(data['cadence']!, _cadenceMeta),
      );
    } else if (isInserting) {
      context.missing(_cadenceMeta);
    }
    if (data.containsKey('stride_length_m')) {
      context.handle(
        _strideLengthMMeta,
        strideLengthM.isAcceptableOrUnknown(
          data['stride_length_m']!,
          _strideLengthMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strideLengthMMeta);
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMMeta);
    }
    if (data.containsKey('gait_regularity')) {
      context.handle(
        _gaitRegularityMeta,
        gaitRegularity.isAcceptableOrUnknown(
          data['gait_regularity']!,
          _gaitRegularityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gaitRegularityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      avgLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_load'],
      )!,
      peakLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peak_load'],
      )!,
      avgSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed'],
      )!,
      peakSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peak_speed'],
      )!,
      cadence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cadence'],
      )!,
      strideLengthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stride_length_m'],
      )!,
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      )!,
      gaitRegularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gait_regularity'],
      )!,
    );
  }

  @override
  WalkSessions createAlias(String alias) {
    return WalkSessions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class WalkSession extends DataClass implements Insertable<WalkSession> {
  final String id;
  final int userId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int steps;
  final double avgLoad;
  final double peakLoad;
  final double avgSpeed;
  final double peakSpeed;
  final double cadence;
  final double strideLengthM;
  final double distanceM;
  final double gaitRegularity;
  const WalkSession({
    required this.id,
    required this.userId,
    required this.startedAt,
    required this.endedAt,
    required this.steps,
    required this.avgLoad,
    required this.peakLoad,
    required this.avgSpeed,
    required this.peakSpeed,
    required this.cadence,
    required this.strideLengthM,
    required this.distanceM,
    required this.gaitRegularity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['steps'] = Variable<int>(steps);
    map['avg_load'] = Variable<double>(avgLoad);
    map['peak_load'] = Variable<double>(peakLoad);
    map['avg_speed'] = Variable<double>(avgSpeed);
    map['peak_speed'] = Variable<double>(peakSpeed);
    map['cadence'] = Variable<double>(cadence);
    map['stride_length_m'] = Variable<double>(strideLengthM);
    map['distance_m'] = Variable<double>(distanceM);
    map['gait_regularity'] = Variable<double>(gaitRegularity);
    return map;
  }

  WalkSessionsCompanion toCompanion(bool nullToAbsent) {
    return WalkSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      steps: Value(steps),
      avgLoad: Value(avgLoad),
      peakLoad: Value(peakLoad),
      avgSpeed: Value(avgSpeed),
      peakSpeed: Value(peakSpeed),
      cadence: Value(cadence),
      strideLengthM: Value(strideLengthM),
      distanceM: Value(distanceM),
      gaitRegularity: Value(gaitRegularity),
    );
  }

  factory WalkSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkSession(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['user_id']),
      startedAt: serializer.fromJson<DateTime>(json['started_at']),
      endedAt: serializer.fromJson<DateTime>(json['ended_at']),
      steps: serializer.fromJson<int>(json['steps']),
      avgLoad: serializer.fromJson<double>(json['avg_load']),
      peakLoad: serializer.fromJson<double>(json['peak_load']),
      avgSpeed: serializer.fromJson<double>(json['avg_speed']),
      peakSpeed: serializer.fromJson<double>(json['peak_speed']),
      cadence: serializer.fromJson<double>(json['cadence']),
      strideLengthM: serializer.fromJson<double>(json['stride_length_m']),
      distanceM: serializer.fromJson<double>(json['distance_m']),
      gaitRegularity: serializer.fromJson<double>(json['gait_regularity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<int>(userId),
      'started_at': serializer.toJson<DateTime>(startedAt),
      'ended_at': serializer.toJson<DateTime>(endedAt),
      'steps': serializer.toJson<int>(steps),
      'avg_load': serializer.toJson<double>(avgLoad),
      'peak_load': serializer.toJson<double>(peakLoad),
      'avg_speed': serializer.toJson<double>(avgSpeed),
      'peak_speed': serializer.toJson<double>(peakSpeed),
      'cadence': serializer.toJson<double>(cadence),
      'stride_length_m': serializer.toJson<double>(strideLengthM),
      'distance_m': serializer.toJson<double>(distanceM),
      'gait_regularity': serializer.toJson<double>(gaitRegularity),
    };
  }

  WalkSession copyWith({
    String? id,
    int? userId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? steps,
    double? avgLoad,
    double? peakLoad,
    double? avgSpeed,
    double? peakSpeed,
    double? cadence,
    double? strideLengthM,
    double? distanceM,
    double? gaitRegularity,
  }) => WalkSession(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    steps: steps ?? this.steps,
    avgLoad: avgLoad ?? this.avgLoad,
    peakLoad: peakLoad ?? this.peakLoad,
    avgSpeed: avgSpeed ?? this.avgSpeed,
    peakSpeed: peakSpeed ?? this.peakSpeed,
    cadence: cadence ?? this.cadence,
    strideLengthM: strideLengthM ?? this.strideLengthM,
    distanceM: distanceM ?? this.distanceM,
    gaitRegularity: gaitRegularity ?? this.gaitRegularity,
  );
  WalkSession copyWithCompanion(WalkSessionsCompanion data) {
    return WalkSession(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      steps: data.steps.present ? data.steps.value : this.steps,
      avgLoad: data.avgLoad.present ? data.avgLoad.value : this.avgLoad,
      peakLoad: data.peakLoad.present ? data.peakLoad.value : this.peakLoad,
      avgSpeed: data.avgSpeed.present ? data.avgSpeed.value : this.avgSpeed,
      peakSpeed: data.peakSpeed.present ? data.peakSpeed.value : this.peakSpeed,
      cadence: data.cadence.present ? data.cadence.value : this.cadence,
      strideLengthM: data.strideLengthM.present
          ? data.strideLengthM.value
          : this.strideLengthM,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      gaitRegularity: data.gaitRegularity.present
          ? data.gaitRegularity.value
          : this.gaitRegularity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkSession(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('steps: $steps, ')
          ..write('avgLoad: $avgLoad, ')
          ..write('peakLoad: $peakLoad, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('peakSpeed: $peakSpeed, ')
          ..write('cadence: $cadence, ')
          ..write('strideLengthM: $strideLengthM, ')
          ..write('distanceM: $distanceM, ')
          ..write('gaitRegularity: $gaitRegularity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    startedAt,
    endedAt,
    steps,
    avgLoad,
    peakLoad,
    avgSpeed,
    peakSpeed,
    cadence,
    strideLengthM,
    distanceM,
    gaitRegularity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkSession &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.steps == this.steps &&
          other.avgLoad == this.avgLoad &&
          other.peakLoad == this.peakLoad &&
          other.avgSpeed == this.avgSpeed &&
          other.peakSpeed == this.peakSpeed &&
          other.cadence == this.cadence &&
          other.strideLengthM == this.strideLengthM &&
          other.distanceM == this.distanceM &&
          other.gaitRegularity == this.gaitRegularity);
}

class WalkSessionsCompanion extends UpdateCompanion<WalkSession> {
  final Value<String> id;
  final Value<int> userId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> steps;
  final Value<double> avgLoad;
  final Value<double> peakLoad;
  final Value<double> avgSpeed;
  final Value<double> peakSpeed;
  final Value<double> cadence;
  final Value<double> strideLengthM;
  final Value<double> distanceM;
  final Value<double> gaitRegularity;
  final Value<int> rowid;
  const WalkSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.steps = const Value.absent(),
    this.avgLoad = const Value.absent(),
    this.peakLoad = const Value.absent(),
    this.avgSpeed = const Value.absent(),
    this.peakSpeed = const Value.absent(),
    this.cadence = const Value.absent(),
    this.strideLengthM = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.gaitRegularity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalkSessionsCompanion.insert({
    required String id,
    required int userId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int steps,
    required double avgLoad,
    required double peakLoad,
    required double avgSpeed,
    required double peakSpeed,
    required double cadence,
    required double strideLengthM,
    required double distanceM,
    required double gaitRegularity,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       steps = Value(steps),
       avgLoad = Value(avgLoad),
       peakLoad = Value(peakLoad),
       avgSpeed = Value(avgSpeed),
       peakSpeed = Value(peakSpeed),
       cadence = Value(cadence),
       strideLengthM = Value(strideLengthM),
       distanceM = Value(distanceM),
       gaitRegularity = Value(gaitRegularity);
  static Insertable<WalkSession> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? steps,
    Expression<double>? avgLoad,
    Expression<double>? peakLoad,
    Expression<double>? avgSpeed,
    Expression<double>? peakSpeed,
    Expression<double>? cadence,
    Expression<double>? strideLengthM,
    Expression<double>? distanceM,
    Expression<double>? gaitRegularity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (steps != null) 'steps': steps,
      if (avgLoad != null) 'avg_load': avgLoad,
      if (peakLoad != null) 'peak_load': peakLoad,
      if (avgSpeed != null) 'avg_speed': avgSpeed,
      if (peakSpeed != null) 'peak_speed': peakSpeed,
      if (cadence != null) 'cadence': cadence,
      if (strideLengthM != null) 'stride_length_m': strideLengthM,
      if (distanceM != null) 'distance_m': distanceM,
      if (gaitRegularity != null) 'gait_regularity': gaitRegularity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalkSessionsCompanion copyWith({
    Value<String>? id,
    Value<int>? userId,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? steps,
    Value<double>? avgLoad,
    Value<double>? peakLoad,
    Value<double>? avgSpeed,
    Value<double>? peakSpeed,
    Value<double>? cadence,
    Value<double>? strideLengthM,
    Value<double>? distanceM,
    Value<double>? gaitRegularity,
    Value<int>? rowid,
  }) {
    return WalkSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      steps: steps ?? this.steps,
      avgLoad: avgLoad ?? this.avgLoad,
      peakLoad: peakLoad ?? this.peakLoad,
      avgSpeed: avgSpeed ?? this.avgSpeed,
      peakSpeed: peakSpeed ?? this.peakSpeed,
      cadence: cadence ?? this.cadence,
      strideLengthM: strideLengthM ?? this.strideLengthM,
      distanceM: distanceM ?? this.distanceM,
      gaitRegularity: gaitRegularity ?? this.gaitRegularity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (avgLoad.present) {
      map['avg_load'] = Variable<double>(avgLoad.value);
    }
    if (peakLoad.present) {
      map['peak_load'] = Variable<double>(peakLoad.value);
    }
    if (avgSpeed.present) {
      map['avg_speed'] = Variable<double>(avgSpeed.value);
    }
    if (peakSpeed.present) {
      map['peak_speed'] = Variable<double>(peakSpeed.value);
    }
    if (cadence.present) {
      map['cadence'] = Variable<double>(cadence.value);
    }
    if (strideLengthM.present) {
      map['stride_length_m'] = Variable<double>(strideLengthM.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (gaitRegularity.present) {
      map['gait_regularity'] = Variable<double>(gaitRegularity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('steps: $steps, ')
          ..write('avgLoad: $avgLoad, ')
          ..write('peakLoad: $peakLoad, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('peakSpeed: $peakSpeed, ')
          ..write('cadence: $cadence, ')
          ..write('strideLengthM: $strideLengthM, ')
          ..write('distanceM: $distanceM, ')
          ..write('gaitRegularity: $gaitRegularity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DailyMetrics extends Table with TableInfo<DailyMetrics, DailyMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DailyMetrics(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _walkMinutesMeta = const VerificationMeta(
    'walkMinutes',
  );
  late final GeneratedColumn<double> walkMinutes = GeneratedColumn<double>(
    'walk_minutes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _avgLoadMeta = const VerificationMeta(
    'avgLoad',
  );
  late final GeneratedColumn<double> avgLoad = GeneratedColumn<double>(
    'avg_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _peakLoadMeta = const VerificationMeta(
    'peakLoad',
  );
  late final GeneratedColumn<double> peakLoad = GeneratedColumn<double>(
    'peak_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _avgSpeedMeta = const VerificationMeta(
    'avgSpeed',
  );
  late final GeneratedColumn<double> avgSpeed = GeneratedColumn<double>(
    'avg_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _peakSpeedMeta = const VerificationMeta(
    'peakSpeed',
  );
  late final GeneratedColumn<double> peakSpeed = GeneratedColumn<double>(
    'peak_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _cadenceMeta = const VerificationMeta(
    'cadence',
  );
  late final GeneratedColumn<double> cadence = GeneratedColumn<double>(
    'cadence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _strideLengthMMeta = const VerificationMeta(
    'strideLengthM',
  );
  late final GeneratedColumn<double> strideLengthM = GeneratedColumn<double>(
    'stride_length_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _gaitRegularityMeta = const VerificationMeta(
    'gaitRegularity',
  );
  late final GeneratedColumn<double> gaitRegularity = GeneratedColumn<double>(
    'gait_regularity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    day,
    steps,
    walkMinutes,
    avgLoad,
    peakLoad,
    avgSpeed,
    peakSpeed,
    cadence,
    strideLengthM,
    distanceM,
    gaitRegularity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('walk_minutes')) {
      context.handle(
        _walkMinutesMeta,
        walkMinutes.isAcceptableOrUnknown(
          data['walk_minutes']!,
          _walkMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_walkMinutesMeta);
    }
    if (data.containsKey('avg_load')) {
      context.handle(
        _avgLoadMeta,
        avgLoad.isAcceptableOrUnknown(data['avg_load']!, _avgLoadMeta),
      );
    } else if (isInserting) {
      context.missing(_avgLoadMeta);
    }
    if (data.containsKey('peak_load')) {
      context.handle(
        _peakLoadMeta,
        peakLoad.isAcceptableOrUnknown(data['peak_load']!, _peakLoadMeta),
      );
    } else if (isInserting) {
      context.missing(_peakLoadMeta);
    }
    if (data.containsKey('avg_speed')) {
      context.handle(
        _avgSpeedMeta,
        avgSpeed.isAcceptableOrUnknown(data['avg_speed']!, _avgSpeedMeta),
      );
    } else if (isInserting) {
      context.missing(_avgSpeedMeta);
    }
    if (data.containsKey('peak_speed')) {
      context.handle(
        _peakSpeedMeta,
        peakSpeed.isAcceptableOrUnknown(data['peak_speed']!, _peakSpeedMeta),
      );
    } else if (isInserting) {
      context.missing(_peakSpeedMeta);
    }
    if (data.containsKey('cadence')) {
      context.handle(
        _cadenceMeta,
        cadence.isAcceptableOrUnknown(data['cadence']!, _cadenceMeta),
      );
    } else if (isInserting) {
      context.missing(_cadenceMeta);
    }
    if (data.containsKey('stride_length_m')) {
      context.handle(
        _strideLengthMMeta,
        strideLengthM.isAcceptableOrUnknown(
          data['stride_length_m']!,
          _strideLengthMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strideLengthMMeta);
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMMeta);
    }
    if (data.containsKey('gait_regularity')) {
      context.handle(
        _gaitRegularityMeta,
        gaitRegularity.isAcceptableOrUnknown(
          data['gait_regularity']!,
          _gaitRegularityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gaitRegularityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, day};
  @override
  DailyMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyMetric(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      walkMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}walk_minutes'],
      )!,
      avgLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_load'],
      )!,
      peakLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peak_load'],
      )!,
      avgSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed'],
      )!,
      peakSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peak_speed'],
      )!,
      cadence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cadence'],
      )!,
      strideLengthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stride_length_m'],
      )!,
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      )!,
      gaitRegularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gait_regularity'],
      )!,
    );
  }

  @override
  DailyMetrics createAlias(String alias) {
    return DailyMetrics(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(user_id, day)'];
  @override
  bool get dontWriteConstraints => true;
}

class DailyMetric extends DataClass implements Insertable<DailyMetric> {
  final int userId;
  final String day;
  final int steps;
  final double walkMinutes;
  final double avgLoad;
  final double peakLoad;
  final double avgSpeed;
  final double peakSpeed;
  final double cadence;
  final double strideLengthM;
  final double distanceM;
  final double gaitRegularity;
  const DailyMetric({
    required this.userId,
    required this.day,
    required this.steps,
    required this.walkMinutes,
    required this.avgLoad,
    required this.peakLoad,
    required this.avgSpeed,
    required this.peakSpeed,
    required this.cadence,
    required this.strideLengthM,
    required this.distanceM,
    required this.gaitRegularity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['day'] = Variable<String>(day);
    map['steps'] = Variable<int>(steps);
    map['walk_minutes'] = Variable<double>(walkMinutes);
    map['avg_load'] = Variable<double>(avgLoad);
    map['peak_load'] = Variable<double>(peakLoad);
    map['avg_speed'] = Variable<double>(avgSpeed);
    map['peak_speed'] = Variable<double>(peakSpeed);
    map['cadence'] = Variable<double>(cadence);
    map['stride_length_m'] = Variable<double>(strideLengthM);
    map['distance_m'] = Variable<double>(distanceM);
    map['gait_regularity'] = Variable<double>(gaitRegularity);
    return map;
  }

  DailyMetricsCompanion toCompanion(bool nullToAbsent) {
    return DailyMetricsCompanion(
      userId: Value(userId),
      day: Value(day),
      steps: Value(steps),
      walkMinutes: Value(walkMinutes),
      avgLoad: Value(avgLoad),
      peakLoad: Value(peakLoad),
      avgSpeed: Value(avgSpeed),
      peakSpeed: Value(peakSpeed),
      cadence: Value(cadence),
      strideLengthM: Value(strideLengthM),
      distanceM: Value(distanceM),
      gaitRegularity: Value(gaitRegularity),
    );
  }

  factory DailyMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyMetric(
      userId: serializer.fromJson<int>(json['user_id']),
      day: serializer.fromJson<String>(json['day']),
      steps: serializer.fromJson<int>(json['steps']),
      walkMinutes: serializer.fromJson<double>(json['walk_minutes']),
      avgLoad: serializer.fromJson<double>(json['avg_load']),
      peakLoad: serializer.fromJson<double>(json['peak_load']),
      avgSpeed: serializer.fromJson<double>(json['avg_speed']),
      peakSpeed: serializer.fromJson<double>(json['peak_speed']),
      cadence: serializer.fromJson<double>(json['cadence']),
      strideLengthM: serializer.fromJson<double>(json['stride_length_m']),
      distanceM: serializer.fromJson<double>(json['distance_m']),
      gaitRegularity: serializer.fromJson<double>(json['gait_regularity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<int>(userId),
      'day': serializer.toJson<String>(day),
      'steps': serializer.toJson<int>(steps),
      'walk_minutes': serializer.toJson<double>(walkMinutes),
      'avg_load': serializer.toJson<double>(avgLoad),
      'peak_load': serializer.toJson<double>(peakLoad),
      'avg_speed': serializer.toJson<double>(avgSpeed),
      'peak_speed': serializer.toJson<double>(peakSpeed),
      'cadence': serializer.toJson<double>(cadence),
      'stride_length_m': serializer.toJson<double>(strideLengthM),
      'distance_m': serializer.toJson<double>(distanceM),
      'gait_regularity': serializer.toJson<double>(gaitRegularity),
    };
  }

  DailyMetric copyWith({
    int? userId,
    String? day,
    int? steps,
    double? walkMinutes,
    double? avgLoad,
    double? peakLoad,
    double? avgSpeed,
    double? peakSpeed,
    double? cadence,
    double? strideLengthM,
    double? distanceM,
    double? gaitRegularity,
  }) => DailyMetric(
    userId: userId ?? this.userId,
    day: day ?? this.day,
    steps: steps ?? this.steps,
    walkMinutes: walkMinutes ?? this.walkMinutes,
    avgLoad: avgLoad ?? this.avgLoad,
    peakLoad: peakLoad ?? this.peakLoad,
    avgSpeed: avgSpeed ?? this.avgSpeed,
    peakSpeed: peakSpeed ?? this.peakSpeed,
    cadence: cadence ?? this.cadence,
    strideLengthM: strideLengthM ?? this.strideLengthM,
    distanceM: distanceM ?? this.distanceM,
    gaitRegularity: gaitRegularity ?? this.gaitRegularity,
  );
  DailyMetric copyWithCompanion(DailyMetricsCompanion data) {
    return DailyMetric(
      userId: data.userId.present ? data.userId.value : this.userId,
      day: data.day.present ? data.day.value : this.day,
      steps: data.steps.present ? data.steps.value : this.steps,
      walkMinutes: data.walkMinutes.present
          ? data.walkMinutes.value
          : this.walkMinutes,
      avgLoad: data.avgLoad.present ? data.avgLoad.value : this.avgLoad,
      peakLoad: data.peakLoad.present ? data.peakLoad.value : this.peakLoad,
      avgSpeed: data.avgSpeed.present ? data.avgSpeed.value : this.avgSpeed,
      peakSpeed: data.peakSpeed.present ? data.peakSpeed.value : this.peakSpeed,
      cadence: data.cadence.present ? data.cadence.value : this.cadence,
      strideLengthM: data.strideLengthM.present
          ? data.strideLengthM.value
          : this.strideLengthM,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      gaitRegularity: data.gaitRegularity.present
          ? data.gaitRegularity.value
          : this.gaitRegularity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyMetric(')
          ..write('userId: $userId, ')
          ..write('day: $day, ')
          ..write('steps: $steps, ')
          ..write('walkMinutes: $walkMinutes, ')
          ..write('avgLoad: $avgLoad, ')
          ..write('peakLoad: $peakLoad, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('peakSpeed: $peakSpeed, ')
          ..write('cadence: $cadence, ')
          ..write('strideLengthM: $strideLengthM, ')
          ..write('distanceM: $distanceM, ')
          ..write('gaitRegularity: $gaitRegularity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    day,
    steps,
    walkMinutes,
    avgLoad,
    peakLoad,
    avgSpeed,
    peakSpeed,
    cadence,
    strideLengthM,
    distanceM,
    gaitRegularity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyMetric &&
          other.userId == this.userId &&
          other.day == this.day &&
          other.steps == this.steps &&
          other.walkMinutes == this.walkMinutes &&
          other.avgLoad == this.avgLoad &&
          other.peakLoad == this.peakLoad &&
          other.avgSpeed == this.avgSpeed &&
          other.peakSpeed == this.peakSpeed &&
          other.cadence == this.cadence &&
          other.strideLengthM == this.strideLengthM &&
          other.distanceM == this.distanceM &&
          other.gaitRegularity == this.gaitRegularity);
}

class DailyMetricsCompanion extends UpdateCompanion<DailyMetric> {
  final Value<int> userId;
  final Value<String> day;
  final Value<int> steps;
  final Value<double> walkMinutes;
  final Value<double> avgLoad;
  final Value<double> peakLoad;
  final Value<double> avgSpeed;
  final Value<double> peakSpeed;
  final Value<double> cadence;
  final Value<double> strideLengthM;
  final Value<double> distanceM;
  final Value<double> gaitRegularity;
  final Value<int> rowid;
  const DailyMetricsCompanion({
    this.userId = const Value.absent(),
    this.day = const Value.absent(),
    this.steps = const Value.absent(),
    this.walkMinutes = const Value.absent(),
    this.avgLoad = const Value.absent(),
    this.peakLoad = const Value.absent(),
    this.avgSpeed = const Value.absent(),
    this.peakSpeed = const Value.absent(),
    this.cadence = const Value.absent(),
    this.strideLengthM = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.gaitRegularity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyMetricsCompanion.insert({
    required int userId,
    required String day,
    required int steps,
    required double walkMinutes,
    required double avgLoad,
    required double peakLoad,
    required double avgSpeed,
    required double peakSpeed,
    required double cadence,
    required double strideLengthM,
    required double distanceM,
    required double gaitRegularity,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       day = Value(day),
       steps = Value(steps),
       walkMinutes = Value(walkMinutes),
       avgLoad = Value(avgLoad),
       peakLoad = Value(peakLoad),
       avgSpeed = Value(avgSpeed),
       peakSpeed = Value(peakSpeed),
       cadence = Value(cadence),
       strideLengthM = Value(strideLengthM),
       distanceM = Value(distanceM),
       gaitRegularity = Value(gaitRegularity);
  static Insertable<DailyMetric> custom({
    Expression<int>? userId,
    Expression<String>? day,
    Expression<int>? steps,
    Expression<double>? walkMinutes,
    Expression<double>? avgLoad,
    Expression<double>? peakLoad,
    Expression<double>? avgSpeed,
    Expression<double>? peakSpeed,
    Expression<double>? cadence,
    Expression<double>? strideLengthM,
    Expression<double>? distanceM,
    Expression<double>? gaitRegularity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (day != null) 'day': day,
      if (steps != null) 'steps': steps,
      if (walkMinutes != null) 'walk_minutes': walkMinutes,
      if (avgLoad != null) 'avg_load': avgLoad,
      if (peakLoad != null) 'peak_load': peakLoad,
      if (avgSpeed != null) 'avg_speed': avgSpeed,
      if (peakSpeed != null) 'peak_speed': peakSpeed,
      if (cadence != null) 'cadence': cadence,
      if (strideLengthM != null) 'stride_length_m': strideLengthM,
      if (distanceM != null) 'distance_m': distanceM,
      if (gaitRegularity != null) 'gait_regularity': gaitRegularity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyMetricsCompanion copyWith({
    Value<int>? userId,
    Value<String>? day,
    Value<int>? steps,
    Value<double>? walkMinutes,
    Value<double>? avgLoad,
    Value<double>? peakLoad,
    Value<double>? avgSpeed,
    Value<double>? peakSpeed,
    Value<double>? cadence,
    Value<double>? strideLengthM,
    Value<double>? distanceM,
    Value<double>? gaitRegularity,
    Value<int>? rowid,
  }) {
    return DailyMetricsCompanion(
      userId: userId ?? this.userId,
      day: day ?? this.day,
      steps: steps ?? this.steps,
      walkMinutes: walkMinutes ?? this.walkMinutes,
      avgLoad: avgLoad ?? this.avgLoad,
      peakLoad: peakLoad ?? this.peakLoad,
      avgSpeed: avgSpeed ?? this.avgSpeed,
      peakSpeed: peakSpeed ?? this.peakSpeed,
      cadence: cadence ?? this.cadence,
      strideLengthM: strideLengthM ?? this.strideLengthM,
      distanceM: distanceM ?? this.distanceM,
      gaitRegularity: gaitRegularity ?? this.gaitRegularity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (walkMinutes.present) {
      map['walk_minutes'] = Variable<double>(walkMinutes.value);
    }
    if (avgLoad.present) {
      map['avg_load'] = Variable<double>(avgLoad.value);
    }
    if (peakLoad.present) {
      map['peak_load'] = Variable<double>(peakLoad.value);
    }
    if (avgSpeed.present) {
      map['avg_speed'] = Variable<double>(avgSpeed.value);
    }
    if (peakSpeed.present) {
      map['peak_speed'] = Variable<double>(peakSpeed.value);
    }
    if (cadence.present) {
      map['cadence'] = Variable<double>(cadence.value);
    }
    if (strideLengthM.present) {
      map['stride_length_m'] = Variable<double>(strideLengthM.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (gaitRegularity.present) {
      map['gait_regularity'] = Variable<double>(gaitRegularity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyMetricsCompanion(')
          ..write('userId: $userId, ')
          ..write('day: $day, ')
          ..write('steps: $steps, ')
          ..write('walkMinutes: $walkMinutes, ')
          ..write('avgLoad: $avgLoad, ')
          ..write('peakLoad: $peakLoad, ')
          ..write('avgSpeed: $avgSpeed, ')
          ..write('peakSpeed: $peakSpeed, ')
          ..write('cadence: $cadence, ')
          ..write('strideLengthM: $strideLengthM, ')
          ..write('distanceM: $distanceM, ')
          ..write('gaitRegularity: $gaitRegularity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class RecoveryScores extends Table
    with TableInfo<RecoveryScores, RecoveryScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RecoveryScores(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (score BETWEEN 0 AND 100)',
  );
  @override
  List<GeneratedColumn> get $columns => [userId, day, score];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, day};
  @override
  RecoveryScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryScore(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
    );
  }

  @override
  RecoveryScores createAlias(String alias) {
    return RecoveryScores(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(user_id, day)'];
  @override
  bool get dontWriteConstraints => true;
}

class RecoveryScore extends DataClass implements Insertable<RecoveryScore> {
  final int userId;
  final String day;
  final int score;
  const RecoveryScore({
    required this.userId,
    required this.day,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['day'] = Variable<String>(day);
    map['score'] = Variable<int>(score);
    return map;
  }

  RecoveryScoresCompanion toCompanion(bool nullToAbsent) {
    return RecoveryScoresCompanion(
      userId: Value(userId),
      day: Value(day),
      score: Value(score),
    );
  }

  factory RecoveryScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryScore(
      userId: serializer.fromJson<int>(json['user_id']),
      day: serializer.fromJson<String>(json['day']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<int>(userId),
      'day': serializer.toJson<String>(day),
      'score': serializer.toJson<int>(score),
    };
  }

  RecoveryScore copyWith({int? userId, String? day, int? score}) =>
      RecoveryScore(
        userId: userId ?? this.userId,
        day: day ?? this.day,
        score: score ?? this.score,
      );
  RecoveryScore copyWithCompanion(RecoveryScoresCompanion data) {
    return RecoveryScore(
      userId: data.userId.present ? data.userId.value : this.userId,
      day: data.day.present ? data.day.value : this.day,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryScore(')
          ..write('userId: $userId, ')
          ..write('day: $day, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, day, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryScore &&
          other.userId == this.userId &&
          other.day == this.day &&
          other.score == this.score);
}

class RecoveryScoresCompanion extends UpdateCompanion<RecoveryScore> {
  final Value<int> userId;
  final Value<String> day;
  final Value<int> score;
  final Value<int> rowid;
  const RecoveryScoresCompanion({
    this.userId = const Value.absent(),
    this.day = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryScoresCompanion.insert({
    required int userId,
    required String day,
    required int score,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       day = Value(day),
       score = Value(score);
  static Insertable<RecoveryScore> custom({
    Expression<int>? userId,
    Expression<String>? day,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (day != null) 'day': day,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryScoresCompanion copyWith({
    Value<int>? userId,
    Value<String>? day,
    Value<int>? score,
    Value<int>? rowid,
  }) {
    return RecoveryScoresCompanion(
      userId: userId ?? this.userId,
      day: day ?? this.day,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryScoresCompanion(')
          ..write('userId: $userId, ')
          ..write('day: $day, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Milestones extends Table with TableInfo<Milestones, Milestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Milestones(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _milestoneKeyMeta = const VerificationMeta(
    'milestoneKey',
  );
  late final GeneratedColumn<String> milestoneKey = GeneratedColumn<String>(
    'milestone_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [userId, milestoneKey, achievedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'milestones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Milestone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('milestone_key')) {
      context.handle(
        _milestoneKeyMeta,
        milestoneKey.isAcceptableOrUnknown(
          data['milestone_key']!,
          _milestoneKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_milestoneKeyMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, milestoneKey};
  @override
  Milestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Milestone(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      milestoneKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}milestone_key'],
      )!,
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
    );
  }

  @override
  Milestones createAlias(String alias) {
    return Milestones(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(user_id, milestone_key)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class Milestone extends DataClass implements Insertable<Milestone> {
  final int userId;
  final String milestoneKey;
  final DateTime achievedAt;
  const Milestone({
    required this.userId,
    required this.milestoneKey,
    required this.achievedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['milestone_key'] = Variable<String>(milestoneKey);
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    return map;
  }

  MilestonesCompanion toCompanion(bool nullToAbsent) {
    return MilestonesCompanion(
      userId: Value(userId),
      milestoneKey: Value(milestoneKey),
      achievedAt: Value(achievedAt),
    );
  }

  factory Milestone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Milestone(
      userId: serializer.fromJson<int>(json['user_id']),
      milestoneKey: serializer.fromJson<String>(json['milestone_key']),
      achievedAt: serializer.fromJson<DateTime>(json['achieved_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<int>(userId),
      'milestone_key': serializer.toJson<String>(milestoneKey),
      'achieved_at': serializer.toJson<DateTime>(achievedAt),
    };
  }

  Milestone copyWith({
    int? userId,
    String? milestoneKey,
    DateTime? achievedAt,
  }) => Milestone(
    userId: userId ?? this.userId,
    milestoneKey: milestoneKey ?? this.milestoneKey,
    achievedAt: achievedAt ?? this.achievedAt,
  );
  Milestone copyWithCompanion(MilestonesCompanion data) {
    return Milestone(
      userId: data.userId.present ? data.userId.value : this.userId,
      milestoneKey: data.milestoneKey.present
          ? data.milestoneKey.value
          : this.milestoneKey,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Milestone(')
          ..write('userId: $userId, ')
          ..write('milestoneKey: $milestoneKey, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, milestoneKey, achievedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Milestone &&
          other.userId == this.userId &&
          other.milestoneKey == this.milestoneKey &&
          other.achievedAt == this.achievedAt);
}

class MilestonesCompanion extends UpdateCompanion<Milestone> {
  final Value<int> userId;
  final Value<String> milestoneKey;
  final Value<DateTime> achievedAt;
  final Value<int> rowid;
  const MilestonesCompanion({
    this.userId = const Value.absent(),
    this.milestoneKey = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MilestonesCompanion.insert({
    required int userId,
    required String milestoneKey,
    required DateTime achievedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       milestoneKey = Value(milestoneKey),
       achievedAt = Value(achievedAt);
  static Insertable<Milestone> custom({
    Expression<int>? userId,
    Expression<String>? milestoneKey,
    Expression<DateTime>? achievedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (milestoneKey != null) 'milestone_key': milestoneKey,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MilestonesCompanion copyWith({
    Value<int>? userId,
    Value<String>? milestoneKey,
    Value<DateTime>? achievedAt,
    Value<int>? rowid,
  }) {
    return MilestonesCompanion(
      userId: userId ?? this.userId,
      milestoneKey: milestoneKey ?? this.milestoneKey,
      achievedAt: achievedAt ?? this.achievedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (milestoneKey.present) {
      map['milestone_key'] = Variable<String>(milestoneKey.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MilestonesCompanion(')
          ..write('userId: $userId, ')
          ..write('milestoneKey: $milestoneKey, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class FoodItems extends Table with TableInfo<FoodItems, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FoodItems(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameKeyMeta = const VerificationMeta(
    'nameKey',
  );
  late final GeneratedColumn<String> nameKey = GeneratedColumn<String>(
    'name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _vegetarianMeta = const VerificationMeta(
    'vegetarian',
  );
  late final GeneratedColumn<bool> vegetarian = GeneratedColumn<bool>(
    'vegetarian',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _nutrientTagsMeta = const VerificationMeta(
    'nutrientTags',
  );
  late final GeneratedColumn<String> nutrientTags = GeneratedColumn<String>(
    'nutrient_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameKey,
    stage,
    vegetarian,
    nutrientTags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_key')) {
      context.handle(
        _nameKeyMeta,
        nameKey.isAcceptableOrUnknown(data['name_key']!, _nameKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_nameKeyMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('vegetarian')) {
      context.handle(
        _vegetarianMeta,
        vegetarian.isAcceptableOrUnknown(data['vegetarian']!, _vegetarianMeta),
      );
    } else if (isInserting) {
      context.missing(_vegetarianMeta);
    }
    if (data.containsKey('nutrient_tags')) {
      context.handle(
        _nutrientTagsMeta,
        nutrientTags.isAcceptableOrUnknown(
          data['nutrient_tags']!,
          _nutrientTagsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nutrientTagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_key'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      vegetarian: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vegetarian'],
      )!,
      nutrientTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrient_tags'],
      )!,
    );
  }

  @override
  FoodItems createAlias(String alias) {
    return FoodItems(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final String id;
  final String nameKey;
  final String stage;
  final bool vegetarian;
  final String nutrientTags;
  const FoodItem({
    required this.id,
    required this.nameKey,
    required this.stage,
    required this.vegetarian,
    required this.nutrientTags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_key'] = Variable<String>(nameKey);
    map['stage'] = Variable<String>(stage);
    map['vegetarian'] = Variable<bool>(vegetarian);
    map['nutrient_tags'] = Variable<String>(nutrientTags);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      nameKey: Value(nameKey),
      stage: Value(stage),
      vegetarian: Value(vegetarian),
      nutrientTags: Value(nutrientTags),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<String>(json['id']),
      nameKey: serializer.fromJson<String>(json['name_key']),
      stage: serializer.fromJson<String>(json['stage']),
      vegetarian: serializer.fromJson<bool>(json['vegetarian']),
      nutrientTags: serializer.fromJson<String>(json['nutrient_tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name_key': serializer.toJson<String>(nameKey),
      'stage': serializer.toJson<String>(stage),
      'vegetarian': serializer.toJson<bool>(vegetarian),
      'nutrient_tags': serializer.toJson<String>(nutrientTags),
    };
  }

  FoodItem copyWith({
    String? id,
    String? nameKey,
    String? stage,
    bool? vegetarian,
    String? nutrientTags,
  }) => FoodItem(
    id: id ?? this.id,
    nameKey: nameKey ?? this.nameKey,
    stage: stage ?? this.stage,
    vegetarian: vegetarian ?? this.vegetarian,
    nutrientTags: nutrientTags ?? this.nutrientTags,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      nameKey: data.nameKey.present ? data.nameKey.value : this.nameKey,
      stage: data.stage.present ? data.stage.value : this.stage,
      vegetarian: data.vegetarian.present
          ? data.vegetarian.value
          : this.vegetarian,
      nutrientTags: data.nutrientTags.present
          ? data.nutrientTags.value
          : this.nutrientTags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('stage: $stage, ')
          ..write('vegetarian: $vegetarian, ')
          ..write('nutrientTags: $nutrientTags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameKey, stage, vegetarian, nutrientTags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.nameKey == this.nameKey &&
          other.stage == this.stage &&
          other.vegetarian == this.vegetarian &&
          other.nutrientTags == this.nutrientTags);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<String> id;
  final Value<String> nameKey;
  final Value<String> stage;
  final Value<bool> vegetarian;
  final Value<String> nutrientTags;
  final Value<int> rowid;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.nameKey = const Value.absent(),
    this.stage = const Value.absent(),
    this.vegetarian = const Value.absent(),
    this.nutrientTags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    required String id,
    required String nameKey,
    required String stage,
    required bool vegetarian,
    required String nutrientTags,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameKey = Value(nameKey),
       stage = Value(stage),
       vegetarian = Value(vegetarian),
       nutrientTags = Value(nutrientTags);
  static Insertable<FoodItem> custom({
    Expression<String>? id,
    Expression<String>? nameKey,
    Expression<String>? stage,
    Expression<bool>? vegetarian,
    Expression<String>? nutrientTags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameKey != null) 'name_key': nameKey,
      if (stage != null) 'stage': stage,
      if (vegetarian != null) 'vegetarian': vegetarian,
      if (nutrientTags != null) 'nutrient_tags': nutrientTags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameKey,
    Value<String>? stage,
    Value<bool>? vegetarian,
    Value<String>? nutrientTags,
    Value<int>? rowid,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      nameKey: nameKey ?? this.nameKey,
      stage: stage ?? this.stage,
      vegetarian: vegetarian ?? this.vegetarian,
      nutrientTags: nutrientTags ?? this.nutrientTags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameKey.present) {
      map['name_key'] = Variable<String>(nameKey.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (vegetarian.present) {
      map['vegetarian'] = Variable<bool>(vegetarian.value);
    }
    if (nutrientTags.present) {
      map['nutrient_tags'] = Variable<String>(nutrientTags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('stage: $stage, ')
          ..write('vegetarian: $vegetarian, ')
          ..write('nutrientTags: $nutrientTags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Recipes extends Table with TableInfo<Recipes, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Recipes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _foodItemIdMeta = const VerificationMeta(
    'foodItemId',
  );
  late final GeneratedColumn<String> foodItemId = GeneratedColumn<String>(
    'food_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES food_items(id)',
  );
  static const VerificationMeta _titleKeyMeta = const VerificationMeta(
    'titleKey',
  );
  late final GeneratedColumn<String> titleKey = GeneratedColumn<String>(
    'title_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _instructionsKeyMeta = const VerificationMeta(
    'instructionsKey',
  );
  late final GeneratedColumn<String> instructionsKey = GeneratedColumn<String>(
    'instructions_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodItemId,
    titleKey,
    instructionsKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_item_id')) {
      context.handle(
        _foodItemIdMeta,
        foodItemId.isAcceptableOrUnknown(
          data['food_item_id']!,
          _foodItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodItemIdMeta);
    }
    if (data.containsKey('title_key')) {
      context.handle(
        _titleKeyMeta,
        titleKey.isAcceptableOrUnknown(data['title_key']!, _titleKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_titleKeyMeta);
    }
    if (data.containsKey('instructions_key')) {
      context.handle(
        _instructionsKeyMeta,
        instructionsKey.isAcceptableOrUnknown(
          data['instructions_key']!,
          _instructionsKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsKeyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_item_id'],
      )!,
      titleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_key'],
      )!,
      instructionsKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions_key'],
      )!,
    );
  }

  @override
  Recipes createAlias(String alias) {
    return Recipes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final String id;
  final String foodItemId;
  final String titleKey;
  final String instructionsKey;
  const Recipe({
    required this.id,
    required this.foodItemId,
    required this.titleKey,
    required this.instructionsKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_item_id'] = Variable<String>(foodItemId);
    map['title_key'] = Variable<String>(titleKey);
    map['instructions_key'] = Variable<String>(instructionsKey);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      foodItemId: Value(foodItemId),
      titleKey: Value(titleKey),
      instructionsKey: Value(instructionsKey),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<String>(json['id']),
      foodItemId: serializer.fromJson<String>(json['food_item_id']),
      titleKey: serializer.fromJson<String>(json['title_key']),
      instructionsKey: serializer.fromJson<String>(json['instructions_key']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'food_item_id': serializer.toJson<String>(foodItemId),
      'title_key': serializer.toJson<String>(titleKey),
      'instructions_key': serializer.toJson<String>(instructionsKey),
    };
  }

  Recipe copyWith({
    String? id,
    String? foodItemId,
    String? titleKey,
    String? instructionsKey,
  }) => Recipe(
    id: id ?? this.id,
    foodItemId: foodItemId ?? this.foodItemId,
    titleKey: titleKey ?? this.titleKey,
    instructionsKey: instructionsKey ?? this.instructionsKey,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      foodItemId: data.foodItemId.present
          ? data.foodItemId.value
          : this.foodItemId,
      titleKey: data.titleKey.present ? data.titleKey.value : this.titleKey,
      instructionsKey: data.instructionsKey.present
          ? data.instructionsKey.value
          : this.instructionsKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('titleKey: $titleKey, ')
          ..write('instructionsKey: $instructionsKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, foodItemId, titleKey, instructionsKey);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.foodItemId == this.foodItemId &&
          other.titleKey == this.titleKey &&
          other.instructionsKey == this.instructionsKey);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<String> id;
  final Value<String> foodItemId;
  final Value<String> titleKey;
  final Value<String> instructionsKey;
  final Value<int> rowid;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.foodItemId = const Value.absent(),
    this.titleKey = const Value.absent(),
    this.instructionsKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipesCompanion.insert({
    required String id,
    required String foodItemId,
    required String titleKey,
    required String instructionsKey,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodItemId = Value(foodItemId),
       titleKey = Value(titleKey),
       instructionsKey = Value(instructionsKey);
  static Insertable<Recipe> custom({
    Expression<String>? id,
    Expression<String>? foodItemId,
    Expression<String>? titleKey,
    Expression<String>? instructionsKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodItemId != null) 'food_item_id': foodItemId,
      if (titleKey != null) 'title_key': titleKey,
      if (instructionsKey != null) 'instructions_key': instructionsKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? foodItemId,
    Value<String>? titleKey,
    Value<String>? instructionsKey,
    Value<int>? rowid,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      foodItemId: foodItemId ?? this.foodItemId,
      titleKey: titleKey ?? this.titleKey,
      instructionsKey: instructionsKey ?? this.instructionsKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodItemId.present) {
      map['food_item_id'] = Variable<String>(foodItemId.value);
    }
    if (titleKey.present) {
      map['title_key'] = Variable<String>(titleKey.value);
    }
    if (instructionsKey.present) {
      map['instructions_key'] = Variable<String>(instructionsKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('titleKey: $titleKey, ')
          ..write('instructionsKey: $instructionsKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class YogaRoutines extends Table with TableInfo<YogaRoutines, YogaRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  YogaRoutines(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _titleKeyMeta = const VerificationMeta(
    'titleKey',
  );
  late final GeneratedColumn<String> titleKey = GeneratedColumn<String>(
    'title_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _injuryTagsMeta = const VerificationMeta(
    'injuryTags',
  );
  late final GeneratedColumn<String> injuryTags = GeneratedColumn<String>(
    'injury_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _physioApprovedMeta = const VerificationMeta(
    'physioApproved',
  );
  late final GeneratedColumn<bool> physioApproved = GeneratedColumn<bool>(
    'physio_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT FALSE',
    defaultValue: const CustomExpression('FALSE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    titleKey,
    stage,
    injuryTags,
    physioApproved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'yoga_routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<YogaRoutine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title_key')) {
      context.handle(
        _titleKeyMeta,
        titleKey.isAcceptableOrUnknown(data['title_key']!, _titleKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_titleKeyMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('injury_tags')) {
      context.handle(
        _injuryTagsMeta,
        injuryTags.isAcceptableOrUnknown(data['injury_tags']!, _injuryTagsMeta),
      );
    } else if (isInserting) {
      context.missing(_injuryTagsMeta);
    }
    if (data.containsKey('physio_approved')) {
      context.handle(
        _physioApprovedMeta,
        physioApproved.isAcceptableOrUnknown(
          data['physio_approved']!,
          _physioApprovedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  YogaRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return YogaRoutine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      titleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_key'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      injuryTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}injury_tags'],
      )!,
      physioApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}physio_approved'],
      )!,
    );
  }

  @override
  YogaRoutines createAlias(String alias) {
    return YogaRoutines(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class YogaRoutine extends DataClass implements Insertable<YogaRoutine> {
  final String id;
  final int userId;
  final String titleKey;
  final String stage;
  final String injuryTags;
  final bool physioApproved;
  const YogaRoutine({
    required this.id,
    required this.userId,
    required this.titleKey,
    required this.stage,
    required this.injuryTags,
    required this.physioApproved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['title_key'] = Variable<String>(titleKey);
    map['stage'] = Variable<String>(stage);
    map['injury_tags'] = Variable<String>(injuryTags);
    map['physio_approved'] = Variable<bool>(physioApproved);
    return map;
  }

  YogaRoutinesCompanion toCompanion(bool nullToAbsent) {
    return YogaRoutinesCompanion(
      id: Value(id),
      userId: Value(userId),
      titleKey: Value(titleKey),
      stage: Value(stage),
      injuryTags: Value(injuryTags),
      physioApproved: Value(physioApproved),
    );
  }

  factory YogaRoutine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return YogaRoutine(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['user_id']),
      titleKey: serializer.fromJson<String>(json['title_key']),
      stage: serializer.fromJson<String>(json['stage']),
      injuryTags: serializer.fromJson<String>(json['injury_tags']),
      physioApproved: serializer.fromJson<bool>(json['physio_approved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<int>(userId),
      'title_key': serializer.toJson<String>(titleKey),
      'stage': serializer.toJson<String>(stage),
      'injury_tags': serializer.toJson<String>(injuryTags),
      'physio_approved': serializer.toJson<bool>(physioApproved),
    };
  }

  YogaRoutine copyWith({
    String? id,
    int? userId,
    String? titleKey,
    String? stage,
    String? injuryTags,
    bool? physioApproved,
  }) => YogaRoutine(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    titleKey: titleKey ?? this.titleKey,
    stage: stage ?? this.stage,
    injuryTags: injuryTags ?? this.injuryTags,
    physioApproved: physioApproved ?? this.physioApproved,
  );
  YogaRoutine copyWithCompanion(YogaRoutinesCompanion data) {
    return YogaRoutine(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      titleKey: data.titleKey.present ? data.titleKey.value : this.titleKey,
      stage: data.stage.present ? data.stage.value : this.stage,
      injuryTags: data.injuryTags.present
          ? data.injuryTags.value
          : this.injuryTags,
      physioApproved: data.physioApproved.present
          ? data.physioApproved.value
          : this.physioApproved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('YogaRoutine(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('titleKey: $titleKey, ')
          ..write('stage: $stage, ')
          ..write('injuryTags: $injuryTags, ')
          ..write('physioApproved: $physioApproved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, titleKey, stage, injuryTags, physioApproved);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YogaRoutine &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.titleKey == this.titleKey &&
          other.stage == this.stage &&
          other.injuryTags == this.injuryTags &&
          other.physioApproved == this.physioApproved);
}

class YogaRoutinesCompanion extends UpdateCompanion<YogaRoutine> {
  final Value<String> id;
  final Value<int> userId;
  final Value<String> titleKey;
  final Value<String> stage;
  final Value<String> injuryTags;
  final Value<bool> physioApproved;
  final Value<int> rowid;
  const YogaRoutinesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.titleKey = const Value.absent(),
    this.stage = const Value.absent(),
    this.injuryTags = const Value.absent(),
    this.physioApproved = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  YogaRoutinesCompanion.insert({
    required String id,
    required int userId,
    required String titleKey,
    required String stage,
    required String injuryTags,
    this.physioApproved = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       titleKey = Value(titleKey),
       stage = Value(stage),
       injuryTags = Value(injuryTags);
  static Insertable<YogaRoutine> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<String>? titleKey,
    Expression<String>? stage,
    Expression<String>? injuryTags,
    Expression<bool>? physioApproved,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (titleKey != null) 'title_key': titleKey,
      if (stage != null) 'stage': stage,
      if (injuryTags != null) 'injury_tags': injuryTags,
      if (physioApproved != null) 'physio_approved': physioApproved,
      if (rowid != null) 'rowid': rowid,
    });
  }

  YogaRoutinesCompanion copyWith({
    Value<String>? id,
    Value<int>? userId,
    Value<String>? titleKey,
    Value<String>? stage,
    Value<String>? injuryTags,
    Value<bool>? physioApproved,
    Value<int>? rowid,
  }) {
    return YogaRoutinesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      titleKey: titleKey ?? this.titleKey,
      stage: stage ?? this.stage,
      injuryTags: injuryTags ?? this.injuryTags,
      physioApproved: physioApproved ?? this.physioApproved,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (titleKey.present) {
      map['title_key'] = Variable<String>(titleKey.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (injuryTags.present) {
      map['injury_tags'] = Variable<String>(injuryTags.value);
    }
    if (physioApproved.present) {
      map['physio_approved'] = Variable<bool>(physioApproved.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('YogaRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('titleKey: $titleKey, ')
          ..write('stage: $stage, ')
          ..write('injuryTags: $injuryTags, ')
          ..write('physioApproved: $physioApproved, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class MedicationLogs extends Table
    with TableInfo<MedicationLogs, MedicationLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MedicationLogs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _medicineNameMeta = const VerificationMeta(
    'medicineName',
  );
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
    'medicine_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    medicineName,
    scheduledAt,
    takenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicationLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('medicine_name')) {
      context.handle(
        _medicineNameMeta,
        medicineName.isAcceptableOrUnknown(
          data['medicine_name']!,
          _medicineNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      medicineName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medicine_name'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      ),
    );
  }

  @override
  MedicationLogs createAlias(String alias) {
    return MedicationLogs(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MedicationLog extends DataClass implements Insertable<MedicationLog> {
  final String id;
  final int userId;
  final String medicineName;
  final DateTime scheduledAt;
  final DateTime? takenAt;
  const MedicationLog({
    required this.id,
    required this.userId,
    required this.medicineName,
    required this.scheduledAt,
    this.takenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['medicine_name'] = Variable<String>(medicineName);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    return map;
  }

  MedicationLogsCompanion toCompanion(bool nullToAbsent) {
    return MedicationLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      medicineName: Value(medicineName),
      scheduledAt: Value(scheduledAt),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
    );
  }

  factory MedicationLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationLog(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['user_id']),
      medicineName: serializer.fromJson<String>(json['medicine_name']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduled_at']),
      takenAt: serializer.fromJson<DateTime?>(json['taken_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<int>(userId),
      'medicine_name': serializer.toJson<String>(medicineName),
      'scheduled_at': serializer.toJson<DateTime>(scheduledAt),
      'taken_at': serializer.toJson<DateTime?>(takenAt),
    };
  }

  MedicationLog copyWith({
    String? id,
    int? userId,
    String? medicineName,
    DateTime? scheduledAt,
    Value<DateTime?> takenAt = const Value.absent(),
  }) => MedicationLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    medicineName: medicineName ?? this.medicineName,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    takenAt: takenAt.present ? takenAt.value : this.takenAt,
  );
  MedicationLog copyWithCompanion(MedicationLogsCompanion data) {
    return MedicationLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      medicineName: data.medicineName.present
          ? data.medicineName.value
          : this.medicineName,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('medicineName: $medicineName, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, medicineName, scheduledAt, takenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.medicineName == this.medicineName &&
          other.scheduledAt == this.scheduledAt &&
          other.takenAt == this.takenAt);
}

class MedicationLogsCompanion extends UpdateCompanion<MedicationLog> {
  final Value<String> id;
  final Value<int> userId;
  final Value<String> medicineName;
  final Value<DateTime> scheduledAt;
  final Value<DateTime?> takenAt;
  final Value<int> rowid;
  const MedicationLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationLogsCompanion.insert({
    required String id,
    required int userId,
    required String medicineName,
    required DateTime scheduledAt,
    this.takenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       medicineName = Value(medicineName),
       scheduledAt = Value(scheduledAt);
  static Insertable<MedicationLog> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<String>? medicineName,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? takenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (takenAt != null) 'taken_at': takenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationLogsCompanion copyWith({
    Value<String>? id,
    Value<int>? userId,
    Value<String>? medicineName,
    Value<DateTime>? scheduledAt,
    Value<DateTime?>? takenAt,
    Value<int>? rowid,
  }) {
    return MedicationLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      medicineName: medicineName ?? this.medicineName,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      takenAt: takenAt ?? this.takenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('medicineName: $medicineName, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('takenAt: $takenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class FallEvents extends Table with TableInfo<FallEvents, FallEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FallEvents(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _detectedAtMeta = const VerificationMeta(
    'detectedAt',
  );
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
    'detected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _acknowledgedAtMeta = const VerificationMeta(
    'acknowledgedAt',
  );
  late final GeneratedColumn<DateTime> acknowledgedAt =
      GeneratedColumn<DateTime>(
        'acknowledged_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const VerificationMeta _firstNotifiedAtMeta = const VerificationMeta(
    'firstNotifiedAt',
  );
  late final GeneratedColumn<DateTime> firstNotifiedAt =
      GeneratedColumn<DateTime>(
        'first_notified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const VerificationMeta _secondNotifiedAtMeta = const VerificationMeta(
    'secondNotifiedAt',
  );
  late final GeneratedColumn<DateTime> secondNotifiedAt =
      GeneratedColumn<DateTime>(
        'second_notified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    detectedAt,
    acknowledgedAt,
    firstNotifiedAt,
    secondNotifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fall_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<FallEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('detected_at')) {
      context.handle(
        _detectedAtMeta,
        detectedAt.isAcceptableOrUnknown(data['detected_at']!, _detectedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_detectedAtMeta);
    }
    if (data.containsKey('acknowledged_at')) {
      context.handle(
        _acknowledgedAtMeta,
        acknowledgedAt.isAcceptableOrUnknown(
          data['acknowledged_at']!,
          _acknowledgedAtMeta,
        ),
      );
    }
    if (data.containsKey('first_notified_at')) {
      context.handle(
        _firstNotifiedAtMeta,
        firstNotifiedAt.isAcceptableOrUnknown(
          data['first_notified_at']!,
          _firstNotifiedAtMeta,
        ),
      );
    }
    if (data.containsKey('second_notified_at')) {
      context.handle(
        _secondNotifiedAtMeta,
        secondNotifiedAt.isAcceptableOrUnknown(
          data['second_notified_at']!,
          _secondNotifiedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FallEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FallEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      detectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}detected_at'],
      )!,
      acknowledgedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acknowledged_at'],
      ),
      firstNotifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_notified_at'],
      ),
      secondNotifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}second_notified_at'],
      ),
    );
  }

  @override
  FallEvents createAlias(String alias) {
    return FallEvents(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class FallEvent extends DataClass implements Insertable<FallEvent> {
  final String id;
  final int userId;
  final DateTime detectedAt;
  final DateTime? acknowledgedAt;
  final DateTime? firstNotifiedAt;
  final DateTime? secondNotifiedAt;
  const FallEvent({
    required this.id,
    required this.userId,
    required this.detectedAt,
    this.acknowledgedAt,
    this.firstNotifiedAt,
    this.secondNotifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    map['detected_at'] = Variable<DateTime>(detectedAt);
    if (!nullToAbsent || acknowledgedAt != null) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt);
    }
    if (!nullToAbsent || firstNotifiedAt != null) {
      map['first_notified_at'] = Variable<DateTime>(firstNotifiedAt);
    }
    if (!nullToAbsent || secondNotifiedAt != null) {
      map['second_notified_at'] = Variable<DateTime>(secondNotifiedAt);
    }
    return map;
  }

  FallEventsCompanion toCompanion(bool nullToAbsent) {
    return FallEventsCompanion(
      id: Value(id),
      userId: Value(userId),
      detectedAt: Value(detectedAt),
      acknowledgedAt: acknowledgedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedAt),
      firstNotifiedAt: firstNotifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firstNotifiedAt),
      secondNotifiedAt: secondNotifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(secondNotifiedAt),
    );
  }

  factory FallEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FallEvent(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['user_id']),
      detectedAt: serializer.fromJson<DateTime>(json['detected_at']),
      acknowledgedAt: serializer.fromJson<DateTime?>(json['acknowledged_at']),
      firstNotifiedAt: serializer.fromJson<DateTime?>(
        json['first_notified_at'],
      ),
      secondNotifiedAt: serializer.fromJson<DateTime?>(
        json['second_notified_at'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<int>(userId),
      'detected_at': serializer.toJson<DateTime>(detectedAt),
      'acknowledged_at': serializer.toJson<DateTime?>(acknowledgedAt),
      'first_notified_at': serializer.toJson<DateTime?>(firstNotifiedAt),
      'second_notified_at': serializer.toJson<DateTime?>(secondNotifiedAt),
    };
  }

  FallEvent copyWith({
    String? id,
    int? userId,
    DateTime? detectedAt,
    Value<DateTime?> acknowledgedAt = const Value.absent(),
    Value<DateTime?> firstNotifiedAt = const Value.absent(),
    Value<DateTime?> secondNotifiedAt = const Value.absent(),
  }) => FallEvent(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    detectedAt: detectedAt ?? this.detectedAt,
    acknowledgedAt: acknowledgedAt.present
        ? acknowledgedAt.value
        : this.acknowledgedAt,
    firstNotifiedAt: firstNotifiedAt.present
        ? firstNotifiedAt.value
        : this.firstNotifiedAt,
    secondNotifiedAt: secondNotifiedAt.present
        ? secondNotifiedAt.value
        : this.secondNotifiedAt,
  );
  FallEvent copyWithCompanion(FallEventsCompanion data) {
    return FallEvent(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      detectedAt: data.detectedAt.present
          ? data.detectedAt.value
          : this.detectedAt,
      acknowledgedAt: data.acknowledgedAt.present
          ? data.acknowledgedAt.value
          : this.acknowledgedAt,
      firstNotifiedAt: data.firstNotifiedAt.present
          ? data.firstNotifiedAt.value
          : this.firstNotifiedAt,
      secondNotifiedAt: data.secondNotifiedAt.present
          ? data.secondNotifiedAt.value
          : this.secondNotifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FallEvent(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('firstNotifiedAt: $firstNotifiedAt, ')
          ..write('secondNotifiedAt: $secondNotifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    detectedAt,
    acknowledgedAt,
    firstNotifiedAt,
    secondNotifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FallEvent &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.detectedAt == this.detectedAt &&
          other.acknowledgedAt == this.acknowledgedAt &&
          other.firstNotifiedAt == this.firstNotifiedAt &&
          other.secondNotifiedAt == this.secondNotifiedAt);
}

class FallEventsCompanion extends UpdateCompanion<FallEvent> {
  final Value<String> id;
  final Value<int> userId;
  final Value<DateTime> detectedAt;
  final Value<DateTime?> acknowledgedAt;
  final Value<DateTime?> firstNotifiedAt;
  final Value<DateTime?> secondNotifiedAt;
  final Value<int> rowid;
  const FallEventsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.detectedAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.firstNotifiedAt = const Value.absent(),
    this.secondNotifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FallEventsCompanion.insert({
    required String id,
    required int userId,
    required DateTime detectedAt,
    this.acknowledgedAt = const Value.absent(),
    this.firstNotifiedAt = const Value.absent(),
    this.secondNotifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       detectedAt = Value(detectedAt);
  static Insertable<FallEvent> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<DateTime>? detectedAt,
    Expression<DateTime>? acknowledgedAt,
    Expression<DateTime>? firstNotifiedAt,
    Expression<DateTime>? secondNotifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (detectedAt != null) 'detected_at': detectedAt,
      if (acknowledgedAt != null) 'acknowledged_at': acknowledgedAt,
      if (firstNotifiedAt != null) 'first_notified_at': firstNotifiedAt,
      if (secondNotifiedAt != null) 'second_notified_at': secondNotifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FallEventsCompanion copyWith({
    Value<String>? id,
    Value<int>? userId,
    Value<DateTime>? detectedAt,
    Value<DateTime?>? acknowledgedAt,
    Value<DateTime?>? firstNotifiedAt,
    Value<DateTime?>? secondNotifiedAt,
    Value<int>? rowid,
  }) {
    return FallEventsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      detectedAt: detectedAt ?? this.detectedAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      firstNotifiedAt: firstNotifiedAt ?? this.firstNotifiedAt,
      secondNotifiedAt: secondNotifiedAt ?? this.secondNotifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    if (acknowledgedAt.present) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt.value);
    }
    if (firstNotifiedAt.present) {
      map['first_notified_at'] = Variable<DateTime>(firstNotifiedAt.value);
    }
    if (secondNotifiedAt.present) {
      map['second_notified_at'] = Variable<DateTime>(secondNotifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FallEventsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('firstNotifiedAt: $firstNotifiedAt, ')
          ..write('secondNotifiedAt: $secondNotifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DeviceInfos extends Table with TableInfo<DeviceInfos, DeviceInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DeviceInfos(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _firmwareMeta = const VerificationMeta(
    'firmware',
  );
  late final GeneratedColumn<String> firmware = GeneratedColumn<String>(
    'firmware',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _batteryPercentMeta = const VerificationMeta(
    'batteryPercent',
  );
  late final GeneratedColumn<int> batteryPercent = GeneratedColumn<int>(
    'battery_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (battery_percent BETWEEN 0 AND 100)',
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    firmware,
    batteryPercent,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_infos';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceInfo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('firmware')) {
      context.handle(
        _firmwareMeta,
        firmware.isAcceptableOrUnknown(data['firmware']!, _firmwareMeta),
      );
    }
    if (data.containsKey('battery_percent')) {
      context.handle(
        _batteryPercentMeta,
        batteryPercent.isAcceptableOrUnknown(
          data['battery_percent']!,
          _batteryPercentMeta,
        ),
      );
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceInfo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      firmware: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}firmware'],
      ),
      batteryPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_percent'],
      ),
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  DeviceInfos createAlias(String alias) {
    return DeviceInfos(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DeviceInfo extends DataClass implements Insertable<DeviceInfo> {
  final String id;
  final int userId;
  final String? firmware;
  final int? batteryPercent;
  final DateTime? lastSeenAt;
  const DeviceInfo({
    required this.id,
    required this.userId,
    this.firmware,
    this.batteryPercent,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || firmware != null) {
      map['firmware'] = Variable<String>(firmware);
    }
    if (!nullToAbsent || batteryPercent != null) {
      map['battery_percent'] = Variable<int>(batteryPercent);
    }
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    }
    return map;
  }

  DeviceInfosCompanion toCompanion(bool nullToAbsent) {
    return DeviceInfosCompanion(
      id: Value(id),
      userId: Value(userId),
      firmware: firmware == null && nullToAbsent
          ? const Value.absent()
          : Value(firmware),
      batteryPercent: batteryPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryPercent),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory DeviceInfo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceInfo(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<int>(json['user_id']),
      firmware: serializer.fromJson<String?>(json['firmware']),
      batteryPercent: serializer.fromJson<int?>(json['battery_percent']),
      lastSeenAt: serializer.fromJson<DateTime?>(json['last_seen_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<int>(userId),
      'firmware': serializer.toJson<String?>(firmware),
      'battery_percent': serializer.toJson<int?>(batteryPercent),
      'last_seen_at': serializer.toJson<DateTime?>(lastSeenAt),
    };
  }

  DeviceInfo copyWith({
    String? id,
    int? userId,
    Value<String?> firmware = const Value.absent(),
    Value<int?> batteryPercent = const Value.absent(),
    Value<DateTime?> lastSeenAt = const Value.absent(),
  }) => DeviceInfo(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    firmware: firmware.present ? firmware.value : this.firmware,
    batteryPercent: batteryPercent.present
        ? batteryPercent.value
        : this.batteryPercent,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  DeviceInfo copyWithCompanion(DeviceInfosCompanion data) {
    return DeviceInfo(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      firmware: data.firmware.present ? data.firmware.value : this.firmware,
      batteryPercent: data.batteryPercent.present
          ? data.batteryPercent.value
          : this.batteryPercent,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceInfo(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('firmware: $firmware, ')
          ..write('batteryPercent: $batteryPercent, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, firmware, batteryPercent, lastSeenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceInfo &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.firmware == this.firmware &&
          other.batteryPercent == this.batteryPercent &&
          other.lastSeenAt == this.lastSeenAt);
}

class DeviceInfosCompanion extends UpdateCompanion<DeviceInfo> {
  final Value<String> id;
  final Value<int> userId;
  final Value<String?> firmware;
  final Value<int?> batteryPercent;
  final Value<DateTime?> lastSeenAt;
  final Value<int> rowid;
  const DeviceInfosCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.firmware = const Value.absent(),
    this.batteryPercent = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceInfosCompanion.insert({
    required String id,
    required int userId,
    this.firmware = const Value.absent(),
    this.batteryPercent = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId);
  static Insertable<DeviceInfo> custom({
    Expression<String>? id,
    Expression<int>? userId,
    Expression<String>? firmware,
    Expression<int>? batteryPercent,
    Expression<DateTime>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (firmware != null) 'firmware': firmware,
      if (batteryPercent != null) 'battery_percent': batteryPercent,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceInfosCompanion copyWith({
    Value<String>? id,
    Value<int>? userId,
    Value<String?>? firmware,
    Value<int?>? batteryPercent,
    Value<DateTime?>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return DeviceInfosCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      firmware: firmware ?? this.firmware,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (firmware.present) {
      map['firmware'] = Variable<String>(firmware.value);
    }
    if (batteryPercent.present) {
      map['battery_percent'] = Variable<int>(batteryPercent.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceInfosCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('firmware: $firmware, ')
          ..write('batteryPercent: $batteryPercent, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CareDatabase extends GeneratedDatabase {
  _$CareDatabase(QueryExecutor e) : super(e);
  $CareDatabaseManager get managers => $CareDatabaseManager(this);
  late final EmergencyContacts emergencyContacts = EmergencyContacts(this);
  late final Users users = Users(this);
  late final InjuryProfiles injuryProfiles = InjuryProfiles(this);
  late final WalkSessions walkSessions = WalkSessions(this);
  late final DailyMetrics dailyMetrics = DailyMetrics(this);
  late final RecoveryScores recoveryScores = RecoveryScores(this);
  late final Milestones milestones = Milestones(this);
  late final FoodItems foodItems = FoodItems(this);
  late final Recipes recipes = Recipes(this);
  late final YogaRoutines yogaRoutines = YogaRoutines(this);
  late final MedicationLogs medicationLogs = MedicationLogs(this);
  late final FallEvents fallEvents = FallEvents(this);
  late final DeviceInfos deviceInfos = DeviceInfos(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    emergencyContacts,
    users,
    injuryProfiles,
    walkSessions,
    dailyMetrics,
    recoveryScores,
    milestones,
    foodItems,
    recipes,
    yogaRoutines,
    medicationLogs,
    fallEvents,
    deviceInfos,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('emergency_contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injury_profiles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('walk_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('daily_metrics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recovery_scores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('milestones', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('yoga_routines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('medication_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fall_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_infos', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $EmergencyContactsCreateCompanionBuilder =
    EmergencyContactsCompanion Function({
      required int userId,
      required int position,
      required String name,
      required String phoneE164,
      required String relationship,
      Value<int> rowid,
    });
typedef $EmergencyContactsUpdateCompanionBuilder =
    EmergencyContactsCompanion Function({
      Value<int> userId,
      Value<int> position,
      Value<String> name,
      Value<String> phoneE164,
      Value<String> relationship,
      Value<int> rowid,
    });

final class $EmergencyContactsReferences
    extends
        BaseReferences<_$CareDatabase, EmergencyContacts, EmergencyContact> {
  $EmergencyContactsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('emergency_contacts__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $EmergencyContactsFilterComposer
    extends Composer<_$CareDatabase, EmergencyContacts> {
  $EmergencyContactsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneE164 => $composableBuilder(
    column: $table.phoneE164,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $EmergencyContactsOrderingComposer
    extends Composer<_$CareDatabase, EmergencyContacts> {
  $EmergencyContactsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneE164 => $composableBuilder(
    column: $table.phoneE164,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $EmergencyContactsAnnotationComposer
    extends Composer<_$CareDatabase, EmergencyContacts> {
  $EmergencyContactsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phoneE164 =>
      $composableBuilder(column: $table.phoneE164, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $EmergencyContactsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          EmergencyContacts,
          EmergencyContact,
          $EmergencyContactsFilterComposer,
          $EmergencyContactsOrderingComposer,
          $EmergencyContactsAnnotationComposer,
          $EmergencyContactsCreateCompanionBuilder,
          $EmergencyContactsUpdateCompanionBuilder,
          (EmergencyContact, $EmergencyContactsReferences),
          EmergencyContact,
          PrefetchHooks Function({bool userId})
        > {
  $EmergencyContactsTableManager(_$CareDatabase db, EmergencyContacts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $EmergencyContactsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $EmergencyContactsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $EmergencyContactsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phoneE164 = const Value.absent(),
                Value<String> relationship = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmergencyContactsCompanion(
                userId: userId,
                position: position,
                name: name,
                phoneE164: phoneE164,
                relationship: relationship,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required int position,
                required String name,
                required String phoneE164,
                required String relationship,
                Value<int> rowid = const Value.absent(),
              }) => EmergencyContactsCompanion.insert(
                userId: userId,
                position: position,
                name: name,
                phoneE164: phoneE164,
                relationship: relationship,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<EmergencyContacts, EmergencyContact>(table),
                  $EmergencyContactsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $EmergencyContactsReferences
                            ._userIdTable(db),
                        referencedColumn: $EmergencyContactsReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $EmergencyContactsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      EmergencyContacts,
      EmergencyContact,
      $EmergencyContactsFilterComposer,
      $EmergencyContactsOrderingComposer,
      $EmergencyContactsAnnotationComposer,
      $EmergencyContactsCreateCompanionBuilder,
      $EmergencyContactsUpdateCompanionBuilder,
      (EmergencyContact, $EmergencyContactsReferences),
      EmergencyContact,
      PrefetchHooks Function({bool userId})
    >;
typedef $UsersCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required double heightCm,
  required int age,
  required String locale,
  Value<int> firstSlot,
  Value<int> secondSlot,
});
typedef $UsersUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<double> heightCm,
  Value<int> age,
  Value<String> locale,
  Value<int> firstSlot,
  Value<int> secondSlot,
});

final class $UsersReferences
    extends BaseReferences<_$CareDatabase, Users, User> {
  $UsersReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<EmergencyContacts, List<EmergencyContact>>
  _emergencyContactsRefsTable(_$CareDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.emergencyContacts,
        aliasName: 'users__id__emergency_contacts__user_id',
      );

  $EmergencyContactsProcessedTableManager get emergencyContactsRefs {
    final manager = $EmergencyContactsTableManager(
      $_db,
      $_db.emergencyContacts,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _emergencyContactsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<InjuryProfiles, List<InjuryProfile>>
  _injuryProfilesRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.injuryProfiles,
    aliasName: 'users__id__injury_profiles__user_id',
  );

  $InjuryProfilesProcessedTableManager get injuryProfilesRefs {
    final manager = $InjuryProfilesTableManager(
      $_db,
      $_db.injuryProfiles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_injuryProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<WalkSessions, List<WalkSession>>
  _walkSessionsRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.walkSessions,
    aliasName: 'users__id__walk_sessions__user_id',
  );

  $WalkSessionsProcessedTableManager get walkSessionsRefs {
    final manager = $WalkSessionsTableManager(
      $_db,
      $_db.walkSessions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_walkSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<DailyMetrics, List<DailyMetric>>
  _dailyMetricsRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyMetrics,
    aliasName: 'users__id__daily_metrics__user_id',
  );

  $DailyMetricsProcessedTableManager get dailyMetricsRefs {
    final manager = $DailyMetricsTableManager(
      $_db,
      $_db.dailyMetrics,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyMetricsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<RecoveryScores, List<RecoveryScore>>
  _recoveryScoresRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.recoveryScores,
    aliasName: 'users__id__recovery_scores__user_id',
  );

  $RecoveryScoresProcessedTableManager get recoveryScoresRefs {
    final manager = $RecoveryScoresTableManager(
      $_db,
      $_db.recoveryScores,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recoveryScoresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Milestones, List<Milestone>> _milestonesRefsTable(
    _$CareDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.milestones,
    aliasName: 'users__id__milestones__user_id',
  );

  $MilestonesProcessedTableManager get milestonesRefs {
    final manager = $MilestonesTableManager(
      $_db,
      $_db.milestones,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_milestonesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<YogaRoutines, List<YogaRoutine>>
  _yogaRoutinesRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.yogaRoutines,
    aliasName: 'users__id__yoga_routines__user_id',
  );

  $YogaRoutinesProcessedTableManager get yogaRoutinesRefs {
    final manager = $YogaRoutinesTableManager(
      $_db,
      $_db.yogaRoutines,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_yogaRoutinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<MedicationLogs, List<MedicationLog>>
  _medicationLogsRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.medicationLogs,
    aliasName: 'users__id__medication_logs__user_id',
  );

  $MedicationLogsProcessedTableManager get medicationLogsRefs {
    final manager = $MedicationLogsTableManager(
      $_db,
      $_db.medicationLogs,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicationLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<FallEvents, List<FallEvent>> _fallEventsRefsTable(
    _$CareDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.fallEvents,
    aliasName: 'users__id__fall_events__user_id',
  );

  $FallEventsProcessedTableManager get fallEventsRefs {
    final manager = $FallEventsTableManager(
      $_db,
      $_db.fallEvents,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fallEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<DeviceInfos, List<DeviceInfo>>
  _deviceInfosRefsTable(_$CareDatabase db) => MultiTypedResultKey.fromTable(
    db.deviceInfos,
    aliasName: 'users__id__device_infos__user_id',
  );

  $DeviceInfosProcessedTableManager get deviceInfosRefs {
    final manager = $DeviceInfosTableManager(
      $_db,
      $_db.deviceInfos,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_deviceInfosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $UsersFilterComposer extends Composer<_$CareDatabase, Users> {
  $UsersFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get firstSlot => $composableBuilder(
    column: $table.firstSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get secondSlot => $composableBuilder(
    column: $table.secondSlot,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> emergencyContactsRefs(
    Expression<bool> Function($EmergencyContactsFilterComposer f) f,
  ) {
    final $EmergencyContactsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emergencyContacts,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $EmergencyContactsFilterComposer(
            $db: $db,
            $table: $db.emergencyContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> injuryProfilesRefs(
    Expression<bool> Function($InjuryProfilesFilterComposer f) f,
  ) {
    final $InjuryProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injuryProfiles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InjuryProfilesFilterComposer(
            $db: $db,
            $table: $db.injuryProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> walkSessionsRefs(
    Expression<bool> Function($WalkSessionsFilterComposer f) f,
  ) {
    final $WalkSessionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkSessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WalkSessionsFilterComposer(
            $db: $db,
            $table: $db.walkSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyMetricsRefs(
    Expression<bool> Function($DailyMetricsFilterComposer f) f,
  ) {
    final $DailyMetricsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyMetrics,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DailyMetricsFilterComposer(
            $db: $db,
            $table: $db.dailyMetrics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recoveryScoresRefs(
    Expression<bool> Function($RecoveryScoresFilterComposer f) f,
  ) {
    final $RecoveryScoresFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recoveryScores,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecoveryScoresFilterComposer(
            $db: $db,
            $table: $db.recoveryScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> milestonesRefs(
    Expression<bool> Function($MilestonesFilterComposer f) f,
  ) {
    final $MilestonesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.milestones,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MilestonesFilterComposer(
            $db: $db,
            $table: $db.milestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> yogaRoutinesRefs(
    Expression<bool> Function($YogaRoutinesFilterComposer f) f,
  ) {
    final $YogaRoutinesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.yogaRoutines,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $YogaRoutinesFilterComposer(
            $db: $db,
            $table: $db.yogaRoutines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> medicationLogsRefs(
    Expression<bool> Function($MedicationLogsFilterComposer f) f,
  ) {
    final $MedicationLogsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medicationLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MedicationLogsFilterComposer(
            $db: $db,
            $table: $db.medicationLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fallEventsRefs(
    Expression<bool> Function($FallEventsFilterComposer f) f,
  ) {
    final $FallEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fallEvents,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FallEventsFilterComposer(
            $db: $db,
            $table: $db.fallEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deviceInfosRefs(
    Expression<bool> Function($DeviceInfosFilterComposer f) f,
  ) {
    final $DeviceInfosFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceInfos,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DeviceInfosFilterComposer(
            $db: $db,
            $table: $db.deviceInfos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $UsersOrderingComposer extends Composer<_$CareDatabase, Users> {
  $UsersOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get firstSlot => $composableBuilder(
    column: $table.firstSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get secondSlot => $composableBuilder(
    column: $table.secondSlot,
    builder: (column) => ColumnOrderings(column),
  );
}

class $UsersAnnotationComposer extends Composer<_$CareDatabase, Users> {
  $UsersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<int> get firstSlot =>
      $composableBuilder(column: $table.firstSlot, builder: (column) => column);

  GeneratedColumn<int> get secondSlot => $composableBuilder(
    column: $table.secondSlot,
    builder: (column) => column,
  );

  Expression<T> emergencyContactsRefs<T extends Object>(
    Expression<T> Function($EmergencyContactsAnnotationComposer a) f,
  ) {
    final $EmergencyContactsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emergencyContacts,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $EmergencyContactsAnnotationComposer(
            $db: $db,
            $table: $db.emergencyContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> injuryProfilesRefs<T extends Object>(
    Expression<T> Function($InjuryProfilesAnnotationComposer a) f,
  ) {
    final $InjuryProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injuryProfiles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InjuryProfilesAnnotationComposer(
            $db: $db,
            $table: $db.injuryProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> walkSessionsRefs<T extends Object>(
    Expression<T> Function($WalkSessionsAnnotationComposer a) f,
  ) {
    final $WalkSessionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walkSessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WalkSessionsAnnotationComposer(
            $db: $db,
            $table: $db.walkSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyMetricsRefs<T extends Object>(
    Expression<T> Function($DailyMetricsAnnotationComposer a) f,
  ) {
    final $DailyMetricsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyMetrics,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DailyMetricsAnnotationComposer(
            $db: $db,
            $table: $db.dailyMetrics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recoveryScoresRefs<T extends Object>(
    Expression<T> Function($RecoveryScoresAnnotationComposer a) f,
  ) {
    final $RecoveryScoresAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recoveryScores,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecoveryScoresAnnotationComposer(
            $db: $db,
            $table: $db.recoveryScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> milestonesRefs<T extends Object>(
    Expression<T> Function($MilestonesAnnotationComposer a) f,
  ) {
    final $MilestonesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.milestones,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MilestonesAnnotationComposer(
            $db: $db,
            $table: $db.milestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> yogaRoutinesRefs<T extends Object>(
    Expression<T> Function($YogaRoutinesAnnotationComposer a) f,
  ) {
    final $YogaRoutinesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.yogaRoutines,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $YogaRoutinesAnnotationComposer(
            $db: $db,
            $table: $db.yogaRoutines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> medicationLogsRefs<T extends Object>(
    Expression<T> Function($MedicationLogsAnnotationComposer a) f,
  ) {
    final $MedicationLogsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medicationLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MedicationLogsAnnotationComposer(
            $db: $db,
            $table: $db.medicationLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fallEventsRefs<T extends Object>(
    Expression<T> Function($FallEventsAnnotationComposer a) f,
  ) {
    final $FallEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fallEvents,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FallEventsAnnotationComposer(
            $db: $db,
            $table: $db.fallEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> deviceInfosRefs<T extends Object>(
    Expression<T> Function($DeviceInfosAnnotationComposer a) f,
  ) {
    final $DeviceInfosAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceInfos,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DeviceInfosAnnotationComposer(
            $db: $db,
            $table: $db.deviceInfos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $UsersTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          Users,
          User,
          $UsersFilterComposer,
          $UsersOrderingComposer,
          $UsersAnnotationComposer,
          $UsersCreateCompanionBuilder,
          $UsersUpdateCompanionBuilder,
          (User, $UsersReferences),
          User,
          PrefetchHooks Function({
            bool emergencyContactsRefs,
            bool injuryProfilesRefs,
            bool walkSessionsRefs,
            bool dailyMetricsRefs,
            bool recoveryScoresRefs,
            bool milestonesRefs,
            bool yogaRoutinesRefs,
            bool medicationLogsRefs,
            bool fallEventsRefs,
            bool deviceInfosRefs,
          })
        > {
  $UsersTableManager(_$CareDatabase db, Users table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $UsersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $UsersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $UsersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<int> firstSlot = const Value.absent(),
                Value<int> secondSlot = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                heightCm: heightCm,
                age: age,
                locale: locale,
                firstSlot: firstSlot,
                secondSlot: secondSlot,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double heightCm,
                required int age,
                required String locale,
                Value<int> firstSlot = const Value.absent(),
                Value<int> secondSlot = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                heightCm: heightCm,
                age: age,
                locale: locale,
                firstSlot: firstSlot,
                secondSlot: secondSlot,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Users, User>(table),
                  $UsersReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                emergencyContactsRefs = false,
                injuryProfilesRefs = false,
                walkSessionsRefs = false,
                dailyMetricsRefs = false,
                recoveryScoresRefs = false,
                milestonesRefs = false,
                yogaRoutinesRefs = false,
                medicationLogsRefs = false,
                fallEventsRefs = false,
                deviceInfosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (emergencyContactsRefs) db.emergencyContacts,
                    if (injuryProfilesRefs) db.injuryProfiles,
                    if (walkSessionsRefs) db.walkSessions,
                    if (dailyMetricsRefs) db.dailyMetrics,
                    if (recoveryScoresRefs) db.recoveryScores,
                    if (milestonesRefs) db.milestones,
                    if (yogaRoutinesRefs) db.yogaRoutines,
                    if (medicationLogsRefs) db.medicationLogs,
                    if (fallEventsRefs) db.fallEvents,
                    if (deviceInfosRefs) db.deviceInfos,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (emergencyContactsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          EmergencyContact,
                          EmergencyContacts
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._emergencyContactsRefsTable(db),
                          managerFromTypedResult: (p0) => $UsersReferences(
                            db,
                            table,
                            p0,
                          ).emergencyContactsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (injuryProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          InjuryProfile,
                          InjuryProfiles
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._injuryProfilesRefsTable(db),
                          managerFromTypedResult: (p0) => $UsersReferences(
                            db,
                            table,
                            p0,
                          ).injuryProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (walkSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          WalkSession,
                          WalkSessions
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._walkSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).walkSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (dailyMetricsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          DailyMetric,
                          DailyMetrics
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._dailyMetricsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).dailyMetricsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (recoveryScoresRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          RecoveryScore,
                          RecoveryScores
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._recoveryScoresRefsTable(db),
                          managerFromTypedResult: (p0) => $UsersReferences(
                            db,
                            table,
                            p0,
                          ).recoveryScoresRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (milestonesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          Milestone,
                          Milestones
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._milestonesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).milestonesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (yogaRoutinesRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          YogaRoutine,
                          YogaRoutines
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._yogaRoutinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).yogaRoutinesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (medicationLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          MedicationLog,
                          MedicationLogs
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._medicationLogsRefsTable(db),
                          managerFromTypedResult: (p0) => $UsersReferences(
                            db,
                            table,
                            p0,
                          ).medicationLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (fallEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          FallEvent,
                          FallEvents
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._fallEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).fallEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (deviceInfosRefs)
                        await $_getPrefetchedDataByColumns<
                          User,
                          Users,
                          DeviceInfo,
                          DeviceInfos
                        >(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._deviceInfosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).deviceInfosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $UsersProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      Users,
      User,
      $UsersFilterComposer,
      $UsersOrderingComposer,
      $UsersAnnotationComposer,
      $UsersCreateCompanionBuilder,
      $UsersUpdateCompanionBuilder,
      (User, $UsersReferences),
      User,
      PrefetchHooks Function({
        bool emergencyContactsRefs,
        bool injuryProfilesRefs,
        bool walkSessionsRefs,
        bool dailyMetricsRefs,
        bool recoveryScoresRefs,
        bool milestonesRefs,
        bool yogaRoutinesRefs,
        bool medicationLogsRefs,
        bool fallEventsRefs,
        bool deviceInfosRefs,
      })
    >;
typedef $InjuryProfilesCreateCompanionBuilder =
    InjuryProfilesCompanion Function({
      Value<int> userId,
      required String injuryType,
      Value<String?> surgeryDate,
      required String affectedSide,
    });
typedef $InjuryProfilesUpdateCompanionBuilder =
    InjuryProfilesCompanion Function({
      Value<int> userId,
      Value<String> injuryType,
      Value<String?> surgeryDate,
      Value<String> affectedSide,
    });

final class $InjuryProfilesReferences
    extends BaseReferences<_$CareDatabase, InjuryProfiles, InjuryProfile> {
  $InjuryProfilesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('injury_profiles__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $InjuryProfilesFilterComposer
    extends Composer<_$CareDatabase, InjuryProfiles> {
  $InjuryProfilesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get injuryType => $composableBuilder(
    column: $table.injuryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surgeryDate => $composableBuilder(
    column: $table.surgeryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get affectedSide => $composableBuilder(
    column: $table.affectedSide,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InjuryProfilesOrderingComposer
    extends Composer<_$CareDatabase, InjuryProfiles> {
  $InjuryProfilesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get injuryType => $composableBuilder(
    column: $table.injuryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surgeryDate => $composableBuilder(
    column: $table.surgeryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get affectedSide => $composableBuilder(
    column: $table.affectedSide,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InjuryProfilesAnnotationComposer
    extends Composer<_$CareDatabase, InjuryProfiles> {
  $InjuryProfilesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get injuryType => $composableBuilder(
    column: $table.injuryType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get surgeryDate => $composableBuilder(
    column: $table.surgeryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get affectedSide => $composableBuilder(
    column: $table.affectedSide,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InjuryProfilesTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          InjuryProfiles,
          InjuryProfile,
          $InjuryProfilesFilterComposer,
          $InjuryProfilesOrderingComposer,
          $InjuryProfilesAnnotationComposer,
          $InjuryProfilesCreateCompanionBuilder,
          $InjuryProfilesUpdateCompanionBuilder,
          (InjuryProfile, $InjuryProfilesReferences),
          InjuryProfile,
          PrefetchHooks Function({bool userId})
        > {
  $InjuryProfilesTableManager(_$CareDatabase db, InjuryProfiles table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InjuryProfilesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InjuryProfilesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $InjuryProfilesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> injuryType = const Value.absent(),
                Value<String?> surgeryDate = const Value.absent(),
                Value<String> affectedSide = const Value.absent(),
              }) => InjuryProfilesCompanion(
                userId: userId,
                injuryType: injuryType,
                surgeryDate: surgeryDate,
                affectedSide: affectedSide,
              ),
          createCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                required String injuryType,
                Value<String?> surgeryDate = const Value.absent(),
                required String affectedSide,
              }) => InjuryProfilesCompanion.insert(
                userId: userId,
                injuryType: injuryType,
                surgeryDate: surgeryDate,
                affectedSide: affectedSide,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<InjuryProfiles, InjuryProfile>(table),
                  $InjuryProfilesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $InjuryProfilesReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $InjuryProfilesReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $InjuryProfilesProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      InjuryProfiles,
      InjuryProfile,
      $InjuryProfilesFilterComposer,
      $InjuryProfilesOrderingComposer,
      $InjuryProfilesAnnotationComposer,
      $InjuryProfilesCreateCompanionBuilder,
      $InjuryProfilesUpdateCompanionBuilder,
      (InjuryProfile, $InjuryProfilesReferences),
      InjuryProfile,
      PrefetchHooks Function({bool userId})
    >;
typedef $WalkSessionsCreateCompanionBuilder = WalkSessionsCompanion Function({
  required String id,
  required int userId,
  required DateTime startedAt,
  required DateTime endedAt,
  required int steps,
  required double avgLoad,
  required double peakLoad,
  required double avgSpeed,
  required double peakSpeed,
  required double cadence,
  required double strideLengthM,
  required double distanceM,
  required double gaitRegularity,
  Value<int> rowid,
});
typedef $WalkSessionsUpdateCompanionBuilder = WalkSessionsCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<DateTime> startedAt,
  Value<DateTime> endedAt,
  Value<int> steps,
  Value<double> avgLoad,
  Value<double> peakLoad,
  Value<double> avgSpeed,
  Value<double> peakSpeed,
  Value<double> cadence,
  Value<double> strideLengthM,
  Value<double> distanceM,
  Value<double> gaitRegularity,
  Value<int> rowid,
});

final class $WalkSessionsReferences
    extends BaseReferences<_$CareDatabase, WalkSessions, WalkSession> {
  $WalkSessionsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('walk_sessions__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $WalkSessionsFilterComposer
    extends Composer<_$CareDatabase, WalkSessions> {
  $WalkSessionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgLoad => $composableBuilder(
    column: $table.avgLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peakLoad => $composableBuilder(
    column: $table.peakLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeed => $composableBuilder(
    column: $table.avgSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peakSpeed => $composableBuilder(
    column: $table.peakSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $WalkSessionsOrderingComposer
    extends Composer<_$CareDatabase, WalkSessions> {
  $WalkSessionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgLoad => $composableBuilder(
    column: $table.avgLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peakLoad => $composableBuilder(
    column: $table.peakLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeed => $composableBuilder(
    column: $table.avgSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peakSpeed => $composableBuilder(
    column: $table.peakSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $WalkSessionsAnnotationComposer
    extends Composer<_$CareDatabase, WalkSessions> {
  $WalkSessionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get avgLoad =>
      $composableBuilder(column: $table.avgLoad, builder: (column) => column);

  GeneratedColumn<double> get peakLoad =>
      $composableBuilder(column: $table.peakLoad, builder: (column) => column);

  GeneratedColumn<double> get avgSpeed =>
      $composableBuilder(column: $table.avgSpeed, builder: (column) => column);

  GeneratedColumn<double> get peakSpeed =>
      $composableBuilder(column: $table.peakSpeed, builder: (column) => column);

  GeneratedColumn<double> get cadence =>
      $composableBuilder(column: $table.cadence, builder: (column) => column);

  GeneratedColumn<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $WalkSessionsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          WalkSessions,
          WalkSession,
          $WalkSessionsFilterComposer,
          $WalkSessionsOrderingComposer,
          $WalkSessionsAnnotationComposer,
          $WalkSessionsCreateCompanionBuilder,
          $WalkSessionsUpdateCompanionBuilder,
          (WalkSession, $WalkSessionsReferences),
          WalkSession,
          PrefetchHooks Function({bool userId})
        > {
  $WalkSessionsTableManager(_$CareDatabase db, WalkSessions table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $WalkSessionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $WalkSessionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $WalkSessionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<double> avgLoad = const Value.absent(),
                Value<double> peakLoad = const Value.absent(),
                Value<double> avgSpeed = const Value.absent(),
                Value<double> peakSpeed = const Value.absent(),
                Value<double> cadence = const Value.absent(),
                Value<double> strideLengthM = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<double> gaitRegularity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkSessionsCompanion(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                steps: steps,
                avgLoad: avgLoad,
                peakLoad: peakLoad,
                avgSpeed: avgSpeed,
                peakSpeed: peakSpeed,
                cadence: cadence,
                strideLengthM: strideLengthM,
                distanceM: distanceM,
                gaitRegularity: gaitRegularity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int userId,
                required DateTime startedAt,
                required DateTime endedAt,
                required int steps,
                required double avgLoad,
                required double peakLoad,
                required double avgSpeed,
                required double peakSpeed,
                required double cadence,
                required double strideLengthM,
                required double distanceM,
                required double gaitRegularity,
                Value<int> rowid = const Value.absent(),
              }) => WalkSessionsCompanion.insert(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                steps: steps,
                avgLoad: avgLoad,
                peakLoad: peakLoad,
                avgSpeed: avgSpeed,
                peakSpeed: peakSpeed,
                cadence: cadence,
                strideLengthM: strideLengthM,
                distanceM: distanceM,
                gaitRegularity: gaitRegularity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<WalkSessions, WalkSession>(table),
                  $WalkSessionsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $WalkSessionsReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $WalkSessionsReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $WalkSessionsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      WalkSessions,
      WalkSession,
      $WalkSessionsFilterComposer,
      $WalkSessionsOrderingComposer,
      $WalkSessionsAnnotationComposer,
      $WalkSessionsCreateCompanionBuilder,
      $WalkSessionsUpdateCompanionBuilder,
      (WalkSession, $WalkSessionsReferences),
      WalkSession,
      PrefetchHooks Function({bool userId})
    >;
typedef $DailyMetricsCreateCompanionBuilder = DailyMetricsCompanion Function({
  required int userId,
  required String day,
  required int steps,
  required double walkMinutes,
  required double avgLoad,
  required double peakLoad,
  required double avgSpeed,
  required double peakSpeed,
  required double cadence,
  required double strideLengthM,
  required double distanceM,
  required double gaitRegularity,
  Value<int> rowid,
});
typedef $DailyMetricsUpdateCompanionBuilder = DailyMetricsCompanion Function({
  Value<int> userId,
  Value<String> day,
  Value<int> steps,
  Value<double> walkMinutes,
  Value<double> avgLoad,
  Value<double> peakLoad,
  Value<double> avgSpeed,
  Value<double> peakSpeed,
  Value<double> cadence,
  Value<double> strideLengthM,
  Value<double> distanceM,
  Value<double> gaitRegularity,
  Value<int> rowid,
});

final class $DailyMetricsReferences
    extends BaseReferences<_$CareDatabase, DailyMetrics, DailyMetric> {
  $DailyMetricsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('daily_metrics__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $DailyMetricsFilterComposer
    extends Composer<_$CareDatabase, DailyMetrics> {
  $DailyMetricsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get walkMinutes => $composableBuilder(
    column: $table.walkMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgLoad => $composableBuilder(
    column: $table.avgLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peakLoad => $composableBuilder(
    column: $table.peakLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeed => $composableBuilder(
    column: $table.avgSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peakSpeed => $composableBuilder(
    column: $table.peakSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DailyMetricsOrderingComposer
    extends Composer<_$CareDatabase, DailyMetrics> {
  $DailyMetricsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get walkMinutes => $composableBuilder(
    column: $table.walkMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgLoad => $composableBuilder(
    column: $table.avgLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peakLoad => $composableBuilder(
    column: $table.peakLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeed => $composableBuilder(
    column: $table.avgSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peakSpeed => $composableBuilder(
    column: $table.peakSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DailyMetricsAnnotationComposer
    extends Composer<_$CareDatabase, DailyMetrics> {
  $DailyMetricsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get walkMinutes => $composableBuilder(
    column: $table.walkMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgLoad =>
      $composableBuilder(column: $table.avgLoad, builder: (column) => column);

  GeneratedColumn<double> get peakLoad =>
      $composableBuilder(column: $table.peakLoad, builder: (column) => column);

  GeneratedColumn<double> get avgSpeed =>
      $composableBuilder(column: $table.avgSpeed, builder: (column) => column);

  GeneratedColumn<double> get peakSpeed =>
      $composableBuilder(column: $table.peakSpeed, builder: (column) => column);

  GeneratedColumn<double> get cadence =>
      $composableBuilder(column: $table.cadence, builder: (column) => column);

  GeneratedColumn<double> get strideLengthM => $composableBuilder(
    column: $table.strideLengthM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get gaitRegularity => $composableBuilder(
    column: $table.gaitRegularity,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DailyMetricsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          DailyMetrics,
          DailyMetric,
          $DailyMetricsFilterComposer,
          $DailyMetricsOrderingComposer,
          $DailyMetricsAnnotationComposer,
          $DailyMetricsCreateCompanionBuilder,
          $DailyMetricsUpdateCompanionBuilder,
          (DailyMetric, $DailyMetricsReferences),
          DailyMetric,
          PrefetchHooks Function({bool userId})
        > {
  $DailyMetricsTableManager(_$CareDatabase db, DailyMetrics table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DailyMetricsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DailyMetricsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DailyMetricsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<double> walkMinutes = const Value.absent(),
                Value<double> avgLoad = const Value.absent(),
                Value<double> peakLoad = const Value.absent(),
                Value<double> avgSpeed = const Value.absent(),
                Value<double> peakSpeed = const Value.absent(),
                Value<double> cadence = const Value.absent(),
                Value<double> strideLengthM = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<double> gaitRegularity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyMetricsCompanion(
                userId: userId,
                day: day,
                steps: steps,
                walkMinutes: walkMinutes,
                avgLoad: avgLoad,
                peakLoad: peakLoad,
                avgSpeed: avgSpeed,
                peakSpeed: peakSpeed,
                cadence: cadence,
                strideLengthM: strideLengthM,
                distanceM: distanceM,
                gaitRegularity: gaitRegularity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required String day,
                required int steps,
                required double walkMinutes,
                required double avgLoad,
                required double peakLoad,
                required double avgSpeed,
                required double peakSpeed,
                required double cadence,
                required double strideLengthM,
                required double distanceM,
                required double gaitRegularity,
                Value<int> rowid = const Value.absent(),
              }) => DailyMetricsCompanion.insert(
                userId: userId,
                day: day,
                steps: steps,
                walkMinutes: walkMinutes,
                avgLoad: avgLoad,
                peakLoad: peakLoad,
                avgSpeed: avgSpeed,
                peakSpeed: peakSpeed,
                cadence: cadence,
                strideLengthM: strideLengthM,
                distanceM: distanceM,
                gaitRegularity: gaitRegularity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<DailyMetrics, DailyMetric>(table),
                  $DailyMetricsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $DailyMetricsReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $DailyMetricsReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $DailyMetricsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      DailyMetrics,
      DailyMetric,
      $DailyMetricsFilterComposer,
      $DailyMetricsOrderingComposer,
      $DailyMetricsAnnotationComposer,
      $DailyMetricsCreateCompanionBuilder,
      $DailyMetricsUpdateCompanionBuilder,
      (DailyMetric, $DailyMetricsReferences),
      DailyMetric,
      PrefetchHooks Function({bool userId})
    >;
typedef $RecoveryScoresCreateCompanionBuilder =
    RecoveryScoresCompanion Function({
      required int userId,
      required String day,
      required int score,
      Value<int> rowid,
    });
typedef $RecoveryScoresUpdateCompanionBuilder =
    RecoveryScoresCompanion Function({
      Value<int> userId,
      Value<String> day,
      Value<int> score,
      Value<int> rowid,
    });

final class $RecoveryScoresReferences
    extends BaseReferences<_$CareDatabase, RecoveryScores, RecoveryScore> {
  $RecoveryScoresReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('recovery_scores__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $RecoveryScoresFilterComposer
    extends Composer<_$CareDatabase, RecoveryScores> {
  $RecoveryScoresFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecoveryScoresOrderingComposer
    extends Composer<_$CareDatabase, RecoveryScores> {
  $RecoveryScoresOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecoveryScoresAnnotationComposer
    extends Composer<_$CareDatabase, RecoveryScores> {
  $RecoveryScoresAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecoveryScoresTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          RecoveryScores,
          RecoveryScore,
          $RecoveryScoresFilterComposer,
          $RecoveryScoresOrderingComposer,
          $RecoveryScoresAnnotationComposer,
          $RecoveryScoresCreateCompanionBuilder,
          $RecoveryScoresUpdateCompanionBuilder,
          (RecoveryScore, $RecoveryScoresReferences),
          RecoveryScore,
          PrefetchHooks Function({bool userId})
        > {
  $RecoveryScoresTableManager(_$CareDatabase db, RecoveryScores table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RecoveryScoresFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RecoveryScoresOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RecoveryScoresAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryScoresCompanion(
                userId: userId,
                day: day,
                score: score,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required String day,
                required int score,
                Value<int> rowid = const Value.absent(),
              }) => RecoveryScoresCompanion.insert(
                userId: userId,
                day: day,
                score: score,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<RecoveryScores, RecoveryScore>(table),
                  $RecoveryScoresReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $RecoveryScoresReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $RecoveryScoresReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $RecoveryScoresProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      RecoveryScores,
      RecoveryScore,
      $RecoveryScoresFilterComposer,
      $RecoveryScoresOrderingComposer,
      $RecoveryScoresAnnotationComposer,
      $RecoveryScoresCreateCompanionBuilder,
      $RecoveryScoresUpdateCompanionBuilder,
      (RecoveryScore, $RecoveryScoresReferences),
      RecoveryScore,
      PrefetchHooks Function({bool userId})
    >;
typedef $MilestonesCreateCompanionBuilder = MilestonesCompanion Function({
  required int userId,
  required String milestoneKey,
  required DateTime achievedAt,
  Value<int> rowid,
});
typedef $MilestonesUpdateCompanionBuilder = MilestonesCompanion Function({
  Value<int> userId,
  Value<String> milestoneKey,
  Value<DateTime> achievedAt,
  Value<int> rowid,
});

final class $MilestonesReferences
    extends BaseReferences<_$CareDatabase, Milestones, Milestone> {
  $MilestonesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('milestones__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $MilestonesFilterComposer extends Composer<_$CareDatabase, Milestones> {
  $MilestonesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get milestoneKey => $composableBuilder(
    column: $table.milestoneKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MilestonesOrderingComposer extends Composer<_$CareDatabase, Milestones> {
  $MilestonesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get milestoneKey => $composableBuilder(
    column: $table.milestoneKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MilestonesAnnotationComposer
    extends Composer<_$CareDatabase, Milestones> {
  $MilestonesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get milestoneKey => $composableBuilder(
    column: $table.milestoneKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MilestonesTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          Milestones,
          Milestone,
          $MilestonesFilterComposer,
          $MilestonesOrderingComposer,
          $MilestonesAnnotationComposer,
          $MilestonesCreateCompanionBuilder,
          $MilestonesUpdateCompanionBuilder,
          (Milestone, $MilestonesReferences),
          Milestone,
          PrefetchHooks Function({bool userId})
        > {
  $MilestonesTableManager(_$CareDatabase db, Milestones table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $MilestonesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $MilestonesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $MilestonesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> milestoneKey = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MilestonesCompanion(
                userId: userId,
                milestoneKey: milestoneKey,
                achievedAt: achievedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required String milestoneKey,
                required DateTime achievedAt,
                Value<int> rowid = const Value.absent(),
              }) => MilestonesCompanion.insert(
                userId: userId,
                milestoneKey: milestoneKey,
                achievedAt: achievedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Milestones, Milestone>(table),
                  $MilestonesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $MilestonesReferences._userIdTable(db),
                        referencedColumn: $MilestonesReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $MilestonesProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      Milestones,
      Milestone,
      $MilestonesFilterComposer,
      $MilestonesOrderingComposer,
      $MilestonesAnnotationComposer,
      $MilestonesCreateCompanionBuilder,
      $MilestonesUpdateCompanionBuilder,
      (Milestone, $MilestonesReferences),
      Milestone,
      PrefetchHooks Function({bool userId})
    >;
typedef $FoodItemsCreateCompanionBuilder = FoodItemsCompanion Function({
  required String id,
  required String nameKey,
  required String stage,
  required bool vegetarian,
  required String nutrientTags,
  Value<int> rowid,
});
typedef $FoodItemsUpdateCompanionBuilder = FoodItemsCompanion Function({
  Value<String> id,
  Value<String> nameKey,
  Value<String> stage,
  Value<bool> vegetarian,
  Value<String> nutrientTags,
  Value<int> rowid,
});

final class $FoodItemsReferences
    extends BaseReferences<_$CareDatabase, FoodItems, FoodItem> {
  $FoodItemsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Recipes, List<Recipe>> _recipesRefsTable(
    _$CareDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.recipes,
    aliasName: 'food_items__id__recipes__food_item_id',
  );

  $RecipesProcessedTableManager get recipesRefs {
    final manager = $RecipesTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.foodItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $FoodItemsFilterComposer extends Composer<_$CareDatabase, FoodItems> {
  $FoodItemsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vegetarian => $composableBuilder(
    column: $table.vegetarian,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutrientTags => $composableBuilder(
    column: $table.nutrientTags,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipesRefs(
    Expression<bool> Function($RecipesFilterComposer f) f,
  ) {
    final $RecipesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.foodItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecipesFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $FoodItemsOrderingComposer extends Composer<_$CareDatabase, FoodItems> {
  $FoodItemsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vegetarian => $composableBuilder(
    column: $table.vegetarian,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutrientTags => $composableBuilder(
    column: $table.nutrientTags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $FoodItemsAnnotationComposer extends Composer<_$CareDatabase, FoodItems> {
  $FoodItemsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameKey =>
      $composableBuilder(column: $table.nameKey, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<bool> get vegetarian => $composableBuilder(
    column: $table.vegetarian,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nutrientTags => $composableBuilder(
    column: $table.nutrientTags,
    builder: (column) => column,
  );

  Expression<T> recipesRefs<T extends Object>(
    Expression<T> Function($RecipesAnnotationComposer a) f,
  ) {
    final $RecipesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.foodItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecipesAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $FoodItemsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          FoodItems,
          FoodItem,
          $FoodItemsFilterComposer,
          $FoodItemsOrderingComposer,
          $FoodItemsAnnotationComposer,
          $FoodItemsCreateCompanionBuilder,
          $FoodItemsUpdateCompanionBuilder,
          (FoodItem, $FoodItemsReferences),
          FoodItem,
          PrefetchHooks Function({bool recipesRefs})
        > {
  $FoodItemsTableManager(_$CareDatabase db, FoodItems table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $FoodItemsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $FoodItemsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $FoodItemsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameKey = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<bool> vegetarian = const Value.absent(),
                Value<String> nutrientTags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                nameKey: nameKey,
                stage: stage,
                vegetarian: vegetarian,
                nutrientTags: nutrientTags,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameKey,
                required String stage,
                required bool vegetarian,
                required String nutrientTags,
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                nameKey: nameKey,
                stage: stage,
                vegetarian: vegetarian,
                nutrientTags: nutrientTags,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<FoodItems, FoodItem>(table),
                  $FoodItemsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (recipesRefs) db.recipes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recipesRefs)
                    await $_getPrefetchedDataByColumns<
                      FoodItem,
                      FoodItems,
                      Recipe,
                      Recipes
                    >(
                      currentTable: table,
                      referencedTable: $FoodItemsReferences._recipesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $FoodItemsReferences(db, table, p0).recipesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'food_item_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $FoodItemsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      FoodItems,
      FoodItem,
      $FoodItemsFilterComposer,
      $FoodItemsOrderingComposer,
      $FoodItemsAnnotationComposer,
      $FoodItemsCreateCompanionBuilder,
      $FoodItemsUpdateCompanionBuilder,
      (FoodItem, $FoodItemsReferences),
      FoodItem,
      PrefetchHooks Function({bool recipesRefs})
    >;
typedef $RecipesCreateCompanionBuilder = RecipesCompanion Function({
  required String id,
  required String foodItemId,
  required String titleKey,
  required String instructionsKey,
  Value<int> rowid,
});
typedef $RecipesUpdateCompanionBuilder = RecipesCompanion Function({
  Value<String> id,
  Value<String> foodItemId,
  Value<String> titleKey,
  Value<String> instructionsKey,
  Value<int> rowid,
});

final class $RecipesReferences
    extends BaseReferences<_$CareDatabase, Recipes, Recipe> {
  $RecipesReferences(super.$_db, super.$_table, super.$_typedResult);

  static FoodItems _foodItemIdTable(_$CareDatabase db) =>
      db.foodItems.createAlias('recipes__food_item_id__food_items__id');

  $FoodItemsProcessedTableManager get foodItemId {
    final $_column = $_itemColumn<String>('food_item_id')!;

    final manager = $FoodItemsTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $RecipesFilterComposer extends Composer<_$CareDatabase, Recipes> {
  $RecipesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionsKey => $composableBuilder(
    column: $table.instructionsKey,
    builder: (column) => ColumnFilters(column),
  );

  $FoodItemsFilterComposer get foodItemId {
    final $FoodItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FoodItemsFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecipesOrderingComposer extends Composer<_$CareDatabase, Recipes> {
  $RecipesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionsKey => $composableBuilder(
    column: $table.instructionsKey,
    builder: (column) => ColumnOrderings(column),
  );

  $FoodItemsOrderingComposer get foodItemId {
    final $FoodItemsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FoodItemsOrderingComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecipesAnnotationComposer extends Composer<_$CareDatabase, Recipes> {
  $RecipesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleKey =>
      $composableBuilder(column: $table.titleKey, builder: (column) => column);

  GeneratedColumn<String> get instructionsKey => $composableBuilder(
    column: $table.instructionsKey,
    builder: (column) => column,
  );

  $FoodItemsAnnotationComposer get foodItemId {
    final $FoodItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FoodItemsAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecipesTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          Recipes,
          Recipe,
          $RecipesFilterComposer,
          $RecipesOrderingComposer,
          $RecipesAnnotationComposer,
          $RecipesCreateCompanionBuilder,
          $RecipesUpdateCompanionBuilder,
          (Recipe, $RecipesReferences),
          Recipe,
          PrefetchHooks Function({bool foodItemId})
        > {
  $RecipesTableManager(_$CareDatabase db, Recipes table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RecipesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RecipesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RecipesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodItemId = const Value.absent(),
                Value<String> titleKey = const Value.absent(),
                Value<String> instructionsKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                foodItemId: foodItemId,
                titleKey: titleKey,
                instructionsKey: instructionsKey,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodItemId,
                required String titleKey,
                required String instructionsKey,
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                foodItemId: foodItemId,
                titleKey: titleKey,
                instructionsKey: instructionsKey,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Recipes, Recipe>(table),
                  $RecipesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.foodItemId,
                        referencedTable: $RecipesReferences._foodItemIdTable(
                          db,
                        ),
                        referencedColumn: $RecipesReferences
                            ._foodItemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $RecipesProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      Recipes,
      Recipe,
      $RecipesFilterComposer,
      $RecipesOrderingComposer,
      $RecipesAnnotationComposer,
      $RecipesCreateCompanionBuilder,
      $RecipesUpdateCompanionBuilder,
      (Recipe, $RecipesReferences),
      Recipe,
      PrefetchHooks Function({bool foodItemId})
    >;
typedef $YogaRoutinesCreateCompanionBuilder = YogaRoutinesCompanion Function({
  required String id,
  required int userId,
  required String titleKey,
  required String stage,
  required String injuryTags,
  Value<bool> physioApproved,
  Value<int> rowid,
});
typedef $YogaRoutinesUpdateCompanionBuilder = YogaRoutinesCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<String> titleKey,
  Value<String> stage,
  Value<String> injuryTags,
  Value<bool> physioApproved,
  Value<int> rowid,
});

final class $YogaRoutinesReferences
    extends BaseReferences<_$CareDatabase, YogaRoutines, YogaRoutine> {
  $YogaRoutinesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('yoga_routines__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $YogaRoutinesFilterComposer
    extends Composer<_$CareDatabase, YogaRoutines> {
  $YogaRoutinesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get injuryTags => $composableBuilder(
    column: $table.injuryTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get physioApproved => $composableBuilder(
    column: $table.physioApproved,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $YogaRoutinesOrderingComposer
    extends Composer<_$CareDatabase, YogaRoutines> {
  $YogaRoutinesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get injuryTags => $composableBuilder(
    column: $table.injuryTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get physioApproved => $composableBuilder(
    column: $table.physioApproved,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $YogaRoutinesAnnotationComposer
    extends Composer<_$CareDatabase, YogaRoutines> {
  $YogaRoutinesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleKey =>
      $composableBuilder(column: $table.titleKey, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get injuryTags => $composableBuilder(
    column: $table.injuryTags,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get physioApproved => $composableBuilder(
    column: $table.physioApproved,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $YogaRoutinesTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          YogaRoutines,
          YogaRoutine,
          $YogaRoutinesFilterComposer,
          $YogaRoutinesOrderingComposer,
          $YogaRoutinesAnnotationComposer,
          $YogaRoutinesCreateCompanionBuilder,
          $YogaRoutinesUpdateCompanionBuilder,
          (YogaRoutine, $YogaRoutinesReferences),
          YogaRoutine,
          PrefetchHooks Function({bool userId})
        > {
  $YogaRoutinesTableManager(_$CareDatabase db, YogaRoutines table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $YogaRoutinesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $YogaRoutinesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $YogaRoutinesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> titleKey = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<String> injuryTags = const Value.absent(),
                Value<bool> physioApproved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => YogaRoutinesCompanion(
                id: id,
                userId: userId,
                titleKey: titleKey,
                stage: stage,
                injuryTags: injuryTags,
                physioApproved: physioApproved,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int userId,
                required String titleKey,
                required String stage,
                required String injuryTags,
                Value<bool> physioApproved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => YogaRoutinesCompanion.insert(
                id: id,
                userId: userId,
                titleKey: titleKey,
                stage: stage,
                injuryTags: injuryTags,
                physioApproved: physioApproved,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<YogaRoutines, YogaRoutine>(table),
                  $YogaRoutinesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $YogaRoutinesReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $YogaRoutinesReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $YogaRoutinesProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      YogaRoutines,
      YogaRoutine,
      $YogaRoutinesFilterComposer,
      $YogaRoutinesOrderingComposer,
      $YogaRoutinesAnnotationComposer,
      $YogaRoutinesCreateCompanionBuilder,
      $YogaRoutinesUpdateCompanionBuilder,
      (YogaRoutine, $YogaRoutinesReferences),
      YogaRoutine,
      PrefetchHooks Function({bool userId})
    >;
typedef $MedicationLogsCreateCompanionBuilder =
    MedicationLogsCompanion Function({
      required String id,
      required int userId,
      required String medicineName,
      required DateTime scheduledAt,
      Value<DateTime?> takenAt,
      Value<int> rowid,
    });
typedef $MedicationLogsUpdateCompanionBuilder =
    MedicationLogsCompanion Function({
      Value<String> id,
      Value<int> userId,
      Value<String> medicineName,
      Value<DateTime> scheduledAt,
      Value<DateTime?> takenAt,
      Value<int> rowid,
    });

final class $MedicationLogsReferences
    extends BaseReferences<_$CareDatabase, MedicationLogs, MedicationLog> {
  $MedicationLogsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('medication_logs__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $MedicationLogsFilterComposer
    extends Composer<_$CareDatabase, MedicationLogs> {
  $MedicationLogsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicineName => $composableBuilder(
    column: $table.medicineName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MedicationLogsOrderingComposer
    extends Composer<_$CareDatabase, MedicationLogs> {
  $MedicationLogsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicineName => $composableBuilder(
    column: $table.medicineName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MedicationLogsAnnotationComposer
    extends Composer<_$CareDatabase, MedicationLogs> {
  $MedicationLogsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName => $composableBuilder(
    column: $table.medicineName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $MedicationLogsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          MedicationLogs,
          MedicationLog,
          $MedicationLogsFilterComposer,
          $MedicationLogsOrderingComposer,
          $MedicationLogsAnnotationComposer,
          $MedicationLogsCreateCompanionBuilder,
          $MedicationLogsUpdateCompanionBuilder,
          (MedicationLog, $MedicationLogsReferences),
          MedicationLog,
          PrefetchHooks Function({bool userId})
        > {
  $MedicationLogsTableManager(_$CareDatabase db, MedicationLogs table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $MedicationLogsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $MedicationLogsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $MedicationLogsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> medicineName = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime?> takenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationLogsCompanion(
                id: id,
                userId: userId,
                medicineName: medicineName,
                scheduledAt: scheduledAt,
                takenAt: takenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int userId,
                required String medicineName,
                required DateTime scheduledAt,
                Value<DateTime?> takenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationLogsCompanion.insert(
                id: id,
                userId: userId,
                medicineName: medicineName,
                scheduledAt: scheduledAt,
                takenAt: takenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<MedicationLogs, MedicationLog>(table),
                  $MedicationLogsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $MedicationLogsReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $MedicationLogsReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $MedicationLogsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      MedicationLogs,
      MedicationLog,
      $MedicationLogsFilterComposer,
      $MedicationLogsOrderingComposer,
      $MedicationLogsAnnotationComposer,
      $MedicationLogsCreateCompanionBuilder,
      $MedicationLogsUpdateCompanionBuilder,
      (MedicationLog, $MedicationLogsReferences),
      MedicationLog,
      PrefetchHooks Function({bool userId})
    >;
typedef $FallEventsCreateCompanionBuilder = FallEventsCompanion Function({
  required String id,
  required int userId,
  required DateTime detectedAt,
  Value<DateTime?> acknowledgedAt,
  Value<DateTime?> firstNotifiedAt,
  Value<DateTime?> secondNotifiedAt,
  Value<int> rowid,
});
typedef $FallEventsUpdateCompanionBuilder = FallEventsCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<DateTime> detectedAt,
  Value<DateTime?> acknowledgedAt,
  Value<DateTime?> firstNotifiedAt,
  Value<DateTime?> secondNotifiedAt,
  Value<int> rowid,
});

final class $FallEventsReferences
    extends BaseReferences<_$CareDatabase, FallEvents, FallEvent> {
  $FallEventsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('fall_events__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $FallEventsFilterComposer extends Composer<_$CareDatabase, FallEvents> {
  $FallEventsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstNotifiedAt => $composableBuilder(
    column: $table.firstNotifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get secondNotifiedAt => $composableBuilder(
    column: $table.secondNotifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $FallEventsOrderingComposer extends Composer<_$CareDatabase, FallEvents> {
  $FallEventsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstNotifiedAt => $composableBuilder(
    column: $table.firstNotifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get secondNotifiedAt => $composableBuilder(
    column: $table.secondNotifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $FallEventsAnnotationComposer
    extends Composer<_$CareDatabase, FallEvents> {
  $FallEventsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstNotifiedAt => $composableBuilder(
    column: $table.firstNotifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get secondNotifiedAt => $composableBuilder(
    column: $table.secondNotifiedAt,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $FallEventsTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          FallEvents,
          FallEvent,
          $FallEventsFilterComposer,
          $FallEventsOrderingComposer,
          $FallEventsAnnotationComposer,
          $FallEventsCreateCompanionBuilder,
          $FallEventsUpdateCompanionBuilder,
          (FallEvent, $FallEventsReferences),
          FallEvent,
          PrefetchHooks Function({bool userId})
        > {
  $FallEventsTableManager(_$CareDatabase db, FallEvents table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $FallEventsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $FallEventsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $FallEventsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> detectedAt = const Value.absent(),
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> firstNotifiedAt = const Value.absent(),
                Value<DateTime?> secondNotifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FallEventsCompanion(
                id: id,
                userId: userId,
                detectedAt: detectedAt,
                acknowledgedAt: acknowledgedAt,
                firstNotifiedAt: firstNotifiedAt,
                secondNotifiedAt: secondNotifiedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int userId,
                required DateTime detectedAt,
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> firstNotifiedAt = const Value.absent(),
                Value<DateTime?> secondNotifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FallEventsCompanion.insert(
                id: id,
                userId: userId,
                detectedAt: detectedAt,
                acknowledgedAt: acknowledgedAt,
                firstNotifiedAt: firstNotifiedAt,
                secondNotifiedAt: secondNotifiedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<FallEvents, FallEvent>(table),
                  $FallEventsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $FallEventsReferences._userIdTable(db),
                        referencedColumn: $FallEventsReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $FallEventsProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      FallEvents,
      FallEvent,
      $FallEventsFilterComposer,
      $FallEventsOrderingComposer,
      $FallEventsAnnotationComposer,
      $FallEventsCreateCompanionBuilder,
      $FallEventsUpdateCompanionBuilder,
      (FallEvent, $FallEventsReferences),
      FallEvent,
      PrefetchHooks Function({bool userId})
    >;
typedef $DeviceInfosCreateCompanionBuilder = DeviceInfosCompanion Function({
  required String id,
  required int userId,
  Value<String?> firmware,
  Value<int?> batteryPercent,
  Value<DateTime?> lastSeenAt,
  Value<int> rowid,
});
typedef $DeviceInfosUpdateCompanionBuilder = DeviceInfosCompanion Function({
  Value<String> id,
  Value<int> userId,
  Value<String?> firmware,
  Value<int?> batteryPercent,
  Value<DateTime?> lastSeenAt,
  Value<int> rowid,
});

final class $DeviceInfosReferences
    extends BaseReferences<_$CareDatabase, DeviceInfos, DeviceInfo> {
  $DeviceInfosReferences(super.$_db, super.$_table, super.$_typedResult);

  static Users _userIdTable(_$CareDatabase db) =>
      db.users.createAlias('device_infos__user_id__users__id');

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $DeviceInfosFilterComposer extends Composer<_$CareDatabase, DeviceInfos> {
  $DeviceInfosFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firmware => $composableBuilder(
    column: $table.firmware,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryPercent => $composableBuilder(
    column: $table.batteryPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DeviceInfosOrderingComposer
    extends Composer<_$CareDatabase, DeviceInfos> {
  $DeviceInfosOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firmware => $composableBuilder(
    column: $table.firmware,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryPercent => $composableBuilder(
    column: $table.batteryPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DeviceInfosAnnotationComposer
    extends Composer<_$CareDatabase, DeviceInfos> {
  $DeviceInfosAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firmware =>
      $composableBuilder(column: $table.firmware, builder: (column) => column);

  GeneratedColumn<int> get batteryPercent => $composableBuilder(
    column: $table.batteryPercent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DeviceInfosTableManager
    extends
        RootTableManager<
          _$CareDatabase,
          DeviceInfos,
          DeviceInfo,
          $DeviceInfosFilterComposer,
          $DeviceInfosOrderingComposer,
          $DeviceInfosAnnotationComposer,
          $DeviceInfosCreateCompanionBuilder,
          $DeviceInfosUpdateCompanionBuilder,
          (DeviceInfo, $DeviceInfosReferences),
          DeviceInfo,
          PrefetchHooks Function({bool userId})
        > {
  $DeviceInfosTableManager(_$CareDatabase db, DeviceInfos table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DeviceInfosFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DeviceInfosOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DeviceInfosAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String?> firmware = const Value.absent(),
                Value<int?> batteryPercent = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceInfosCompanion(
                id: id,
                userId: userId,
                firmware: firmware,
                batteryPercent: batteryPercent,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int userId,
                Value<String?> firmware = const Value.absent(),
                Value<int?> batteryPercent = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceInfosCompanion.insert(
                id: id,
                userId: userId,
                firmware: firmware,
                batteryPercent: batteryPercent,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<DeviceInfos, DeviceInfo>(table),
                  $DeviceInfosReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $DeviceInfosReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $DeviceInfosReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $DeviceInfosProcessedTableManager =
    ProcessedTableManager<
      _$CareDatabase,
      DeviceInfos,
      DeviceInfo,
      $DeviceInfosFilterComposer,
      $DeviceInfosOrderingComposer,
      $DeviceInfosAnnotationComposer,
      $DeviceInfosCreateCompanionBuilder,
      $DeviceInfosUpdateCompanionBuilder,
      (DeviceInfo, $DeviceInfosReferences),
      DeviceInfo,
      PrefetchHooks Function({bool userId})
    >;

class $CareDatabaseManager {
  final _$CareDatabase _db;
  $CareDatabaseManager(this._db);
  $EmergencyContactsTableManager get emergencyContacts =>
      $EmergencyContactsTableManager(_db, _db.emergencyContacts);
  $UsersTableManager get users => $UsersTableManager(_db, _db.users);
  $InjuryProfilesTableManager get injuryProfiles =>
      $InjuryProfilesTableManager(_db, _db.injuryProfiles);
  $WalkSessionsTableManager get walkSessions =>
      $WalkSessionsTableManager(_db, _db.walkSessions);
  $DailyMetricsTableManager get dailyMetrics =>
      $DailyMetricsTableManager(_db, _db.dailyMetrics);
  $RecoveryScoresTableManager get recoveryScores =>
      $RecoveryScoresTableManager(_db, _db.recoveryScores);
  $MilestonesTableManager get milestones =>
      $MilestonesTableManager(_db, _db.milestones);
  $FoodItemsTableManager get foodItems =>
      $FoodItemsTableManager(_db, _db.foodItems);
  $RecipesTableManager get recipes => $RecipesTableManager(_db, _db.recipes);
  $YogaRoutinesTableManager get yogaRoutines =>
      $YogaRoutinesTableManager(_db, _db.yogaRoutines);
  $MedicationLogsTableManager get medicationLogs =>
      $MedicationLogsTableManager(_db, _db.medicationLogs);
  $FallEventsTableManager get fallEvents =>
      $FallEventsTableManager(_db, _db.fallEvents);
  $DeviceInfosTableManager get deviceInfos =>
      $DeviceInfosTableManager(_db, _db.deviceInfos);
}
