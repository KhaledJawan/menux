// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalProfilesTable extends LocalProfiles
    with TableInfo<$LocalProfilesTable, LocalProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    passwordHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProfile> instance, {
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
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalProfilesTable createAlias(String alias) {
    return $LocalProfilesTable(attachedDatabase, alias);
  }
}

class LocalProfile extends DataClass implements Insertable<LocalProfile> {
  final int id;
  final String name;
  final String email;
  final String passwordHash;
  final DateTime createdAt;
  const LocalProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalProfilesCompanion toCompanion(bool nullToAbsent) {
    return LocalProfilesCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      passwordHash: Value(passwordHash),
      createdAt: Value(createdAt),
    );
  }

  factory LocalProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalProfile copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    DateTime? createdAt,
  }) => LocalProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalProfile copyWithCompanion(LocalProfilesCompanion data) {
    return LocalProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, passwordHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.createdAt == this.createdAt);
}

class LocalProfilesCompanion extends UpdateCompanion<LocalProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<DateTime> createdAt;
  const LocalProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String passwordHash,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       email = Value(email),
       passwordHash = Value(passwordHash);
  static Insertable<LocalProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? passwordHash,
    Value<DateTime>? createdAt,
  }) {
    return LocalProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StaffTable extends Staff with TableInfo<$StaffTable, StaffMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<int> restaurantId = GeneratedColumn<int>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkedProfileIdMeta = const VerificationMeta(
    'linkedProfileId',
  );
  @override
  late final GeneratedColumn<int> linkedProfileId = GeneratedColumn<int>(
    'linked_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
    'pin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    linkedProfileId,
    name,
    phone,
    role,
    pin,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('linked_profile_id')) {
      context.handle(
        _linkedProfileIdMeta,
        linkedProfileId.isAcceptableOrUnknown(
          data['linked_profile_id']!,
          _linkedProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin')) {
      context.handle(
        _pinMeta,
        pin.isAcceptableOrUnknown(data['pin']!, _pinMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}restaurant_id'],
      )!,
      linkedProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}linked_profile_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StaffTable createAlias(String alias) {
    return $StaffTable(attachedDatabase, alias);
  }
}

class StaffMember extends DataClass implements Insertable<StaffMember> {
  final int id;
  final int restaurantId;
  final int? linkedProfileId;
  final String name;
  final String? phone;
  final String role;
  final String? pin;
  final bool isActive;
  final DateTime createdAt;
  const StaffMember({
    required this.id,
    required this.restaurantId,
    this.linkedProfileId,
    required this.name,
    this.phone,
    required this.role,
    this.pin,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['restaurant_id'] = Variable<int>(restaurantId);
    if (!nullToAbsent || linkedProfileId != null) {
      map['linked_profile_id'] = Variable<int>(linkedProfileId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || pin != null) {
      map['pin'] = Variable<String>(pin);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StaffCompanion toCompanion(bool nullToAbsent) {
    return StaffCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      linkedProfileId: linkedProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedProfileId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: Value(role),
      pin: pin == null && nullToAbsent ? const Value.absent() : Value(pin),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory StaffMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffMember(
      id: serializer.fromJson<int>(json['id']),
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      linkedProfileId: serializer.fromJson<int?>(json['linkedProfileId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      pin: serializer.fromJson<String?>(json['pin']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'restaurantId': serializer.toJson<int>(restaurantId),
      'linkedProfileId': serializer.toJson<int?>(linkedProfileId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String>(role),
      'pin': serializer.toJson<String?>(pin),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StaffMember copyWith({
    int? id,
    int? restaurantId,
    Value<int?> linkedProfileId = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    String? role,
    Value<String?> pin = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => StaffMember(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    linkedProfileId: linkedProfileId.present
        ? linkedProfileId.value
        : this.linkedProfileId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    role: role ?? this.role,
    pin: pin.present ? pin.value : this.pin,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  StaffMember copyWithCompanion(StaffCompanion data) {
    return StaffMember(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      linkedProfileId: data.linkedProfileId.present
          ? data.linkedProfileId.value
          : this.linkedProfileId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      pin: data.pin.present ? data.pin.value : this.pin,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffMember(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('linkedProfileId: $linkedProfileId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    restaurantId,
    linkedProfileId,
    name,
    phone,
    role,
    pin,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffMember &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.linkedProfileId == this.linkedProfileId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.pin == this.pin &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class StaffCompanion extends UpdateCompanion<StaffMember> {
  final Value<int> id;
  final Value<int> restaurantId;
  final Value<int?> linkedProfileId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String> role;
  final Value<String?> pin;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const StaffCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.linkedProfileId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.pin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StaffCompanion.insert({
    this.id = const Value.absent(),
    required int restaurantId,
    this.linkedProfileId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    required String role,
    this.pin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : restaurantId = Value(restaurantId),
       name = Value(name),
       role = Value(role);
  static Insertable<StaffMember> custom({
    Expression<int>? id,
    Expression<int>? restaurantId,
    Expression<int>? linkedProfileId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<String>? pin,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (linkedProfileId != null) 'linked_profile_id': linkedProfileId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (pin != null) 'pin': pin,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StaffCompanion copyWith({
    Value<int>? id,
    Value<int>? restaurantId,
    Value<int?>? linkedProfileId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String>? role,
    Value<String?>? pin,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return StaffCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      linkedProfileId: linkedProfileId ?? this.linkedProfileId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      pin: pin ?? this.pin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (linkedProfileId.present) {
      map['linked_profile_id'] = Variable<int>(linkedProfileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('linkedProfileId: $linkedProfileId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsEntriesTable extends AppSettingsEntries
    with TableInfo<$AppSettingsEntriesTable, AppSettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $AppSettingsEntriesTable createAlias(String alias) {
    return $AppSettingsEntriesTable(attachedDatabase, alias);
  }
}

class AppSettingsEntry extends DataClass
    implements Insertable<AppSettingsEntry> {
  final String key;
  final String? value;
  const AppSettingsEntry({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  AppSettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsEntriesCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory AppSettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  AppSettingsEntry copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => AppSettingsEntry(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  AppSettingsEntry copyWithCompanion(AppSettingsEntriesCompanion data) {
    return AppSettingsEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsEntriesCompanion extends UpdateCompanion<AppSettingsEntry> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const AppSettingsEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsEntriesCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AppSettingsEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsEntriesCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RestaurantsTable extends Restaurants
    with TableInfo<$RestaurantsTable, Restaurant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestaurantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _taxPercentMeta = const VerificationMeta(
    'taxPercent',
  );
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
    'tax_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _workingHoursOpenMeta = const VerificationMeta(
    'workingHoursOpen',
  );
  @override
  late final GeneratedColumn<String> workingHoursOpen = GeneratedColumn<String>(
    'working_hours_open',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workingHoursCloseMeta = const VerificationMeta(
    'workingHoursClose',
  );
  @override
  late final GeneratedColumn<String> workingHoursClose =
      GeneratedColumn<String>(
        'working_hours_close',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    currency,
    language,
    taxPercent,
    workingHoursOpen,
    workingHoursClose,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restaurants';
  @override
  VerificationContext validateIntegrity(
    Insertable<Restaurant> instance, {
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
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
        _taxPercentMeta,
        taxPercent.isAcceptableOrUnknown(data['tax_percent']!, _taxPercentMeta),
      );
    }
    if (data.containsKey('working_hours_open')) {
      context.handle(
        _workingHoursOpenMeta,
        workingHoursOpen.isAcceptableOrUnknown(
          data['working_hours_open']!,
          _workingHoursOpenMeta,
        ),
      );
    }
    if (data.containsKey('working_hours_close')) {
      context.handle(
        _workingHoursCloseMeta,
        workingHoursClose.isAcceptableOrUnknown(
          data['working_hours_close']!,
          _workingHoursCloseMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Restaurant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Restaurant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      taxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_percent'],
      )!,
      workingHoursOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_hours_open'],
      ),
      workingHoursClose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_hours_close'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RestaurantsTable createAlias(String alias) {
    return $RestaurantsTable(attachedDatabase, alias);
  }
}

class Restaurant extends DataClass implements Insertable<Restaurant> {
  final int id;
  final String name;
  final String? address;
  final String currency;
  final String language;
  final double taxPercent;
  final String? workingHoursOpen;
  final String? workingHoursClose;
  final DateTime createdAt;
  const Restaurant({
    required this.id,
    required this.name,
    this.address,
    required this.currency,
    required this.language,
    required this.taxPercent,
    this.workingHoursOpen,
    this.workingHoursClose,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['currency'] = Variable<String>(currency);
    map['language'] = Variable<String>(language);
    map['tax_percent'] = Variable<double>(taxPercent);
    if (!nullToAbsent || workingHoursOpen != null) {
      map['working_hours_open'] = Variable<String>(workingHoursOpen);
    }
    if (!nullToAbsent || workingHoursClose != null) {
      map['working_hours_close'] = Variable<String>(workingHoursClose);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RestaurantsCompanion toCompanion(bool nullToAbsent) {
    return RestaurantsCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      currency: Value(currency),
      language: Value(language),
      taxPercent: Value(taxPercent),
      workingHoursOpen: workingHoursOpen == null && nullToAbsent
          ? const Value.absent()
          : Value(workingHoursOpen),
      workingHoursClose: workingHoursClose == null && nullToAbsent
          ? const Value.absent()
          : Value(workingHoursClose),
      createdAt: Value(createdAt),
    );
  }

  factory Restaurant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Restaurant(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      currency: serializer.fromJson<String>(json['currency']),
      language: serializer.fromJson<String>(json['language']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      workingHoursOpen: serializer.fromJson<String?>(json['workingHoursOpen']),
      workingHoursClose: serializer.fromJson<String?>(
        json['workingHoursClose'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'currency': serializer.toJson<String>(currency),
      'language': serializer.toJson<String>(language),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'workingHoursOpen': serializer.toJson<String?>(workingHoursOpen),
      'workingHoursClose': serializer.toJson<String?>(workingHoursClose),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Restaurant copyWith({
    int? id,
    String? name,
    Value<String?> address = const Value.absent(),
    String? currency,
    String? language,
    double? taxPercent,
    Value<String?> workingHoursOpen = const Value.absent(),
    Value<String?> workingHoursClose = const Value.absent(),
    DateTime? createdAt,
  }) => Restaurant(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    currency: currency ?? this.currency,
    language: language ?? this.language,
    taxPercent: taxPercent ?? this.taxPercent,
    workingHoursOpen: workingHoursOpen.present
        ? workingHoursOpen.value
        : this.workingHoursOpen,
    workingHoursClose: workingHoursClose.present
        ? workingHoursClose.value
        : this.workingHoursClose,
    createdAt: createdAt ?? this.createdAt,
  );
  Restaurant copyWithCompanion(RestaurantsCompanion data) {
    return Restaurant(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      currency: data.currency.present ? data.currency.value : this.currency,
      language: data.language.present ? data.language.value : this.language,
      taxPercent: data.taxPercent.present
          ? data.taxPercent.value
          : this.taxPercent,
      workingHoursOpen: data.workingHoursOpen.present
          ? data.workingHoursOpen.value
          : this.workingHoursOpen,
      workingHoursClose: data.workingHoursClose.present
          ? data.workingHoursClose.value
          : this.workingHoursClose,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Restaurant(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('workingHoursOpen: $workingHoursOpen, ')
          ..write('workingHoursClose: $workingHoursClose, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    address,
    currency,
    language,
    taxPercent,
    workingHoursOpen,
    workingHoursClose,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Restaurant &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.currency == this.currency &&
          other.language == this.language &&
          other.taxPercent == this.taxPercent &&
          other.workingHoursOpen == this.workingHoursOpen &&
          other.workingHoursClose == this.workingHoursClose &&
          other.createdAt == this.createdAt);
}

class RestaurantsCompanion extends UpdateCompanion<Restaurant> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<String> currency;
  final Value<String> language;
  final Value<double> taxPercent;
  final Value<String?> workingHoursOpen;
  final Value<String?> workingHoursClose;
  final Value<DateTime> createdAt;
  const RestaurantsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.workingHoursOpen = const Value.absent(),
    this.workingHoursClose = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RestaurantsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.workingHoursOpen = const Value.absent(),
    this.workingHoursClose = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Restaurant> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? currency,
    Expression<String>? language,
    Expression<double>? taxPercent,
    Expression<String>? workingHoursOpen,
    Expression<String>? workingHoursClose,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (currency != null) 'currency': currency,
      if (language != null) 'language': language,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (workingHoursOpen != null) 'working_hours_open': workingHoursOpen,
      if (workingHoursClose != null) 'working_hours_close': workingHoursClose,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RestaurantsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<String>? currency,
    Value<String>? language,
    Value<double>? taxPercent,
    Value<String?>? workingHoursOpen,
    Value<String?>? workingHoursClose,
    Value<DateTime>? createdAt,
  }) {
    return RestaurantsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      taxPercent: taxPercent ?? this.taxPercent,
      workingHoursOpen: workingHoursOpen ?? this.workingHoursOpen,
      workingHoursClose: workingHoursClose ?? this.workingHoursClose,
      createdAt: createdAt ?? this.createdAt,
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
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (workingHoursOpen.present) {
      map['working_hours_open'] = Variable<String>(workingHoursOpen.value);
    }
    if (workingHoursClose.present) {
      map['working_hours_close'] = Variable<String>(workingHoursClose.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('workingHoursOpen: $workingHoursOpen, ')
          ..write('workingHoursClose: $workingHoursClose, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<int> restaurantId = GeneratedColumn<int>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workingHoursOpenMeta = const VerificationMeta(
    'workingHoursOpen',
  );
  @override
  late final GeneratedColumn<String> workingHoursOpen = GeneratedColumn<String>(
    'working_hours_open',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workingHoursCloseMeta = const VerificationMeta(
    'workingHoursClose',
  );
  @override
  late final GeneratedColumn<String> workingHoursClose =
      GeneratedColumn<String>(
        'working_hours_close',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    name,
    address,
    workingHoursOpen,
    workingHoursClose,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('working_hours_open')) {
      context.handle(
        _workingHoursOpenMeta,
        workingHoursOpen.isAcceptableOrUnknown(
          data['working_hours_open']!,
          _workingHoursOpenMeta,
        ),
      );
    }
    if (data.containsKey('working_hours_close')) {
      context.handle(
        _workingHoursCloseMeta,
        workingHoursClose.isAcceptableOrUnknown(
          data['working_hours_close']!,
          _workingHoursCloseMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}restaurant_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      workingHoursOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_hours_open'],
      ),
      workingHoursClose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_hours_close'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branch extends DataClass implements Insertable<Branch> {
  final int id;
  final int restaurantId;
  final String name;
  final String? address;
  final String? workingHoursOpen;
  final String? workingHoursClose;
  final bool isArchived;
  final DateTime createdAt;
  const Branch({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.address,
    this.workingHoursOpen,
    this.workingHoursClose,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['restaurant_id'] = Variable<int>(restaurantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || workingHoursOpen != null) {
      map['working_hours_open'] = Variable<String>(workingHoursOpen);
    }
    if (!nullToAbsent || workingHoursClose != null) {
      map['working_hours_close'] = Variable<String>(workingHoursClose);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      workingHoursOpen: workingHoursOpen == null && nullToAbsent
          ? const Value.absent()
          : Value(workingHoursOpen),
      workingHoursClose: workingHoursClose == null && nullToAbsent
          ? const Value.absent()
          : Value(workingHoursClose),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory Branch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branch(
      id: serializer.fromJson<int>(json['id']),
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      workingHoursOpen: serializer.fromJson<String?>(json['workingHoursOpen']),
      workingHoursClose: serializer.fromJson<String?>(
        json['workingHoursClose'],
      ),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'restaurantId': serializer.toJson<int>(restaurantId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'workingHoursOpen': serializer.toJson<String?>(workingHoursOpen),
      'workingHoursClose': serializer.toJson<String?>(workingHoursClose),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Branch copyWith({
    int? id,
    int? restaurantId,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> workingHoursOpen = const Value.absent(),
    Value<String?> workingHoursClose = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
  }) => Branch(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    workingHoursOpen: workingHoursOpen.present
        ? workingHoursOpen.value
        : this.workingHoursOpen,
    workingHoursClose: workingHoursClose.present
        ? workingHoursClose.value
        : this.workingHoursClose,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  Branch copyWithCompanion(BranchesCompanion data) {
    return Branch(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      workingHoursOpen: data.workingHoursOpen.present
          ? data.workingHoursOpen.value
          : this.workingHoursOpen,
      workingHoursClose: data.workingHoursClose.present
          ? data.workingHoursClose.value
          : this.workingHoursClose,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branch(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('workingHoursOpen: $workingHoursOpen, ')
          ..write('workingHoursClose: $workingHoursClose, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    restaurantId,
    name,
    address,
    workingHoursOpen,
    workingHoursClose,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.name == this.name &&
          other.address == this.address &&
          other.workingHoursOpen == this.workingHoursOpen &&
          other.workingHoursClose == this.workingHoursClose &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class BranchesCompanion extends UpdateCompanion<Branch> {
  final Value<int> id;
  final Value<int> restaurantId;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> workingHoursOpen;
  final Value<String?> workingHoursClose;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.workingHoursOpen = const Value.absent(),
    this.workingHoursClose = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BranchesCompanion.insert({
    this.id = const Value.absent(),
    required int restaurantId,
    required String name,
    this.address = const Value.absent(),
    this.workingHoursOpen = const Value.absent(),
    this.workingHoursClose = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : restaurantId = Value(restaurantId),
       name = Value(name);
  static Insertable<Branch> custom({
    Expression<int>? id,
    Expression<int>? restaurantId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? workingHoursOpen,
    Expression<String>? workingHoursClose,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (workingHoursOpen != null) 'working_hours_open': workingHoursOpen,
      if (workingHoursClose != null) 'working_hours_close': workingHoursClose,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BranchesCompanion copyWith({
    Value<int>? id,
    Value<int>? restaurantId,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? workingHoursOpen,
    Value<String?>? workingHoursClose,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      address: address ?? this.address,
      workingHoursOpen: workingHoursOpen ?? this.workingHoursOpen,
      workingHoursClose: workingHoursClose ?? this.workingHoursClose,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (workingHoursOpen.present) {
      map['working_hours_open'] = Variable<String>(workingHoursOpen.value);
    }
    if (workingHoursClose.present) {
      map['working_hours_close'] = Variable<String>(workingHoursClose.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('workingHoursOpen: $workingHoursOpen, ')
          ..write('workingHoursClose: $workingHoursClose, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HallsTable extends Halls with TableInfo<$HallsTable, Hall> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    name,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'halls';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hall> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hall map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hall(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HallsTable createAlias(String alias) {
    return $HallsTable(attachedDatabase, alias);
  }
}

class Hall extends DataClass implements Insertable<Hall> {
  final int id;
  final int branchId;
  final String name;
  final bool isArchived;
  final DateTime createdAt;
  const Hall({
    required this.id,
    required this.branchId,
    required this.name,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<int>(branchId);
    map['name'] = Variable<String>(name);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HallsCompanion toCompanion(bool nullToAbsent) {
    return HallsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory Hall.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hall(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<int>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<int>(branchId),
      'name': serializer.toJson<String>(name),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Hall copyWith({
    int? id,
    int? branchId,
    String? name,
    bool? isArchived,
    DateTime? createdAt,
  }) => Hall(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  Hall copyWithCompanion(HallsCompanion data) {
    return Hall(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hall(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, name, isArchived, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hall &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class HallsCompanion extends UpdateCompanion<Hall> {
  final Value<int> id;
  final Value<int> branchId;
  final Value<String> name;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const HallsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HallsCompanion.insert({
    this.id = const Value.absent(),
    required int branchId,
    required String name,
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : branchId = Value(branchId),
       name = Value(name);
  static Insertable<Hall> custom({
    Expression<int>? id,
    Expression<int>? branchId,
    Expression<String>? name,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HallsCompanion copyWith({
    Value<int>? id,
    Value<int>? branchId,
    Value<String>? name,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return HallsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HallsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ServiceTablesTable extends ServiceTables
    with TableInfo<$ServiceTablesTable, ServiceTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _hallIdMeta = const VerificationMeta('hallId');
  @override
  late final GeneratedColumn<int> hallId = GeneratedColumn<int>(
    'hall_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capacityMeta = const VerificationMeta(
    'capacity',
  );
  @override
  late final GeneratedColumn<int> capacity = GeneratedColumn<int>(
    'capacity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('available'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _shapeMeta = const VerificationMeta('shape');
  @override
  late final GeneratedColumn<String> shape = GeneratedColumn<String>(
    'shape',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('rectangle'),
  );
  static const VerificationMeta _positionXMeta = const VerificationMeta(
    'positionX',
  );
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
    'position_x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40),
  );
  static const VerificationMeta _positionYMeta = const VerificationMeta(
    'positionY',
  );
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
    'position_y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40),
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(120),
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(80),
  );
  static const VerificationMeta _rotationMeta = const VerificationMeta(
    'rotation',
  );
  @override
  late final GeneratedColumn<double> rotation = GeneratedColumn<double>(
    'rotation',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hallId,
    name,
    capacity,
    status,
    notes,
    sortOrder,
    shape,
    positionX,
    positionY,
    width,
    height,
    rotation,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_tables';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceTable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hall_id')) {
      context.handle(
        _hallIdMeta,
        hallId.isAcceptableOrUnknown(data['hall_id']!, _hallIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hallIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('capacity')) {
      context.handle(
        _capacityMeta,
        capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('shape')) {
      context.handle(
        _shapeMeta,
        shape.isAcceptableOrUnknown(data['shape']!, _shapeMeta),
      );
    }
    if (data.containsKey('position_x')) {
      context.handle(
        _positionXMeta,
        positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta),
      );
    }
    if (data.containsKey('position_y')) {
      context.handle(
        _positionYMeta,
        positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('rotation')) {
      context.handle(
        _rotationMeta,
        rotation.isAcceptableOrUnknown(data['rotation']!, _rotationMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceTable(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      hallId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hall_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      capacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capacity'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      shape: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shape'],
      )!,
      positionX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_x'],
      )!,
      positionY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_y'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      rotation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rotation'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ServiceTablesTable createAlias(String alias) {
    return $ServiceTablesTable(attachedDatabase, alias);
  }
}

class ServiceTable extends DataClass implements Insertable<ServiceTable> {
  final int id;
  final int hallId;
  final String name;
  final int capacity;
  final String status;
  final String? notes;
  final int sortOrder;
  final String shape;
  final double positionX;
  final double positionY;
  final double width;
  final double height;
  final double rotation;
  final DateTime createdAt;
  const ServiceTable({
    required this.id,
    required this.hallId,
    required this.name,
    required this.capacity,
    required this.status,
    this.notes,
    required this.sortOrder,
    required this.shape,
    required this.positionX,
    required this.positionY,
    required this.width,
    required this.height,
    required this.rotation,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hall_id'] = Variable<int>(hallId);
    map['name'] = Variable<String>(name);
    map['capacity'] = Variable<int>(capacity);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['shape'] = Variable<String>(shape);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['rotation'] = Variable<double>(rotation);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ServiceTablesCompanion toCompanion(bool nullToAbsent) {
    return ServiceTablesCompanion(
      id: Value(id),
      hallId: Value(hallId),
      name: Value(name),
      capacity: Value(capacity),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      sortOrder: Value(sortOrder),
      shape: Value(shape),
      positionX: Value(positionX),
      positionY: Value(positionY),
      width: Value(width),
      height: Value(height),
      rotation: Value(rotation),
      createdAt: Value(createdAt),
    );
  }

  factory ServiceTable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceTable(
      id: serializer.fromJson<int>(json['id']),
      hallId: serializer.fromJson<int>(json['hallId']),
      name: serializer.fromJson<String>(json['name']),
      capacity: serializer.fromJson<int>(json['capacity']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      shape: serializer.fromJson<String>(json['shape']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      rotation: serializer.fromJson<double>(json['rotation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hallId': serializer.toJson<int>(hallId),
      'name': serializer.toJson<String>(name),
      'capacity': serializer.toJson<int>(capacity),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'shape': serializer.toJson<String>(shape),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'rotation': serializer.toJson<double>(rotation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ServiceTable copyWith({
    int? id,
    int? hallId,
    String? name,
    int? capacity,
    String? status,
    Value<String?> notes = const Value.absent(),
    int? sortOrder,
    String? shape,
    double? positionX,
    double? positionY,
    double? width,
    double? height,
    double? rotation,
    DateTime? createdAt,
  }) => ServiceTable(
    id: id ?? this.id,
    hallId: hallId ?? this.hallId,
    name: name ?? this.name,
    capacity: capacity ?? this.capacity,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    sortOrder: sortOrder ?? this.sortOrder,
    shape: shape ?? this.shape,
    positionX: positionX ?? this.positionX,
    positionY: positionY ?? this.positionY,
    width: width ?? this.width,
    height: height ?? this.height,
    rotation: rotation ?? this.rotation,
    createdAt: createdAt ?? this.createdAt,
  );
  ServiceTable copyWithCompanion(ServiceTablesCompanion data) {
    return ServiceTable(
      id: data.id.present ? data.id.value : this.id,
      hallId: data.hallId.present ? data.hallId.value : this.hallId,
      name: data.name.present ? data.name.value : this.name,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      shape: data.shape.present ? data.shape.value : this.shape,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      rotation: data.rotation.present ? data.rotation.value : this.rotation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceTable(')
          ..write('id: $id, ')
          ..write('hallId: $hallId, ')
          ..write('name: $name, ')
          ..write('capacity: $capacity, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('shape: $shape, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotation: $rotation, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hallId,
    name,
    capacity,
    status,
    notes,
    sortOrder,
    shape,
    positionX,
    positionY,
    width,
    height,
    rotation,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceTable &&
          other.id == this.id &&
          other.hallId == this.hallId &&
          other.name == this.name &&
          other.capacity == this.capacity &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.sortOrder == this.sortOrder &&
          other.shape == this.shape &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.width == this.width &&
          other.height == this.height &&
          other.rotation == this.rotation &&
          other.createdAt == this.createdAt);
}

class ServiceTablesCompanion extends UpdateCompanion<ServiceTable> {
  final Value<int> id;
  final Value<int> hallId;
  final Value<String> name;
  final Value<int> capacity;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> sortOrder;
  final Value<String> shape;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<double> width;
  final Value<double> height;
  final Value<double> rotation;
  final Value<DateTime> createdAt;
  const ServiceTablesCompanion({
    this.id = const Value.absent(),
    this.hallId = const Value.absent(),
    this.name = const Value.absent(),
    this.capacity = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.shape = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.rotation = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ServiceTablesCompanion.insert({
    this.id = const Value.absent(),
    required int hallId,
    required String name,
    this.capacity = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.shape = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.rotation = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : hallId = Value(hallId),
       name = Value(name);
  static Insertable<ServiceTable> custom({
    Expression<int>? id,
    Expression<int>? hallId,
    Expression<String>? name,
    Expression<int>? capacity,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? sortOrder,
    Expression<String>? shape,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<double>? width,
    Expression<double>? height,
    Expression<double>? rotation,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hallId != null) 'hall_id': hallId,
      if (name != null) 'name': name,
      if (capacity != null) 'capacity': capacity,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (shape != null) 'shape': shape,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (rotation != null) 'rotation': rotation,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ServiceTablesCompanion copyWith({
    Value<int>? id,
    Value<int>? hallId,
    Value<String>? name,
    Value<int>? capacity,
    Value<String>? status,
    Value<String?>? notes,
    Value<int>? sortOrder,
    Value<String>? shape,
    Value<double>? positionX,
    Value<double>? positionY,
    Value<double>? width,
    Value<double>? height,
    Value<double>? rotation,
    Value<DateTime>? createdAt,
  }) {
    return ServiceTablesCompanion(
      id: id ?? this.id,
      hallId: hallId ?? this.hallId,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      sortOrder: sortOrder ?? this.sortOrder,
      shape: shape ?? this.shape,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      width: width ?? this.width,
      height: height ?? this.height,
      rotation: rotation ?? this.rotation,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hallId.present) {
      map['hall_id'] = Variable<int>(hallId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<int>(capacity.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (shape.present) {
      map['shape'] = Variable<String>(shape.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (rotation.present) {
      map['rotation'] = Variable<double>(rotation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceTablesCompanion(')
          ..write('id: $id, ')
          ..write('hallId: $hallId, ')
          ..write('name: $name, ')
          ..write('capacity: $capacity, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('shape: $shape, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotation: $rotation, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MenusTable extends Menus with TableInfo<$MenusTable, RestaurantMenu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<int> restaurantId = GeneratedColumn<int>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    name,
    isActive,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menus';
  @override
  VerificationContext validateIntegrity(
    Insertable<RestaurantMenu> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestaurantMenu map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestaurantMenu(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}restaurant_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MenusTable createAlias(String alias) {
    return $MenusTable(attachedDatabase, alias);
  }
}

class RestaurantMenu extends DataClass implements Insertable<RestaurantMenu> {
  final int id;
  final int restaurantId;
  final String name;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  const RestaurantMenu({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['restaurant_id'] = Variable<int>(restaurantId);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenusCompanion toCompanion(bool nullToAbsent) {
    return MenusCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      name: Value(name),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory RestaurantMenu.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestaurantMenu(
      id: serializer.fromJson<int>(json['id']),
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'restaurantId': serializer.toJson<int>(restaurantId),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RestaurantMenu copyWith({
    int? id,
    int? restaurantId,
    String? name,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
  }) => RestaurantMenu(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  RestaurantMenu copyWithCompanion(MenusCompanion data) {
    return RestaurantMenu(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantMenu(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, restaurantId, name, isActive, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestaurantMenu &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class MenusCompanion extends UpdateCompanion<RestaurantMenu> {
  final Value<int> id;
  final Value<int> restaurantId;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const MenusCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MenusCompanion.insert({
    this.id = const Value.absent(),
    required int restaurantId,
    required String name,
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : restaurantId = Value(restaurantId),
       name = Value(name);
  static Insertable<RestaurantMenu> custom({
    Expression<int>? id,
    Expression<int>? restaurantId,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MenusCompanion copyWith({
    Value<int>? id,
    Value<int>? restaurantId,
    Value<String>? name,
    Value<bool>? isActive,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return MenusCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenusCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MenuCategoriesTable extends MenuCategories
    with TableInfo<$MenuCategoriesTable, MenuCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<int> restaurantId = GeneratedColumn<int>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    menuId,
    name,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}restaurant_id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MenuCategoriesTable createAlias(String alias) {
    return $MenuCategoriesTable(attachedDatabase, alias);
  }
}

class MenuCategory extends DataClass implements Insertable<MenuCategory> {
  final int id;
  final int restaurantId;

  /// Nullable only so existing rows survive the migration that introduced
  /// this column — every category created through the app from here on
  /// always has one. See AppDatabase's v4 migration for the backfill.
  final int? menuId;
  final String name;
  final int sortOrder;
  final DateTime createdAt;
  const MenuCategory({
    required this.id,
    required this.restaurantId,
    this.menuId,
    required this.name,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['restaurant_id'] = Variable<int>(restaurantId);
    if (!nullToAbsent || menuId != null) {
      map['menu_id'] = Variable<int>(menuId);
    }
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenuCategoriesCompanion toCompanion(bool nullToAbsent) {
    return MenuCategoriesCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      menuId: menuId == null && nullToAbsent
          ? const Value.absent()
          : Value(menuId),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory MenuCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuCategory(
      id: serializer.fromJson<int>(json['id']),
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      menuId: serializer.fromJson<int?>(json['menuId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'restaurantId': serializer.toJson<int>(restaurantId),
      'menuId': serializer.toJson<int?>(menuId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenuCategory copyWith({
    int? id,
    int? restaurantId,
    Value<int?> menuId = const Value.absent(),
    String? name,
    int? sortOrder,
    DateTime? createdAt,
  }) => MenuCategory(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    menuId: menuId.present ? menuId.value : this.menuId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  MenuCategory copyWithCompanion(MenuCategoriesCompanion data) {
    return MenuCategory(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuCategory(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('menuId: $menuId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, restaurantId, menuId, name, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuCategory &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.menuId == this.menuId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class MenuCategoriesCompanion extends UpdateCompanion<MenuCategory> {
  final Value<int> id;
  final Value<int> restaurantId;
  final Value<int?> menuId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const MenuCategoriesCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.menuId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MenuCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required int restaurantId,
    this.menuId = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : restaurantId = Value(restaurantId),
       name = Value(name);
  static Insertable<MenuCategory> custom({
    Expression<int>? id,
    Expression<int>? restaurantId,
    Expression<int>? menuId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (menuId != null) 'menu_id': menuId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MenuCategoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? restaurantId,
    Value<int?>? menuId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return MenuCategoriesCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      menuId: menuId ?? this.menuId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('menuId: $menuId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MenuItemsTable extends MenuItems
    with TableInfo<$MenuItemsTable, MenuItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxPercentMeta = const VerificationMeta(
    'taxPercent',
  );
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
    'tax_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDrinkMeta = const VerificationMeta(
    'isDrink',
  );
  @override
  late final GeneratedColumn<bool> isDrink = GeneratedColumn<bool>(
    'is_drink',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_drink" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    description,
    price,
    taxPercent,
    isAvailable,
    isDrink,
    imagePath,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
        _taxPercentMeta,
        taxPercent.isAcceptableOrUnknown(data['tax_percent']!, _taxPercentMeta),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('is_drink')) {
      context.handle(
        _isDrinkMeta,
        isDrink.isAcceptableOrUnknown(data['is_drink']!, _isDrinkMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      taxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_percent'],
      )!,
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      isDrink: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_drink'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MenuItemsTable createAlias(String alias) {
    return $MenuItemsTable(attachedDatabase, alias);
  }
}

class MenuItem extends DataClass implements Insertable<MenuItem> {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final double taxPercent;
  final bool isAvailable;
  final bool isDrink;

  /// A pasted image URL (http/https) or a local file path copied in via
  /// device upload — see AppImage for how this is rendered.
  final String? imagePath;
  final int sortOrder;
  final DateTime createdAt;
  const MenuItem({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.taxPercent,
    required this.isAvailable,
    required this.isDrink,
    this.imagePath,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['price'] = Variable<double>(price);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['is_available'] = Variable<bool>(isAvailable);
    map['is_drink'] = Variable<bool>(isDrink);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenuItemsCompanion toCompanion(bool nullToAbsent) {
    return MenuItemsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      price: Value(price),
      taxPercent: Value(taxPercent),
      isAvailable: Value(isAvailable),
      isDrink: Value(isDrink),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory MenuItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItem(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      isDrink: serializer.fromJson<bool>(json['isDrink']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'price': serializer.toJson<double>(price),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'isDrink': serializer.toJson<bool>(isDrink),
      'imagePath': serializer.toJson<String?>(imagePath),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenuItem copyWith({
    int? id,
    int? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
    double? price,
    double? taxPercent,
    bool? isAvailable,
    bool? isDrink,
    Value<String?> imagePath = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => MenuItem(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    price: price ?? this.price,
    taxPercent: taxPercent ?? this.taxPercent,
    isAvailable: isAvailable ?? this.isAvailable,
    isDrink: isDrink ?? this.isDrink,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  MenuItem copyWithCompanion(MenuItemsCompanion data) {
    return MenuItem(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      taxPercent: data.taxPercent.present
          ? data.taxPercent.value
          : this.taxPercent,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      isDrink: data.isDrink.present ? data.isDrink.value : this.isDrink,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItem(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('isDrink: $isDrink, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    description,
    price,
    taxPercent,
    isAvailable,
    isDrink,
    imagePath,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItem &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.taxPercent == this.taxPercent &&
          other.isAvailable == this.isAvailable &&
          other.isDrink == this.isDrink &&
          other.imagePath == this.imagePath &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class MenuItemsCompanion extends UpdateCompanion<MenuItem> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> price;
  final Value<double> taxPercent;
  final Value<bool> isAvailable;
  final Value<bool> isDrink;
  final Value<String?> imagePath;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const MenuItemsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.isDrink = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MenuItemsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.description = const Value.absent(),
    required double price,
    this.taxPercent = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.isDrink = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name),
       price = Value(price);
  static Insertable<MenuItem> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<double>? taxPercent,
    Expression<bool>? isAvailable,
    Expression<bool>? isDrink,
    Expression<String>? imagePath,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (isAvailable != null) 'is_available': isAvailable,
      if (isDrink != null) 'is_drink': isDrink,
      if (imagePath != null) 'image_path': imagePath,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MenuItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? price,
    Value<double>? taxPercent,
    Value<bool>? isAvailable,
    Value<bool>? isDrink,
    Value<String?>? imagePath,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return MenuItemsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      taxPercent: taxPercent ?? this.taxPercent,
      isAvailable: isAvailable ?? this.isAvailable,
      isDrink: isDrink ?? this.isDrink,
      imagePath: imagePath ?? this.imagePath,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (isDrink.present) {
      map['is_drink'] = Variable<bool>(isDrink.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('isDrink: $isDrink, ')
          ..write('imagePath: $imagePath, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MenuVariantsTable extends MenuVariants
    with TableInfo<$MenuVariantsTable, MenuVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuVariantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceDeltaMeta = const VerificationMeta(
    'priceDelta',
  );
  @override
  late final GeneratedColumn<double> priceDelta = GeneratedColumn<double>(
    'price_delta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    name,
    priceDelta,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuVariant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_delta')) {
      context.handle(
        _priceDeltaMeta,
        priceDelta.isAcceptableOrUnknown(data['price_delta']!, _priceDeltaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuVariant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_delta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MenuVariantsTable createAlias(String alias) {
    return $MenuVariantsTable(attachedDatabase, alias);
  }
}

class MenuVariant extends DataClass implements Insertable<MenuVariant> {
  final int id;
  final int itemId;
  final String name;
  final double priceDelta;
  final DateTime createdAt;
  const MenuVariant({
    required this.id,
    required this.itemId,
    required this.name,
    required this.priceDelta,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['name'] = Variable<String>(name);
    map['price_delta'] = Variable<double>(priceDelta);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenuVariantsCompanion toCompanion(bool nullToAbsent) {
    return MenuVariantsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      name: Value(name),
      priceDelta: Value(priceDelta),
      createdAt: Value(createdAt),
    );
  }

  factory MenuVariant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuVariant(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      priceDelta: serializer.fromJson<double>(json['priceDelta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'name': serializer.toJson<String>(name),
      'priceDelta': serializer.toJson<double>(priceDelta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenuVariant copyWith({
    int? id,
    int? itemId,
    String? name,
    double? priceDelta,
    DateTime? createdAt,
  }) => MenuVariant(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    name: name ?? this.name,
    priceDelta: priceDelta ?? this.priceDelta,
    createdAt: createdAt ?? this.createdAt,
  );
  MenuVariant copyWithCompanion(MenuVariantsCompanion data) {
    return MenuVariant(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      name: data.name.present ? data.name.value : this.name,
      priceDelta: data.priceDelta.present
          ? data.priceDelta.value
          : this.priceDelta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuVariant(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('priceDelta: $priceDelta, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, name, priceDelta, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuVariant &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.priceDelta == this.priceDelta &&
          other.createdAt == this.createdAt);
}

class MenuVariantsCompanion extends UpdateCompanion<MenuVariant> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> name;
  final Value<double> priceDelta;
  final Value<DateTime> createdAt;
  const MenuVariantsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.priceDelta = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MenuVariantsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String name,
    this.priceDelta = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : itemId = Value(itemId),
       name = Value(name);
  static Insertable<MenuVariant> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? name,
    Expression<double>? priceDelta,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (priceDelta != null) 'price_delta': priceDelta,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MenuVariantsCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<String>? name,
    Value<double>? priceDelta,
    Value<DateTime>? createdAt,
  }) {
    return MenuVariantsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      priceDelta: priceDelta ?? this.priceDelta,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceDelta.present) {
      map['price_delta'] = Variable<double>(priceDelta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuVariantsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('priceDelta: $priceDelta, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DiscountsTable extends Discounts
    with TableInfo<$DiscountsTable, Discount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<int> restaurantId = GeneratedColumn<int>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    name,
    type,
    value,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Discount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Discount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Discount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}restaurant_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DiscountsTable createAlias(String alias) {
    return $DiscountsTable(attachedDatabase, alias);
  }
}

class Discount extends DataClass implements Insertable<Discount> {
  final int id;
  final int restaurantId;
  final String name;

  /// 'percent' or 'fixed' — see DiscountType in core/domain/enums.dart.
  final String type;
  final double value;
  final bool isActive;
  final DateTime createdAt;
  const Discount({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.type,
    required this.value,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['restaurant_id'] = Variable<int>(restaurantId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<double>(value);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DiscountsCompanion toCompanion(bool nullToAbsent) {
    return DiscountsCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      name: Value(name),
      type: Value(type),
      value: Value(value),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Discount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Discount(
      id: serializer.fromJson<int>(json['id']),
      restaurantId: serializer.fromJson<int>(json['restaurantId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<double>(json['value']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'restaurantId': serializer.toJson<int>(restaurantId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<double>(value),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Discount copyWith({
    int? id,
    int? restaurantId,
    String? name,
    String? type,
    double? value,
    bool? isActive,
    DateTime? createdAt,
  }) => Discount(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    name: name ?? this.name,
    type: type ?? this.type,
    value: value ?? this.value,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Discount copyWithCompanion(DiscountsCompanion data) {
    return Discount(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Discount(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, restaurantId, name, type, value, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Discount &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.name == this.name &&
          other.type == this.type &&
          other.value == this.value &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class DiscountsCompanion extends UpdateCompanion<Discount> {
  final Value<int> id;
  final Value<int> restaurantId;
  final Value<String> name;
  final Value<String> type;
  final Value<double> value;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const DiscountsCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DiscountsCompanion.insert({
    this.id = const Value.absent(),
    required int restaurantId,
    required String name,
    required String type,
    required double value,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : restaurantId = Value(restaurantId),
       name = Value(name),
       type = Value(type),
       value = Value(value);
  static Insertable<Discount> custom({
    Expression<int>? id,
    Expression<int>? restaurantId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? value,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DiscountsCompanion copyWith({
    Value<int>? id,
    Value<int>? restaurantId,
    Value<String>? name,
    Value<String>? type,
    Value<double>? value,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return DiscountsCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<int>(restaurantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountsCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReservationsTable extends Reservations
    with TableInfo<$ReservationsTable, Reservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tableIdMeta = const VerificationMeta(
    'tableId',
  );
  @override
  late final GeneratedColumn<int> tableId = GeneratedColumn<int>(
    'table_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guestCountMeta = const VerificationMeta(
    'guestCount',
  );
  @override
  late final GeneratedColumn<int> guestCount = GeneratedColumn<int>(
    'guest_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    tableId,
    customerName,
    phone,
    date,
    time,
    guestCount,
    notes,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reservations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('table_id')) {
      context.handle(
        _tableIdMeta,
        tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('guest_count')) {
      context.handle(
        _guestCountMeta,
        guestCount.isAcceptableOrUnknown(data['guest_count']!, _guestCountMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}branch_id'],
      )!,
      tableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}table_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      guestCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}guest_count'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReservationsTable createAlias(String alias) {
    return $ReservationsTable(attachedDatabase, alias);
  }
}

class Reservation extends DataClass implements Insertable<Reservation> {
  final int id;
  final int branchId;
  final int? tableId;
  final String customerName;
  final String? phone;
  final DateTime date;
  final String time;
  final int guestCount;
  final String? notes;
  final String status;
  final DateTime createdAt;
  const Reservation({
    required this.id,
    required this.branchId,
    this.tableId,
    required this.customerName,
    this.phone,
    required this.date,
    required this.time,
    required this.guestCount,
    this.notes,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<int>(branchId);
    if (!nullToAbsent || tableId != null) {
      map['table_id'] = Variable<int>(tableId);
    }
    map['customer_name'] = Variable<String>(customerName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<String>(time);
    map['guest_count'] = Variable<int>(guestCount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReservationsCompanion toCompanion(bool nullToAbsent) {
    return ReservationsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      tableId: tableId == null && nullToAbsent
          ? const Value.absent()
          : Value(tableId),
      customerName: Value(customerName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      date: Value(date),
      time: Value(time),
      guestCount: Value(guestCount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Reservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reservation(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<int>(json['branchId']),
      tableId: serializer.fromJson<int?>(json['tableId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phone: serializer.fromJson<String?>(json['phone']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<String>(json['time']),
      guestCount: serializer.fromJson<int>(json['guestCount']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<int>(branchId),
      'tableId': serializer.toJson<int?>(tableId),
      'customerName': serializer.toJson<String>(customerName),
      'phone': serializer.toJson<String?>(phone),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<String>(time),
      'guestCount': serializer.toJson<int>(guestCount),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reservation copyWith({
    int? id,
    int? branchId,
    Value<int?> tableId = const Value.absent(),
    String? customerName,
    Value<String?> phone = const Value.absent(),
    DateTime? date,
    String? time,
    int? guestCount,
    Value<String?> notes = const Value.absent(),
    String? status,
    DateTime? createdAt,
  }) => Reservation(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    tableId: tableId.present ? tableId.value : this.tableId,
    customerName: customerName ?? this.customerName,
    phone: phone.present ? phone.value : this.phone,
    date: date ?? this.date,
    time: time ?? this.time,
    guestCount: guestCount ?? this.guestCount,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Reservation copyWithCompanion(ReservationsCompanion data) {
    return Reservation(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      date: data.date.present ? data.date.value : this.date,
      time: data.time.present ? data.time.value : this.time,
      guestCount: data.guestCount.present
          ? data.guestCount.value
          : this.guestCount,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reservation(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('guestCount: $guestCount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    tableId,
    customerName,
    phone,
    date,
    time,
    guestCount,
    notes,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reservation &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.tableId == this.tableId &&
          other.customerName == this.customerName &&
          other.phone == this.phone &&
          other.date == this.date &&
          other.time == this.time &&
          other.guestCount == this.guestCount &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ReservationsCompanion extends UpdateCompanion<Reservation> {
  final Value<int> id;
  final Value<int> branchId;
  final Value<int?> tableId;
  final Value<String> customerName;
  final Value<String?> phone;
  final Value<DateTime> date;
  final Value<String> time;
  final Value<int> guestCount;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const ReservationsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.tableId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReservationsCompanion.insert({
    this.id = const Value.absent(),
    required int branchId,
    this.tableId = const Value.absent(),
    required String customerName,
    this.phone = const Value.absent(),
    required DateTime date,
    required String time,
    this.guestCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : branchId = Value(branchId),
       customerName = Value(customerName),
       date = Value(date),
       time = Value(time);
  static Insertable<Reservation> custom({
    Expression<int>? id,
    Expression<int>? branchId,
    Expression<int>? tableId,
    Expression<String>? customerName,
    Expression<String>? phone,
    Expression<DateTime>? date,
    Expression<String>? time,
    Expression<int>? guestCount,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (tableId != null) 'table_id': tableId,
      if (customerName != null) 'customer_name': customerName,
      if (phone != null) 'phone': phone,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (guestCount != null) 'guest_count': guestCount,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReservationsCompanion copyWith({
    Value<int>? id,
    Value<int>? branchId,
    Value<int?>? tableId,
    Value<String>? customerName,
    Value<String?>? phone,
    Value<DateTime>? date,
    Value<String>? time,
    Value<int>? guestCount,
    Value<String?>? notes,
    Value<String>? status,
    Value<DateTime>? createdAt,
  }) {
    return ReservationsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      tableId: tableId ?? this.tableId,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      time: time ?? this.time,
      guestCount: guestCount ?? this.guestCount,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<int>(tableId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (guestCount.present) {
      map['guest_count'] = Variable<int>(guestCount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservationsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('guestCount: $guestCount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hallIdMeta = const VerificationMeta('hallId');
  @override
  late final GeneratedColumn<int> hallId = GeneratedColumn<int>(
    'hall_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tableIdMeta = const VerificationMeta(
    'tableId',
  );
  @override
  late final GeneratedColumn<int> tableId = GeneratedColumn<int>(
    'table_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<double> tip = GeneratedColumn<double>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    hallId,
    tableId,
    customerName,
    status,
    comment,
    subtotal,
    discount,
    tax,
    tip,
    total,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('hall_id')) {
      context.handle(
        _hallIdMeta,
        hallId.isAcceptableOrUnknown(data['hall_id']!, _hallIdMeta),
      );
    }
    if (data.containsKey('table_id')) {
      context.handle(
        _tableIdMeta,
        tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}branch_id'],
      )!,
      hallId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hall_id'],
      ),
      tableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}table_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tip'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int branchId;
  final int? hallId;
  final int? tableId;
  final String? customerName;
  final String status;
  final String? comment;
  final double subtotal;
  final double discount;
  final double tax;
  final double tip;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Order({
    required this.id,
    required this.branchId,
    this.hallId,
    this.tableId,
    this.customerName,
    required this.status,
    this.comment,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.tip,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<int>(branchId);
    if (!nullToAbsent || hallId != null) {
      map['hall_id'] = Variable<int>(hallId);
    }
    if (!nullToAbsent || tableId != null) {
      map['table_id'] = Variable<int>(tableId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['tax'] = Variable<double>(tax);
    map['tip'] = Variable<double>(tip);
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      branchId: Value(branchId),
      hallId: hallId == null && nullToAbsent
          ? const Value.absent()
          : Value(hallId),
      tableId: tableId == null && nullToAbsent
          ? const Value.absent()
          : Value(tableId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      status: Value(status),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      subtotal: Value(subtotal),
      discount: Value(discount),
      tax: Value(tax),
      tip: Value(tip),
      total: Value(total),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<int>(json['branchId']),
      hallId: serializer.fromJson<int?>(json['hallId']),
      tableId: serializer.fromJson<int?>(json['tableId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      status: serializer.fromJson<String>(json['status']),
      comment: serializer.fromJson<String?>(json['comment']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      tip: serializer.fromJson<double>(json['tip']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<int>(branchId),
      'hallId': serializer.toJson<int?>(hallId),
      'tableId': serializer.toJson<int?>(tableId),
      'customerName': serializer.toJson<String?>(customerName),
      'status': serializer.toJson<String>(status),
      'comment': serializer.toJson<String?>(comment),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'tip': serializer.toJson<double>(tip),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Order copyWith({
    int? id,
    int? branchId,
    Value<int?> hallId = const Value.absent(),
    Value<int?> tableId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    String? status,
    Value<String?> comment = const Value.absent(),
    double? subtotal,
    double? discount,
    double? tax,
    double? tip,
    double? total,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Order(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    hallId: hallId.present ? hallId.value : this.hallId,
    tableId: tableId.present ? tableId.value : this.tableId,
    customerName: customerName.present ? customerName.value : this.customerName,
    status: status ?? this.status,
    comment: comment.present ? comment.value : this.comment,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    tip: tip ?? this.tip,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      hallId: data.hallId.present ? data.hallId.value : this.hallId,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      status: data.status.present ? data.status.value : this.status,
      comment: data.comment.present ? data.comment.value : this.comment,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      tip: data.tip.present ? data.tip.value : this.tip,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('hallId: $hallId, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('comment: $comment, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    hallId,
    tableId,
    customerName,
    status,
    comment,
    subtotal,
    discount,
    tax,
    tip,
    total,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.hallId == this.hallId &&
          other.tableId == this.tableId &&
          other.customerName == this.customerName &&
          other.status == this.status &&
          other.comment == this.comment &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.tip == this.tip &&
          other.total == this.total &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int> branchId;
  final Value<int?> hallId;
  final Value<int?> tableId;
  final Value<String?> customerName;
  final Value<String> status;
  final Value<String?> comment;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> tip;
  final Value<double> total;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.hallId = const Value.absent(),
    this.tableId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.status = const Value.absent(),
    this.comment = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required int branchId,
    this.hallId = const Value.absent(),
    this.tableId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.status = const Value.absent(),
    this.comment = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : branchId = Value(branchId);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<int>? branchId,
    Expression<int>? hallId,
    Expression<int>? tableId,
    Expression<String>? customerName,
    Expression<String>? status,
    Expression<String>? comment,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? tax,
    Expression<double>? tip,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (hallId != null) 'hall_id': hallId,
      if (tableId != null) 'table_id': tableId,
      if (customerName != null) 'customer_name': customerName,
      if (status != null) 'status': status,
      if (comment != null) 'comment': comment,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (tip != null) 'tip': tip,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? branchId,
    Value<int?>? hallId,
    Value<int?>? tableId,
    Value<String?>? customerName,
    Value<String>? status,
    Value<String?>? comment,
    Value<double>? subtotal,
    Value<double>? discount,
    Value<double>? tax,
    Value<double>? tip,
    Value<double>? total,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      hallId: hallId ?? this.hallId,
      tableId: tableId ?? this.tableId,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      comment: comment ?? this.comment,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      tip: tip ?? this.tip,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (hallId.present) {
      map['hall_id'] = Variable<int>(hallId.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<int>(tableId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (tip.present) {
      map['tip'] = Variable<double>(tip.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('hallId: $hallId, ')
          ..write('tableId: $tableId, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('comment: $comment, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems
    with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _menuItemIdMeta = const VerificationMeta(
    'menuItemId',
  );
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
    'menu_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantNameMeta = const VerificationMeta(
    'variantName',
  );
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
    'variant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDrinkMeta = const VerificationMeta(
    'isDrink',
  );
  @override
  late final GeneratedColumn<bool> isDrink = GeneratedColumn<bool>(
    'is_drink',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_drink" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('newItem'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    menuItemId,
    variantId,
    itemName,
    variantName,
    quantity,
    unitPrice,
    comment,
    isDrink,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('menu_item_id')) {
      context.handle(
        _menuItemIdMeta,
        menuItemId.isAcceptableOrUnknown(
          data['menu_item_id']!,
          _menuItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('variant_name')) {
      context.handle(
        _variantNameMeta,
        variantName.isAcceptableOrUnknown(
          data['variant_name']!,
          _variantNameMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('is_drink')) {
      context.handle(
        _isDrinkMeta,
        isDrink.isAcceptableOrUnknown(data['is_drink']!, _isDrinkMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      menuItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_item_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      ),
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      )!,
      variantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_name'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      isDrink: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_drink'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final int id;
  final int orderId;
  final int menuItemId;
  final int? variantId;
  final String itemName;
  final String? variantName;
  final int quantity;
  final double unitPrice;
  final String? comment;
  final bool isDrink;
  final String status;
  final DateTime createdAt;
  const OrderItem({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    this.variantId,
    required this.itemName,
    this.variantName,
    required this.quantity,
    required this.unitPrice,
    this.comment,
    required this.isDrink,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['menu_item_id'] = Variable<int>(menuItemId);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    map['item_name'] = Variable<String>(itemName);
    if (!nullToAbsent || variantName != null) {
      map['variant_name'] = Variable<String>(variantName);
    }
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['is_drink'] = Variable<bool>(isDrink);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      menuItemId: Value(menuItemId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      itemName: Value(itemName),
      variantName: variantName == null && nullToAbsent
          ? const Value.absent()
          : Value(variantName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      isDrink: Value(isDrink),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory OrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      variantId: serializer.fromJson<int?>(json['variantId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      variantName: serializer.fromJson<String?>(json['variantName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      comment: serializer.fromJson<String?>(json['comment']),
      isDrink: serializer.fromJson<bool>(json['isDrink']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'menuItemId': serializer.toJson<int>(menuItemId),
      'variantId': serializer.toJson<int?>(variantId),
      'itemName': serializer.toJson<String>(itemName),
      'variantName': serializer.toJson<String?>(variantName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'comment': serializer.toJson<String?>(comment),
      'isDrink': serializer.toJson<bool>(isDrink),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrderItem copyWith({
    int? id,
    int? orderId,
    int? menuItemId,
    Value<int?> variantId = const Value.absent(),
    String? itemName,
    Value<String?> variantName = const Value.absent(),
    int? quantity,
    double? unitPrice,
    Value<String?> comment = const Value.absent(),
    bool? isDrink,
    String? status,
    DateTime? createdAt,
  }) => OrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    menuItemId: menuItemId ?? this.menuItemId,
    variantId: variantId.present ? variantId.value : this.variantId,
    itemName: itemName ?? this.itemName,
    variantName: variantName.present ? variantName.value : this.variantName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    comment: comment.present ? comment.value : this.comment,
    isDrink: isDrink ?? this.isDrink,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      menuItemId: data.menuItemId.present
          ? data.menuItemId.value
          : this.menuItemId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      variantName: data.variantName.present
          ? data.variantName.value
          : this.variantName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      comment: data.comment.present ? data.comment.value : this.comment,
      isDrink: data.isDrink.present ? data.isDrink.value : this.isDrink,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('variantId: $variantId, ')
          ..write('itemName: $itemName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('comment: $comment, ')
          ..write('isDrink: $isDrink, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    menuItemId,
    variantId,
    itemName,
    variantName,
    quantity,
    unitPrice,
    comment,
    isDrink,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.menuItemId == this.menuItemId &&
          other.variantId == this.variantId &&
          other.itemName == this.itemName &&
          other.variantName == this.variantName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.comment == this.comment &&
          other.isDrink == this.isDrink &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> menuItemId;
  final Value<int?> variantId;
  final Value<String> itemName;
  final Value<String?> variantName;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<String?> comment;
  final Value<bool> isDrink;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const OrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.menuItemId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.variantName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.comment = const Value.absent(),
    this.isDrink = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int menuItemId,
    this.variantId = const Value.absent(),
    required String itemName,
    this.variantName = const Value.absent(),
    this.quantity = const Value.absent(),
    required double unitPrice,
    this.comment = const Value.absent(),
    this.isDrink = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : orderId = Value(orderId),
       menuItemId = Value(menuItemId),
       itemName = Value(itemName),
       unitPrice = Value(unitPrice);
  static Insertable<OrderItem> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? menuItemId,
    Expression<int>? variantId,
    Expression<String>? itemName,
    Expression<String>? variantName,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<String>? comment,
    Expression<bool>? isDrink,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (variantId != null) 'variant_id': variantId,
      if (itemName != null) 'item_name': itemName,
      if (variantName != null) 'variant_name': variantName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (comment != null) 'comment': comment,
      if (isDrink != null) 'is_drink': isDrink,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OrderItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<int>? menuItemId,
    Value<int?>? variantId,
    Value<String>? itemName,
    Value<String?>? variantName,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<String?>? comment,
    Value<bool>? isDrink,
    Value<String>? status,
    Value<DateTime>? createdAt,
  }) {
    return OrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId ?? this.menuItemId,
      variantId: variantId ?? this.variantId,
      itemName: itemName ?? this.itemName,
      variantName: variantName ?? this.variantName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      comment: comment ?? this.comment,
      isDrink: isDrink ?? this.isDrink,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (isDrink.present) {
      map['is_drink'] = Variable<bool>(isDrink.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('variantId: $variantId, ')
          ..write('itemName: $itemName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('comment: $comment, ')
          ..write('isDrink: $isDrink, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCashMeta = const VerificationMeta(
    'amountCash',
  );
  @override
  late final GeneratedColumn<double> amountCash = GeneratedColumn<double>(
    'amount_cash',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _amountCardMeta = const VerificationMeta(
    'amountCard',
  );
  @override
  late final GeneratedColumn<double> amountCard = GeneratedColumn<double>(
    'amount_card',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<double> tip = GeneratedColumn<double>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    method,
    amountCash,
    amountCard,
    discount,
    tip,
    total,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('amount_cash')) {
      context.handle(
        _amountCashMeta,
        amountCash.isAcceptableOrUnknown(data['amount_cash']!, _amountCashMeta),
      );
    }
    if (data.containsKey('amount_card')) {
      context.handle(
        _amountCardMeta,
        amountCard.isAcceptableOrUnknown(data['amount_card']!, _amountCardMeta),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      amountCash: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_cash'],
      )!,
      amountCard: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_card'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tip'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int orderId;
  final String method;
  final double amountCash;
  final double amountCard;
  final double discount;
  final double tip;
  final double total;
  final DateTime createdAt;
  const Payment({
    required this.id,
    required this.orderId,
    required this.method,
    required this.amountCash,
    required this.amountCard,
    required this.discount,
    required this.tip,
    required this.total,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['method'] = Variable<String>(method);
    map['amount_cash'] = Variable<double>(amountCash);
    map['amount_card'] = Variable<double>(amountCard);
    map['discount'] = Variable<double>(discount);
    map['tip'] = Variable<double>(tip);
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      method: Value(method),
      amountCash: Value(amountCash),
      amountCard: Value(amountCard),
      discount: Value(discount),
      tip: Value(tip),
      total: Value(total),
      createdAt: Value(createdAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      method: serializer.fromJson<String>(json['method']),
      amountCash: serializer.fromJson<double>(json['amountCash']),
      amountCard: serializer.fromJson<double>(json['amountCard']),
      discount: serializer.fromJson<double>(json['discount']),
      tip: serializer.fromJson<double>(json['tip']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'method': serializer.toJson<String>(method),
      'amountCash': serializer.toJson<double>(amountCash),
      'amountCard': serializer.toJson<double>(amountCard),
      'discount': serializer.toJson<double>(discount),
      'tip': serializer.toJson<double>(tip),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Payment copyWith({
    int? id,
    int? orderId,
    String? method,
    double? amountCash,
    double? amountCard,
    double? discount,
    double? tip,
    double? total,
    DateTime? createdAt,
  }) => Payment(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    method: method ?? this.method,
    amountCash: amountCash ?? this.amountCash,
    amountCard: amountCard ?? this.amountCard,
    discount: discount ?? this.discount,
    tip: tip ?? this.tip,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      method: data.method.present ? data.method.value : this.method,
      amountCash: data.amountCash.present
          ? data.amountCash.value
          : this.amountCash,
      amountCard: data.amountCard.present
          ? data.amountCard.value
          : this.amountCard,
      discount: data.discount.present ? data.discount.value : this.discount,
      tip: data.tip.present ? data.tip.value : this.tip,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('amountCash: $amountCash, ')
          ..write('amountCard: $amountCard, ')
          ..write('discount: $discount, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    method,
    amountCash,
    amountCard,
    discount,
    tip,
    total,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.method == this.method &&
          other.amountCash == this.amountCash &&
          other.amountCard == this.amountCard &&
          other.discount == this.discount &&
          other.tip == this.tip &&
          other.total == this.total &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> method;
  final Value<double> amountCash;
  final Value<double> amountCard;
  final Value<double> discount;
  final Value<double> tip;
  final Value<double> total;
  final Value<DateTime> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.method = const Value.absent(),
    this.amountCash = const Value.absent(),
    this.amountCard = const Value.absent(),
    this.discount = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String method,
    this.amountCash = const Value.absent(),
    this.amountCard = const Value.absent(),
    this.discount = const Value.absent(),
    this.tip = const Value.absent(),
    required double total,
    this.createdAt = const Value.absent(),
  }) : orderId = Value(orderId),
       method = Value(method),
       total = Value(total);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? method,
    Expression<double>? amountCash,
    Expression<double>? amountCard,
    Expression<double>? discount,
    Expression<double>? tip,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (method != null) 'method': method,
      if (amountCash != null) 'amount_cash': amountCash,
      if (amountCard != null) 'amount_card': amountCard,
      if (discount != null) 'discount': discount,
      if (tip != null) 'tip': tip,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<String>? method,
    Value<double>? amountCash,
    Value<double>? amountCard,
    Value<double>? discount,
    Value<double>? tip,
    Value<double>? total,
    Value<DateTime>? createdAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      amountCash: amountCash ?? this.amountCash,
      amountCard: amountCard ?? this.amountCard,
      discount: discount ?? this.discount,
      tip: tip ?? this.tip,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (amountCash.present) {
      map['amount_cash'] = Variable<double>(amountCash.value);
    }
    if (amountCard.present) {
      map['amount_card'] = Variable<double>(amountCard.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tip.present) {
      map['tip'] = Variable<double>(tip.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('amountCash: $amountCash, ')
          ..write('amountCard: $amountCard, ')
          ..write('discount: $discount, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<int> paymentId = GeneratedColumn<int>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restaurantNameMeta = const VerificationMeta(
    'restaurantName',
  );
  @override
  late final GeneratedColumn<String> restaurantName = GeneratedColumn<String>(
    'restaurant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hallNameMeta = const VerificationMeta(
    'hallName',
  );
  @override
  late final GeneratedColumn<String> hallName = GeneratedColumn<String>(
    'hall_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceTableNameMeta = const VerificationMeta(
    'serviceTableName',
  );
  @override
  late final GeneratedColumn<String> serviceTableName = GeneratedColumn<String>(
    'service_table_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<double> tip = GeneratedColumn<double>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    paymentId,
    restaurantName,
    branchName,
    hallName,
    serviceTableName,
    customerName,
    subtotal,
    discount,
    tax,
    tip,
    total,
    paymentMethod,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('restaurant_name')) {
      context.handle(
        _restaurantNameMeta,
        restaurantName.isAcceptableOrUnknown(
          data['restaurant_name']!,
          _restaurantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantNameMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('hall_name')) {
      context.handle(
        _hallNameMeta,
        hallName.isAcceptableOrUnknown(data['hall_name']!, _hallNameMeta),
      );
    }
    if (data.containsKey('service_table_name')) {
      context.handle(
        _serviceTableNameMeta,
        serviceTableName.isAcceptableOrUnknown(
          data['service_table_name']!,
          _serviceTableNameMeta,
        ),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_id'],
      )!,
      restaurantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restaurant_name'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      hallName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hall_name'],
      ),
      serviceTableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_table_name'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tip'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final int orderId;
  final int paymentId;
  final String restaurantName;
  final String branchName;
  final String? hallName;
  final String? serviceTableName;
  final String? customerName;
  final double subtotal;
  final double discount;
  final double tax;
  final double tip;
  final double total;
  final String paymentMethod;
  final DateTime createdAt;
  const Receipt({
    required this.id,
    required this.orderId,
    required this.paymentId,
    required this.restaurantName,
    required this.branchName,
    this.hallName,
    this.serviceTableName,
    this.customerName,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.tip,
    required this.total,
    required this.paymentMethod,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['payment_id'] = Variable<int>(paymentId);
    map['restaurant_name'] = Variable<String>(restaurantName);
    map['branch_name'] = Variable<String>(branchName);
    if (!nullToAbsent || hallName != null) {
      map['hall_name'] = Variable<String>(hallName);
    }
    if (!nullToAbsent || serviceTableName != null) {
      map['service_table_name'] = Variable<String>(serviceTableName);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['tax'] = Variable<double>(tax);
    map['tip'] = Variable<double>(tip);
    map['total'] = Variable<double>(total);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      paymentId: Value(paymentId),
      restaurantName: Value(restaurantName),
      branchName: Value(branchName),
      hallName: hallName == null && nullToAbsent
          ? const Value.absent()
          : Value(hallName),
      serviceTableName: serviceTableName == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceTableName),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      subtotal: Value(subtotal),
      discount: Value(discount),
      tax: Value(tax),
      tip: Value(tip),
      total: Value(total),
      paymentMethod: Value(paymentMethod),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      paymentId: serializer.fromJson<int>(json['paymentId']),
      restaurantName: serializer.fromJson<String>(json['restaurantName']),
      branchName: serializer.fromJson<String>(json['branchName']),
      hallName: serializer.fromJson<String?>(json['hallName']),
      serviceTableName: serializer.fromJson<String?>(json['serviceTableName']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      tip: serializer.fromJson<double>(json['tip']),
      total: serializer.fromJson<double>(json['total']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'paymentId': serializer.toJson<int>(paymentId),
      'restaurantName': serializer.toJson<String>(restaurantName),
      'branchName': serializer.toJson<String>(branchName),
      'hallName': serializer.toJson<String?>(hallName),
      'serviceTableName': serializer.toJson<String?>(serviceTableName),
      'customerName': serializer.toJson<String?>(customerName),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'tip': serializer.toJson<double>(tip),
      'total': serializer.toJson<double>(total),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith({
    int? id,
    int? orderId,
    int? paymentId,
    String? restaurantName,
    String? branchName,
    Value<String?> hallName = const Value.absent(),
    Value<String?> serviceTableName = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    double? subtotal,
    double? discount,
    double? tax,
    double? tip,
    double? total,
    String? paymentMethod,
    DateTime? createdAt,
  }) => Receipt(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    paymentId: paymentId ?? this.paymentId,
    restaurantName: restaurantName ?? this.restaurantName,
    branchName: branchName ?? this.branchName,
    hallName: hallName.present ? hallName.value : this.hallName,
    serviceTableName: serviceTableName.present
        ? serviceTableName.value
        : this.serviceTableName,
    customerName: customerName.present ? customerName.value : this.customerName,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    tip: tip ?? this.tip,
    total: total ?? this.total,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      restaurantName: data.restaurantName.present
          ? data.restaurantName.value
          : this.restaurantName,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      hallName: data.hallName.present ? data.hallName.value : this.hallName,
      serviceTableName: data.serviceTableName.present
          ? data.serviceTableName.value
          : this.serviceTableName,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      tip: data.tip.present ? data.tip.value : this.tip,
      total: data.total.present ? data.total.value : this.total,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('paymentId: $paymentId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('branchName: $branchName, ')
          ..write('hallName: $hallName, ')
          ..write('serviceTableName: $serviceTableName, ')
          ..write('customerName: $customerName, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    paymentId,
    restaurantName,
    branchName,
    hallName,
    serviceTableName,
    customerName,
    subtotal,
    discount,
    tax,
    tip,
    total,
    paymentMethod,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.paymentId == this.paymentId &&
          other.restaurantName == this.restaurantName &&
          other.branchName == this.branchName &&
          other.hallName == this.hallName &&
          other.serviceTableName == this.serviceTableName &&
          other.customerName == this.customerName &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.tip == this.tip &&
          other.total == this.total &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> paymentId;
  final Value<String> restaurantName;
  final Value<String> branchName;
  final Value<String?> hallName;
  final Value<String?> serviceTableName;
  final Value<String?> customerName;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> tip;
  final Value<double> total;
  final Value<String> paymentMethod;
  final Value<DateTime> createdAt;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.restaurantName = const Value.absent(),
    this.branchName = const Value.absent(),
    this.hallName = const Value.absent(),
    this.serviceTableName = const Value.absent(),
    this.customerName = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int paymentId,
    required String restaurantName,
    required String branchName,
    this.hallName = const Value.absent(),
    this.serviceTableName = const Value.absent(),
    this.customerName = const Value.absent(),
    required double subtotal,
    required double discount,
    required double tax,
    required double tip,
    required double total,
    required String paymentMethod,
    this.createdAt = const Value.absent(),
  }) : orderId = Value(orderId),
       paymentId = Value(paymentId),
       restaurantName = Value(restaurantName),
       branchName = Value(branchName),
       subtotal = Value(subtotal),
       discount = Value(discount),
       tax = Value(tax),
       tip = Value(tip),
       total = Value(total),
       paymentMethod = Value(paymentMethod);
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? paymentId,
    Expression<String>? restaurantName,
    Expression<String>? branchName,
    Expression<String>? hallName,
    Expression<String>? serviceTableName,
    Expression<String>? customerName,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? tax,
    Expression<double>? tip,
    Expression<double>? total,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (paymentId != null) 'payment_id': paymentId,
      if (restaurantName != null) 'restaurant_name': restaurantName,
      if (branchName != null) 'branch_name': branchName,
      if (hallName != null) 'hall_name': hallName,
      if (serviceTableName != null) 'service_table_name': serviceTableName,
      if (customerName != null) 'customer_name': customerName,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (tip != null) 'tip': tip,
      if (total != null) 'total': total,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReceiptsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<int>? paymentId,
    Value<String>? restaurantName,
    Value<String>? branchName,
    Value<String?>? hallName,
    Value<String?>? serviceTableName,
    Value<String?>? customerName,
    Value<double>? subtotal,
    Value<double>? discount,
    Value<double>? tax,
    Value<double>? tip,
    Value<double>? total,
    Value<String>? paymentMethod,
    Value<DateTime>? createdAt,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      paymentId: paymentId ?? this.paymentId,
      restaurantName: restaurantName ?? this.restaurantName,
      branchName: branchName ?? this.branchName,
      hallName: hallName ?? this.hallName,
      serviceTableName: serviceTableName ?? this.serviceTableName,
      customerName: customerName ?? this.customerName,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      tip: tip ?? this.tip,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<int>(paymentId.value);
    }
    if (restaurantName.present) {
      map['restaurant_name'] = Variable<String>(restaurantName.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (hallName.present) {
      map['hall_name'] = Variable<String>(hallName.value);
    }
    if (serviceTableName.present) {
      map['service_table_name'] = Variable<String>(serviceTableName.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (tip.present) {
      map['tip'] = Variable<double>(tip.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('paymentId: $paymentId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('branchName: $branchName, ')
          ..write('hallName: $hallName, ')
          ..write('serviceTableName: $serviceTableName, ')
          ..write('customerName: $customerName, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientRoleMeta = const VerificationMeta(
    'recipientRole',
  );
  @override
  late final GeneratedColumn<String> recipientRole = GeneratedColumn<String>(
    'recipient_role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    senderName,
    recipientRole,
    title,
    body,
    isRead,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('recipient_role')) {
      context.handle(
        _recipientRoleMeta,
        recipientRole.isAcceptableOrUnknown(
          data['recipient_role']!,
          _recipientRoleMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      recipientRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_role'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final String senderName;
  final String? recipientRole;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  const Message({
    required this.id,
    required this.senderName,
    this.recipientRole,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sender_name'] = Variable<String>(senderName);
    if (!nullToAbsent || recipientRole != null) {
      map['recipient_role'] = Variable<String>(recipientRole);
    }
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      senderName: Value(senderName),
      recipientRole: recipientRole == null && nullToAbsent
          ? const Value.absent()
          : Value(recipientRole),
      title: Value(title),
      body: Value(body),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      senderName: serializer.fromJson<String>(json['senderName']),
      recipientRole: serializer.fromJson<String?>(json['recipientRole']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'senderName': serializer.toJson<String>(senderName),
      'recipientRole': serializer.toJson<String?>(recipientRole),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Message copyWith({
    int? id,
    String? senderName,
    Value<String?> recipientRole = const Value.absent(),
    String? title,
    String? body,
    bool? isRead,
    DateTime? createdAt,
  }) => Message(
    id: id ?? this.id,
    senderName: senderName ?? this.senderName,
    recipientRole: recipientRole.present
        ? recipientRole.value
        : this.recipientRole,
    title: title ?? this.title,
    body: body ?? this.body,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      recipientRole: data.recipientRole.present
          ? data.recipientRole.value
          : this.recipientRole,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('senderName: $senderName, ')
          ..write('recipientRole: $recipientRole, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    senderName,
    recipientRole,
    title,
    body,
    isRead,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.senderName == this.senderName &&
          other.recipientRole == this.recipientRole &&
          other.title == this.title &&
          other.body == this.body &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<String> senderName;
  final Value<String?> recipientRole;
  final Value<String> title;
  final Value<String> body;
  final Value<bool> isRead;
  final Value<DateTime> createdAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.senderName = const Value.absent(),
    this.recipientRole = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String senderName,
    this.recipientRole = const Value.absent(),
    required String title,
    required String body,
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : senderName = Value(senderName),
       title = Value(title),
       body = Value(body);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? senderName,
    Expression<String>? recipientRole,
    Expression<String>? title,
    Expression<String>? body,
    Expression<bool>? isRead,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (senderName != null) 'sender_name': senderName,
      if (recipientRole != null) 'recipient_role': recipientRole,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? senderName,
    Value<String?>? recipientRole,
    Value<String>? title,
    Value<String>? body,
    Value<bool>? isRead,
    Value<DateTime>? createdAt,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      recipientRole: recipientRole ?? this.recipientRole,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (recipientRole.present) {
      map['recipient_role'] = Variable<String>(recipientRole.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('senderName: $senderName, ')
          ..write('recipientRole: $recipientRole, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueEntriesTable extends SyncQueueEntries
    with TableInfo<$SyncQueueEntriesTable, SyncQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTableMeta = const VerificationMeta(
    'entityTable',
  );
  @override
  late final GeneratedColumn<String> entityTable = GeneratedColumn<String>(
    'entity_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityTable,
    entityId,
    operation,
    payload,
    synced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_table')) {
      context.handle(
        _entityTableMeta,
        entityTable.isAcceptableOrUnknown(
          data['entity_table']!,
          _entityTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entityTableMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_table'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueEntriesTable createAlias(String alias) {
    return $SyncQueueEntriesTable(attachedDatabase, alias);
  }
}

class SyncQueueEntry extends DataClass implements Insertable<SyncQueueEntry> {
  final int id;
  final String entityTable;
  final int entityId;
  final String operation;
  final String? payload;
  final bool synced;
  final DateTime createdAt;
  const SyncQueueEntry({
    required this.id,
    required this.entityTable,
    required this.entityId,
    required this.operation,
    this.payload,
    required this.synced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_table'] = Variable<String>(entityTable);
    map['entity_id'] = Variable<int>(entityId);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueEntriesCompanion(
      id: Value(id),
      entityTable: Value(entityTable),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueEntry(
      id: serializer.fromJson<int>(json['id']),
      entityTable: serializer.fromJson<String>(json['entityTable']),
      entityId: serializer.fromJson<int>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String?>(json['payload']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityTable': serializer.toJson<String>(entityTable),
      'entityId': serializer.toJson<int>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String?>(payload),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueEntry copyWith({
    int? id,
    String? entityTable,
    int? entityId,
    String? operation,
    Value<String?> payload = const Value.absent(),
    bool? synced,
    DateTime? createdAt,
  }) => SyncQueueEntry(
    id: id ?? this.id,
    entityTable: entityTable ?? this.entityTable,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payload: payload.present ? payload.value : this.payload,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueEntry copyWithCompanion(SyncQueueEntriesCompanion data) {
    return SyncQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      entityTable: data.entityTable.present
          ? data.entityTable.value
          : this.entityTable,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntry(')
          ..write('id: $id, ')
          ..write('entityTable: $entityTable, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityTable,
    entityId,
    operation,
    payload,
    synced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueEntry &&
          other.id == this.id &&
          other.entityTable == this.entityTable &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class SyncQueueEntriesCompanion extends UpdateCompanion<SyncQueueEntry> {
  final Value<int> id;
  final Value<String> entityTable;
  final Value<int> entityId;
  final Value<String> operation;
  final Value<String?> payload;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  const SyncQueueEntriesCompanion({
    this.id = const Value.absent(),
    this.entityTable = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String entityTable,
    required int entityId,
    required String operation,
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entityTable = Value(entityTable),
       entityId = Value(entityId),
       operation = Value(operation);
  static Insertable<SyncQueueEntry> custom({
    Expression<int>? id,
    Expression<String>? entityTable,
    Expression<int>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityTable != null) 'entity_table': entityTable,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? entityTable,
    Value<int>? entityId,
    Value<String>? operation,
    Value<String?>? payload,
    Value<bool>? synced,
    Value<DateTime>? createdAt,
  }) {
    return SyncQueueEntriesCompanion(
      id: id ?? this.id,
      entityTable: entityTable ?? this.entityTable,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityTable.present) {
      map['entity_table'] = Variable<String>(entityTable.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntriesCompanion(')
          ..write('id: $id, ')
          ..write('entityTable: $entityTable, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalProfilesTable localProfiles = $LocalProfilesTable(this);
  late final $StaffTable staff = $StaffTable(this);
  late final $AppSettingsEntriesTable appSettingsEntries =
      $AppSettingsEntriesTable(this);
  late final $RestaurantsTable restaurants = $RestaurantsTable(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $HallsTable halls = $HallsTable(this);
  late final $ServiceTablesTable serviceTables = $ServiceTablesTable(this);
  late final $MenusTable menus = $MenusTable(this);
  late final $MenuCategoriesTable menuCategories = $MenuCategoriesTable(this);
  late final $MenuItemsTable menuItems = $MenuItemsTable(this);
  late final $MenuVariantsTable menuVariants = $MenuVariantsTable(this);
  late final $DiscountsTable discounts = $DiscountsTable(this);
  late final $ReservationsTable reservations = $ReservationsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SyncQueueEntriesTable syncQueueEntries = $SyncQueueEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localProfiles,
    staff,
    appSettingsEntries,
    restaurants,
    branches,
    halls,
    serviceTables,
    menus,
    menuCategories,
    menuItems,
    menuVariants,
    discounts,
    reservations,
    orders,
    orderItems,
    payments,
    receipts,
    messages,
    syncQueueEntries,
  ];
}

typedef $$LocalProfilesTableCreateCompanionBuilder =
    LocalProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      required String passwordHash,
      Value<DateTime> createdAt,
    });
typedef $$LocalProfilesTableUpdateCompanionBuilder =
    LocalProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> passwordHash,
      Value<DateTime> createdAt,
    });

class $$LocalProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableFilterComposer({
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableAnnotationComposer({
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

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProfilesTable,
          LocalProfile,
          $$LocalProfilesTableFilterComposer,
          $$LocalProfilesTableOrderingComposer,
          $$LocalProfilesTableAnnotationComposer,
          $$LocalProfilesTableCreateCompanionBuilder,
          $$LocalProfilesTableUpdateCompanionBuilder,
          (
            LocalProfile,
            BaseReferences<_$AppDatabase, $LocalProfilesTable, LocalProfile>,
          ),
          LocalProfile,
          PrefetchHooks Function()
        > {
  $$LocalProfilesTableTableManager(_$AppDatabase db, $LocalProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocalProfilesCompanion(
                id: id,
                name: name,
                email: email,
                passwordHash: passwordHash,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String passwordHash,
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocalProfilesCompanion.insert(
                id: id,
                name: name,
                email: email,
                passwordHash: passwordHash,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProfilesTable,
      LocalProfile,
      $$LocalProfilesTableFilterComposer,
      $$LocalProfilesTableOrderingComposer,
      $$LocalProfilesTableAnnotationComposer,
      $$LocalProfilesTableCreateCompanionBuilder,
      $$LocalProfilesTableUpdateCompanionBuilder,
      (
        LocalProfile,
        BaseReferences<_$AppDatabase, $LocalProfilesTable, LocalProfile>,
      ),
      LocalProfile,
      PrefetchHooks Function()
    >;
typedef $$StaffTableCreateCompanionBuilder =
    StaffCompanion Function({
      Value<int> id,
      required int restaurantId,
      Value<int?> linkedProfileId,
      required String name,
      Value<String?> phone,
      required String role,
      Value<String?> pin,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$StaffTableUpdateCompanionBuilder =
    StaffCompanion Function({
      Value<int> id,
      Value<int> restaurantId,
      Value<int?> linkedProfileId,
      Value<String> name,
      Value<String?> phone,
      Value<String> role,
      Value<String?> pin,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$StaffTableFilterComposer extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableFilterComposer({
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

  ColumnFilters<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get linkedProfileId => $composableBuilder(
    column: $table.linkedProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableOrderingComposer({
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

  ColumnOrderings<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get linkedProfileId => $composableBuilder(
    column: $table.linkedProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get linkedProfileId => $composableBuilder(
    column: $table.linkedProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StaffTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffTable,
          StaffMember,
          $$StaffTableFilterComposer,
          $$StaffTableOrderingComposer,
          $$StaffTableAnnotationComposer,
          $$StaffTableCreateCompanionBuilder,
          $$StaffTableUpdateCompanionBuilder,
          (
            StaffMember,
            BaseReferences<_$AppDatabase, $StaffTable, StaffMember>,
          ),
          StaffMember,
          PrefetchHooks Function()
        > {
  $$StaffTableTableManager(_$AppDatabase db, $StaffTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> restaurantId = const Value.absent(),
                Value<int?> linkedProfileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> pin = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StaffCompanion(
                id: id,
                restaurantId: restaurantId,
                linkedProfileId: linkedProfileId,
                name: name,
                phone: phone,
                role: role,
                pin: pin,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int restaurantId,
                Value<int?> linkedProfileId = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                required String role,
                Value<String?> pin = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StaffCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                linkedProfileId: linkedProfileId,
                name: name,
                phone: phone,
                role: role,
                pin: pin,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffTable,
      StaffMember,
      $$StaffTableFilterComposer,
      $$StaffTableOrderingComposer,
      $$StaffTableAnnotationComposer,
      $$StaffTableCreateCompanionBuilder,
      $$StaffTableUpdateCompanionBuilder,
      (StaffMember, BaseReferences<_$AppDatabase, $StaffTable, StaffMember>),
      StaffMember,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsEntriesTableCreateCompanionBuilder =
    AppSettingsEntriesCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$AppSettingsEntriesTableUpdateCompanionBuilder =
    AppSettingsEntriesCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$AppSettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsEntriesTable,
          AppSettingsEntry,
          $$AppSettingsEntriesTableFilterComposer,
          $$AppSettingsEntriesTableOrderingComposer,
          $$AppSettingsEntriesTableAnnotationComposer,
          $$AppSettingsEntriesTableCreateCompanionBuilder,
          $$AppSettingsEntriesTableUpdateCompanionBuilder,
          (
            AppSettingsEntry,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsEntriesTable,
              AppSettingsEntry
            >,
          ),
          AppSettingsEntry,
          PrefetchHooks Function()
        > {
  $$AppSettingsEntriesTableTableManager(
    _$AppDatabase db,
    $AppSettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsEntriesCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsEntriesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsEntriesTable,
      AppSettingsEntry,
      $$AppSettingsEntriesTableFilterComposer,
      $$AppSettingsEntriesTableOrderingComposer,
      $$AppSettingsEntriesTableAnnotationComposer,
      $$AppSettingsEntriesTableCreateCompanionBuilder,
      $$AppSettingsEntriesTableUpdateCompanionBuilder,
      (
        AppSettingsEntry,
        BaseReferences<
          _$AppDatabase,
          $AppSettingsEntriesTable,
          AppSettingsEntry
        >,
      ),
      AppSettingsEntry,
      PrefetchHooks Function()
    >;
typedef $$RestaurantsTableCreateCompanionBuilder =
    RestaurantsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> address,
      Value<String> currency,
      Value<String> language,
      Value<double> taxPercent,
      Value<String?> workingHoursOpen,
      Value<String?> workingHoursClose,
      Value<DateTime> createdAt,
    });
typedef $$RestaurantsTableUpdateCompanionBuilder =
    RestaurantsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> address,
      Value<String> currency,
      Value<String> language,
      Value<double> taxPercent,
      Value<String?> workingHoursOpen,
      Value<String?> workingHoursClose,
      Value<DateTime> createdAt,
    });

class $$RestaurantsTableFilterComposer
    extends Composer<_$AppDatabase, $RestaurantsTable> {
  $$RestaurantsTableFilterComposer({
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

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RestaurantsTableOrderingComposer
    extends Composer<_$AppDatabase, $RestaurantsTable> {
  $$RestaurantsTableOrderingComposer({
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

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RestaurantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestaurantsTable> {
  $$RestaurantsTableAnnotationComposer({
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

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RestaurantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RestaurantsTable,
          Restaurant,
          $$RestaurantsTableFilterComposer,
          $$RestaurantsTableOrderingComposer,
          $$RestaurantsTableAnnotationComposer,
          $$RestaurantsTableCreateCompanionBuilder,
          $$RestaurantsTableUpdateCompanionBuilder,
          (
            Restaurant,
            BaseReferences<_$AppDatabase, $RestaurantsTable, Restaurant>,
          ),
          Restaurant,
          PrefetchHooks Function()
        > {
  $$RestaurantsTableTableManager(_$AppDatabase db, $RestaurantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestaurantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestaurantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestaurantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<String?> workingHoursOpen = const Value.absent(),
                Value<String?> workingHoursClose = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RestaurantsCompanion(
                id: id,
                name: name,
                address: address,
                currency: currency,
                language: language,
                taxPercent: taxPercent,
                workingHoursOpen: workingHoursOpen,
                workingHoursClose: workingHoursClose,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<String?> workingHoursOpen = const Value.absent(),
                Value<String?> workingHoursClose = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RestaurantsCompanion.insert(
                id: id,
                name: name,
                address: address,
                currency: currency,
                language: language,
                taxPercent: taxPercent,
                workingHoursOpen: workingHoursOpen,
                workingHoursClose: workingHoursClose,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RestaurantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RestaurantsTable,
      Restaurant,
      $$RestaurantsTableFilterComposer,
      $$RestaurantsTableOrderingComposer,
      $$RestaurantsTableAnnotationComposer,
      $$RestaurantsTableCreateCompanionBuilder,
      $$RestaurantsTableUpdateCompanionBuilder,
      (
        Restaurant,
        BaseReferences<_$AppDatabase, $RestaurantsTable, Restaurant>,
      ),
      Restaurant,
      PrefetchHooks Function()
    >;
typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      Value<int> id,
      required int restaurantId,
      required String name,
      Value<String?> address,
      Value<String?> workingHoursOpen,
      Value<String?> workingHoursClose,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<int> id,
      Value<int> restaurantId,
      Value<String> name,
      Value<String?> address,
      Value<String?> workingHoursOpen,
      Value<String?> workingHoursClose,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
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

  ColumnFilters<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
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

  ColumnOrderings<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get workingHoursOpen => $composableBuilder(
    column: $table.workingHoursOpen,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workingHoursClose => $composableBuilder(
    column: $table.workingHoursClose,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branch,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
          Branch,
          PrefetchHooks Function()
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> restaurantId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> workingHoursOpen = const Value.absent(),
                Value<String?> workingHoursClose = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                restaurantId: restaurantId,
                name: name,
                address: address,
                workingHoursOpen: workingHoursOpen,
                workingHoursClose: workingHoursClose,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int restaurantId,
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> workingHoursOpen = const Value.absent(),
                Value<String?> workingHoursClose = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                name: name,
                address: address,
                workingHoursOpen: workingHoursOpen,
                workingHoursClose: workingHoursClose,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branch,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
      Branch,
      PrefetchHooks Function()
    >;
typedef $$HallsTableCreateCompanionBuilder =
    HallsCompanion Function({
      Value<int> id,
      required int branchId,
      required String name,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });
typedef $$HallsTableUpdateCompanionBuilder =
    HallsCompanion Function({
      Value<int> id,
      Value<int> branchId,
      Value<String> name,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

class $$HallsTableFilterComposer extends Composer<_$AppDatabase, $HallsTable> {
  $$HallsTableFilterComposer({
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

  ColumnFilters<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HallsTableOrderingComposer
    extends Composer<_$AppDatabase, $HallsTable> {
  $$HallsTableOrderingComposer({
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

  ColumnOrderings<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HallsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HallsTable> {
  $$HallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HallsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HallsTable,
          Hall,
          $$HallsTableFilterComposer,
          $$HallsTableOrderingComposer,
          $$HallsTableAnnotationComposer,
          $$HallsTableCreateCompanionBuilder,
          $$HallsTableUpdateCompanionBuilder,
          (Hall, BaseReferences<_$AppDatabase, $HallsTable, Hall>),
          Hall,
          PrefetchHooks Function()
        > {
  $$HallsTableTableManager(_$AppDatabase db, $HallsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HallsCompanion(
                id: id,
                branchId: branchId,
                name: name,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int branchId,
                required String name,
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HallsCompanion.insert(
                id: id,
                branchId: branchId,
                name: name,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HallsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HallsTable,
      Hall,
      $$HallsTableFilterComposer,
      $$HallsTableOrderingComposer,
      $$HallsTableAnnotationComposer,
      $$HallsTableCreateCompanionBuilder,
      $$HallsTableUpdateCompanionBuilder,
      (Hall, BaseReferences<_$AppDatabase, $HallsTable, Hall>),
      Hall,
      PrefetchHooks Function()
    >;
typedef $$ServiceTablesTableCreateCompanionBuilder =
    ServiceTablesCompanion Function({
      Value<int> id,
      required int hallId,
      required String name,
      Value<int> capacity,
      Value<String> status,
      Value<String?> notes,
      Value<int> sortOrder,
      Value<String> shape,
      Value<double> positionX,
      Value<double> positionY,
      Value<double> width,
      Value<double> height,
      Value<double> rotation,
      Value<DateTime> createdAt,
    });
typedef $$ServiceTablesTableUpdateCompanionBuilder =
    ServiceTablesCompanion Function({
      Value<int> id,
      Value<int> hallId,
      Value<String> name,
      Value<int> capacity,
      Value<String> status,
      Value<String?> notes,
      Value<int> sortOrder,
      Value<String> shape,
      Value<double> positionX,
      Value<double> positionY,
      Value<double> width,
      Value<double> height,
      Value<double> rotation,
      Value<DateTime> createdAt,
    });

class $$ServiceTablesTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceTablesTable> {
  $$ServiceTablesTableFilterComposer({
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

  ColumnFilters<int> get hallId => $composableBuilder(
    column: $table.hallId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shape => $composableBuilder(
    column: $table.shape,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionX => $composableBuilder(
    column: $table.positionX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionY => $composableBuilder(
    column: $table.positionY,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rotation => $composableBuilder(
    column: $table.rotation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceTablesTable> {
  $$ServiceTablesTableOrderingComposer({
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

  ColumnOrderings<int> get hallId => $composableBuilder(
    column: $table.hallId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shape => $composableBuilder(
    column: $table.shape,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionX => $composableBuilder(
    column: $table.positionX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionY => $composableBuilder(
    column: $table.positionY,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rotation => $composableBuilder(
    column: $table.rotation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceTablesTable> {
  $$ServiceTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hallId =>
      $composableBuilder(column: $table.hallId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get shape =>
      $composableBuilder(column: $table.shape, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get rotation =>
      $composableBuilder(column: $table.rotation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ServiceTablesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceTablesTable,
          ServiceTable,
          $$ServiceTablesTableFilterComposer,
          $$ServiceTablesTableOrderingComposer,
          $$ServiceTablesTableAnnotationComposer,
          $$ServiceTablesTableCreateCompanionBuilder,
          $$ServiceTablesTableUpdateCompanionBuilder,
          (
            ServiceTable,
            BaseReferences<_$AppDatabase, $ServiceTablesTable, ServiceTable>,
          ),
          ServiceTable,
          PrefetchHooks Function()
        > {
  $$ServiceTablesTableTableManager(_$AppDatabase db, $ServiceTablesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> hallId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> capacity = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> shape = const Value.absent(),
                Value<double> positionX = const Value.absent(),
                Value<double> positionY = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> rotation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ServiceTablesCompanion(
                id: id,
                hallId: hallId,
                name: name,
                capacity: capacity,
                status: status,
                notes: notes,
                sortOrder: sortOrder,
                shape: shape,
                positionX: positionX,
                positionY: positionY,
                width: width,
                height: height,
                rotation: rotation,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int hallId,
                required String name,
                Value<int> capacity = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> shape = const Value.absent(),
                Value<double> positionX = const Value.absent(),
                Value<double> positionY = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> rotation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ServiceTablesCompanion.insert(
                id: id,
                hallId: hallId,
                name: name,
                capacity: capacity,
                status: status,
                notes: notes,
                sortOrder: sortOrder,
                shape: shape,
                positionX: positionX,
                positionY: positionY,
                width: width,
                height: height,
                rotation: rotation,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceTablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceTablesTable,
      ServiceTable,
      $$ServiceTablesTableFilterComposer,
      $$ServiceTablesTableOrderingComposer,
      $$ServiceTablesTableAnnotationComposer,
      $$ServiceTablesTableCreateCompanionBuilder,
      $$ServiceTablesTableUpdateCompanionBuilder,
      (
        ServiceTable,
        BaseReferences<_$AppDatabase, $ServiceTablesTable, ServiceTable>,
      ),
      ServiceTable,
      PrefetchHooks Function()
    >;
typedef $$MenusTableCreateCompanionBuilder =
    MenusCompanion Function({
      Value<int> id,
      required int restaurantId,
      required String name,
      Value<bool> isActive,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$MenusTableUpdateCompanionBuilder =
    MenusCompanion Function({
      Value<int> id,
      Value<int> restaurantId,
      Value<String> name,
      Value<bool> isActive,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

class $$MenusTableFilterComposer extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableFilterComposer({
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

  ColumnFilters<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenusTableOrderingComposer
    extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableOrderingComposer({
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

  ColumnOrderings<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenusTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenusTable,
          RestaurantMenu,
          $$MenusTableFilterComposer,
          $$MenusTableOrderingComposer,
          $$MenusTableAnnotationComposer,
          $$MenusTableCreateCompanionBuilder,
          $$MenusTableUpdateCompanionBuilder,
          (
            RestaurantMenu,
            BaseReferences<_$AppDatabase, $MenusTable, RestaurantMenu>,
          ),
          RestaurantMenu,
          PrefetchHooks Function()
        > {
  $$MenusTableTableManager(_$AppDatabase db, $MenusTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> restaurantId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenusCompanion(
                id: id,
                restaurantId: restaurantId,
                name: name,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int restaurantId,
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenusCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                name: name,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenusTable,
      RestaurantMenu,
      $$MenusTableFilterComposer,
      $$MenusTableOrderingComposer,
      $$MenusTableAnnotationComposer,
      $$MenusTableCreateCompanionBuilder,
      $$MenusTableUpdateCompanionBuilder,
      (
        RestaurantMenu,
        BaseReferences<_$AppDatabase, $MenusTable, RestaurantMenu>,
      ),
      RestaurantMenu,
      PrefetchHooks Function()
    >;
typedef $$MenuCategoriesTableCreateCompanionBuilder =
    MenuCategoriesCompanion Function({
      Value<int> id,
      required int restaurantId,
      Value<int?> menuId,
      required String name,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$MenuCategoriesTableUpdateCompanionBuilder =
    MenuCategoriesCompanion Function({
      Value<int> id,
      Value<int> restaurantId,
      Value<int?> menuId,
      Value<String> name,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

class $$MenuCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTable> {
  $$MenuCategoriesTableFilterComposer({
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

  ColumnFilters<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get menuId => $composableBuilder(
    column: $table.menuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenuCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTable> {
  $$MenuCategoriesTableOrderingComposer({
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

  ColumnOrderings<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get menuId => $composableBuilder(
    column: $table.menuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenuCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTable> {
  $$MenuCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get menuId =>
      $composableBuilder(column: $table.menuId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenuCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuCategoriesTable,
          MenuCategory,
          $$MenuCategoriesTableFilterComposer,
          $$MenuCategoriesTableOrderingComposer,
          $$MenuCategoriesTableAnnotationComposer,
          $$MenuCategoriesTableCreateCompanionBuilder,
          $$MenuCategoriesTableUpdateCompanionBuilder,
          (
            MenuCategory,
            BaseReferences<_$AppDatabase, $MenuCategoriesTable, MenuCategory>,
          ),
          MenuCategory,
          PrefetchHooks Function()
        > {
  $$MenuCategoriesTableTableManager(
    _$AppDatabase db,
    $MenuCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> restaurantId = const Value.absent(),
                Value<int?> menuId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuCategoriesCompanion(
                id: id,
                restaurantId: restaurantId,
                menuId: menuId,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int restaurantId,
                Value<int?> menuId = const Value.absent(),
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuCategoriesCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                menuId: menuId,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenuCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuCategoriesTable,
      MenuCategory,
      $$MenuCategoriesTableFilterComposer,
      $$MenuCategoriesTableOrderingComposer,
      $$MenuCategoriesTableAnnotationComposer,
      $$MenuCategoriesTableCreateCompanionBuilder,
      $$MenuCategoriesTableUpdateCompanionBuilder,
      (
        MenuCategory,
        BaseReferences<_$AppDatabase, $MenuCategoriesTable, MenuCategory>,
      ),
      MenuCategory,
      PrefetchHooks Function()
    >;
typedef $$MenuItemsTableCreateCompanionBuilder =
    MenuItemsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String?> description,
      required double price,
      Value<double> taxPercent,
      Value<bool> isAvailable,
      Value<bool> isDrink,
      Value<String?> imagePath,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$MenuItemsTableUpdateCompanionBuilder =
    MenuItemsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String?> description,
      Value<double> price,
      Value<double> taxPercent,
      Value<bool> isAvailable,
      Value<bool> isDrink,
      Value<String?> imagePath,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

class $$MenuItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableFilterComposer({
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

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDrink => $composableBuilder(
    column: $table.isDrink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenuItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableOrderingComposer({
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

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDrink => $composableBuilder(
    column: $table.isDrink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenuItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDrink =>
      $composableBuilder(column: $table.isDrink, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenuItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuItemsTable,
          MenuItem,
          $$MenuItemsTableFilterComposer,
          $$MenuItemsTableOrderingComposer,
          $$MenuItemsTableAnnotationComposer,
          $$MenuItemsTableCreateCompanionBuilder,
          $$MenuItemsTableUpdateCompanionBuilder,
          (MenuItem, BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem>),
          MenuItem,
          PrefetchHooks Function()
        > {
  $$MenuItemsTableTableManager(_$AppDatabase db, $MenuItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<bool> isDrink = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuItemsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                price: price,
                taxPercent: taxPercent,
                isAvailable: isAvailable,
                isDrink: isDrink,
                imagePath: imagePath,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
                required double price,
                Value<double> taxPercent = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<bool> isDrink = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuItemsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                price: price,
                taxPercent: taxPercent,
                isAvailable: isAvailable,
                isDrink: isDrink,
                imagePath: imagePath,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenuItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuItemsTable,
      MenuItem,
      $$MenuItemsTableFilterComposer,
      $$MenuItemsTableOrderingComposer,
      $$MenuItemsTableAnnotationComposer,
      $$MenuItemsTableCreateCompanionBuilder,
      $$MenuItemsTableUpdateCompanionBuilder,
      (MenuItem, BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem>),
      MenuItem,
      PrefetchHooks Function()
    >;
typedef $$MenuVariantsTableCreateCompanionBuilder =
    MenuVariantsCompanion Function({
      Value<int> id,
      required int itemId,
      required String name,
      Value<double> priceDelta,
      Value<DateTime> createdAt,
    });
typedef $$MenuVariantsTableUpdateCompanionBuilder =
    MenuVariantsCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<String> name,
      Value<double> priceDelta,
      Value<DateTime> createdAt,
    });

class $$MenuVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuVariantsTable> {
  $$MenuVariantsTableFilterComposer({
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

  ColumnFilters<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceDelta => $composableBuilder(
    column: $table.priceDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenuVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuVariantsTable> {
  $$MenuVariantsTableOrderingComposer({
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

  ColumnOrderings<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceDelta => $composableBuilder(
    column: $table.priceDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenuVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuVariantsTable> {
  $$MenuVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get priceDelta => $composableBuilder(
    column: $table.priceDelta,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenuVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuVariantsTable,
          MenuVariant,
          $$MenuVariantsTableFilterComposer,
          $$MenuVariantsTableOrderingComposer,
          $$MenuVariantsTableAnnotationComposer,
          $$MenuVariantsTableCreateCompanionBuilder,
          $$MenuVariantsTableUpdateCompanionBuilder,
          (
            MenuVariant,
            BaseReferences<_$AppDatabase, $MenuVariantsTable, MenuVariant>,
          ),
          MenuVariant,
          PrefetchHooks Function()
        > {
  $$MenuVariantsTableTableManager(_$AppDatabase db, $MenuVariantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> priceDelta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuVariantsCompanion(
                id: id,
                itemId: itemId,
                name: name,
                priceDelta: priceDelta,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required String name,
                Value<double> priceDelta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenuVariantsCompanion.insert(
                id: id,
                itemId: itemId,
                name: name,
                priceDelta: priceDelta,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenuVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuVariantsTable,
      MenuVariant,
      $$MenuVariantsTableFilterComposer,
      $$MenuVariantsTableOrderingComposer,
      $$MenuVariantsTableAnnotationComposer,
      $$MenuVariantsTableCreateCompanionBuilder,
      $$MenuVariantsTableUpdateCompanionBuilder,
      (
        MenuVariant,
        BaseReferences<_$AppDatabase, $MenuVariantsTable, MenuVariant>,
      ),
      MenuVariant,
      PrefetchHooks Function()
    >;
typedef $$DiscountsTableCreateCompanionBuilder =
    DiscountsCompanion Function({
      Value<int> id,
      required int restaurantId,
      required String name,
      required String type,
      required double value,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$DiscountsTableUpdateCompanionBuilder =
    DiscountsCompanion Function({
      Value<int> id,
      Value<int> restaurantId,
      Value<String> name,
      Value<String> type,
      Value<double> value,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$DiscountsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableFilterComposer({
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

  ColumnFilters<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiscountsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableOrderingComposer({
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

  ColumnOrderings<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiscountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DiscountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscountsTable,
          Discount,
          $$DiscountsTableFilterComposer,
          $$DiscountsTableOrderingComposer,
          $$DiscountsTableAnnotationComposer,
          $$DiscountsTableCreateCompanionBuilder,
          $$DiscountsTableUpdateCompanionBuilder,
          (Discount, BaseReferences<_$AppDatabase, $DiscountsTable, Discount>),
          Discount,
          PrefetchHooks Function()
        > {
  $$DiscountsTableTableManager(_$AppDatabase db, $DiscountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> restaurantId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DiscountsCompanion(
                id: id,
                restaurantId: restaurantId,
                name: name,
                type: type,
                value: value,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int restaurantId,
                required String name,
                required String type,
                required double value,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DiscountsCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                name: name,
                type: type,
                value: value,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiscountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscountsTable,
      Discount,
      $$DiscountsTableFilterComposer,
      $$DiscountsTableOrderingComposer,
      $$DiscountsTableAnnotationComposer,
      $$DiscountsTableCreateCompanionBuilder,
      $$DiscountsTableUpdateCompanionBuilder,
      (Discount, BaseReferences<_$AppDatabase, $DiscountsTable, Discount>),
      Discount,
      PrefetchHooks Function()
    >;
typedef $$ReservationsTableCreateCompanionBuilder =
    ReservationsCompanion Function({
      Value<int> id,
      required int branchId,
      Value<int?> tableId,
      required String customerName,
      Value<String?> phone,
      required DateTime date,
      required String time,
      Value<int> guestCount,
      Value<String?> notes,
      Value<String> status,
      Value<DateTime> createdAt,
    });
typedef $$ReservationsTableUpdateCompanionBuilder =
    ReservationsCompanion Function({
      Value<int> id,
      Value<int> branchId,
      Value<int?> tableId,
      Value<String> customerName,
      Value<String?> phone,
      Value<DateTime> date,
      Value<String> time,
      Value<int> guestCount,
      Value<String?> notes,
      Value<String> status,
      Value<DateTime> createdAt,
    });

class $$ReservationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableFilterComposer({
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

  ColumnFilters<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tableId => $composableBuilder(
    column: $table.tableId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get guestCount => $composableBuilder(
    column: $table.guestCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableOrderingComposer({
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

  ColumnOrderings<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tableId => $composableBuilder(
    column: $table.tableId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get guestCount => $composableBuilder(
    column: $table.guestCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<int> get tableId =>
      $composableBuilder(column: $table.tableId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get guestCount => $composableBuilder(
    column: $table.guestCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReservationsTable,
          Reservation,
          $$ReservationsTableFilterComposer,
          $$ReservationsTableOrderingComposer,
          $$ReservationsTableAnnotationComposer,
          $$ReservationsTableCreateCompanionBuilder,
          $$ReservationsTableUpdateCompanionBuilder,
          (
            Reservation,
            BaseReferences<_$AppDatabase, $ReservationsTable, Reservation>,
          ),
          Reservation,
          PrefetchHooks Function()
        > {
  $$ReservationsTableTableManager(_$AppDatabase db, $ReservationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> branchId = const Value.absent(),
                Value<int?> tableId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<int> guestCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReservationsCompanion(
                id: id,
                branchId: branchId,
                tableId: tableId,
                customerName: customerName,
                phone: phone,
                date: date,
                time: time,
                guestCount: guestCount,
                notes: notes,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int branchId,
                Value<int?> tableId = const Value.absent(),
                required String customerName,
                Value<String?> phone = const Value.absent(),
                required DateTime date,
                required String time,
                Value<int> guestCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReservationsCompanion.insert(
                id: id,
                branchId: branchId,
                tableId: tableId,
                customerName: customerName,
                phone: phone,
                date: date,
                time: time,
                guestCount: guestCount,
                notes: notes,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReservationsTable,
      Reservation,
      $$ReservationsTableFilterComposer,
      $$ReservationsTableOrderingComposer,
      $$ReservationsTableAnnotationComposer,
      $$ReservationsTableCreateCompanionBuilder,
      $$ReservationsTableUpdateCompanionBuilder,
      (
        Reservation,
        BaseReferences<_$AppDatabase, $ReservationsTable, Reservation>,
      ),
      Reservation,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required int branchId,
      Value<int?> hallId,
      Value<int?> tableId,
      Value<String?> customerName,
      Value<String> status,
      Value<String?> comment,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> tax,
      Value<double> tip,
      Value<double> total,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<int> branchId,
      Value<int?> hallId,
      Value<int?> tableId,
      Value<String?> customerName,
      Value<String> status,
      Value<String?> comment,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> tax,
      Value<double> tip,
      Value<double> total,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
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

  ColumnFilters<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hallId => $composableBuilder(
    column: $table.hallId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tableId => $composableBuilder(
    column: $table.tableId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
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

  ColumnOrderings<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hallId => $composableBuilder(
    column: $table.hallId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tableId => $composableBuilder(
    column: $table.tableId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<int> get hallId =>
      $composableBuilder(column: $table.hallId, builder: (column) => column);

  GeneratedColumn<int> get tableId =>
      $composableBuilder(column: $table.tableId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
          Order,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> branchId = const Value.absent(),
                Value<int?> hallId = const Value.absent(),
                Value<int?> tableId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> tip = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                branchId: branchId,
                hallId: hallId,
                tableId: tableId,
                customerName: customerName,
                status: status,
                comment: comment,
                subtotal: subtotal,
                discount: discount,
                tax: tax,
                tip: tip,
                total: total,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int branchId,
                Value<int?> hallId = const Value.absent(),
                Value<int?> tableId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> tip = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                branchId: branchId,
                hallId: hallId,
                tableId: tableId,
                customerName: customerName,
                status: status,
                comment: comment,
                subtotal: subtotal,
                discount: discount,
                tax: tax,
                tip: tip,
                total: total,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
      Order,
      PrefetchHooks Function()
    >;
typedef $$OrderItemsTableCreateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> id,
      required int orderId,
      required int menuItemId,
      Value<int?> variantId,
      required String itemName,
      Value<String?> variantName,
      Value<int> quantity,
      required double unitPrice,
      Value<String?> comment,
      Value<bool> isDrink,
      Value<String> status,
      Value<DateTime> createdAt,
    });
typedef $$OrderItemsTableUpdateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<int> menuItemId,
      Value<int?> variantId,
      Value<String> itemName,
      Value<String?> variantName,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<String?> comment,
      Value<bool> isDrink,
      Value<String> status,
      Value<DateTime> createdAt,
    });

class $$OrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
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

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get menuItemId => $composableBuilder(
    column: $table.menuItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDrink => $composableBuilder(
    column: $table.isDrink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
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

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get menuItemId => $composableBuilder(
    column: $table.menuItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDrink => $composableBuilder(
    column: $table.isDrink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get menuItemId => $composableBuilder(
    column: $table.menuItemId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get isDrink =>
      $composableBuilder(column: $table.isDrink, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderItemsTable,
          OrderItem,
          $$OrderItemsTableFilterComposer,
          $$OrderItemsTableOrderingComposer,
          $$OrderItemsTableAnnotationComposer,
          $$OrderItemsTableCreateCompanionBuilder,
          $$OrderItemsTableUpdateCompanionBuilder,
          (
            OrderItem,
            BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem>,
          ),
          OrderItem,
          PrefetchHooks Function()
        > {
  $$OrderItemsTableTableManager(_$AppDatabase db, $OrderItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> menuItemId = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<String> itemName = const Value.absent(),
                Value<String?> variantName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool> isDrink = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OrderItemsCompanion(
                id: id,
                orderId: orderId,
                menuItemId: menuItemId,
                variantId: variantId,
                itemName: itemName,
                variantName: variantName,
                quantity: quantity,
                unitPrice: unitPrice,
                comment: comment,
                isDrink: isDrink,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required int menuItemId,
                Value<int?> variantId = const Value.absent(),
                required String itemName,
                Value<String?> variantName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                required double unitPrice,
                Value<String?> comment = const Value.absent(),
                Value<bool> isDrink = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OrderItemsCompanion.insert(
                id: id,
                orderId: orderId,
                menuItemId: menuItemId,
                variantId: variantId,
                itemName: itemName,
                variantName: variantName,
                quantity: quantity,
                unitPrice: unitPrice,
                comment: comment,
                isDrink: isDrink,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderItemsTable,
      OrderItem,
      $$OrderItemsTableFilterComposer,
      $$OrderItemsTableOrderingComposer,
      $$OrderItemsTableAnnotationComposer,
      $$OrderItemsTableCreateCompanionBuilder,
      $$OrderItemsTableUpdateCompanionBuilder,
      (OrderItem, BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem>),
      OrderItem,
      PrefetchHooks Function()
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int orderId,
      required String method,
      Value<double> amountCash,
      Value<double> amountCard,
      Value<double> discount,
      Value<double> tip,
      required double total,
      Value<DateTime> createdAt,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<String> method,
      Value<double> amountCash,
      Value<double> amountCard,
      Value<double> discount,
      Value<double> tip,
      Value<double> total,
      Value<DateTime> createdAt,
    });

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountCash => $composableBuilder(
    column: $table.amountCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountCard => $composableBuilder(
    column: $table.amountCard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountCash => $composableBuilder(
    column: $table.amountCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountCard => $composableBuilder(
    column: $table.amountCard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<double> get amountCash => $composableBuilder(
    column: $table.amountCash,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountCard => $composableBuilder(
    column: $table.amountCard,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, BaseReferences<_$AppDatabase, $PaymentsTable, Payment>),
          Payment,
          PrefetchHooks Function()
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<double> amountCash = const Value.absent(),
                Value<double> amountCard = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tip = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                orderId: orderId,
                method: method,
                amountCash: amountCash,
                amountCard: amountCard,
                discount: discount,
                tip: tip,
                total: total,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required String method,
                Value<double> amountCash = const Value.absent(),
                Value<double> amountCard = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tip = const Value.absent(),
                required double total,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                orderId: orderId,
                method: method,
                amountCash: amountCash,
                amountCard: amountCard,
                discount: discount,
                tip: tip,
                total: total,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, BaseReferences<_$AppDatabase, $PaymentsTable, Payment>),
      Payment,
      PrefetchHooks Function()
    >;
typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<int> id,
      required int orderId,
      required int paymentId,
      required String restaurantName,
      required String branchName,
      Value<String?> hallName,
      Value<String?> serviceTableName,
      Value<String?> customerName,
      required double subtotal,
      required double discount,
      required double tax,
      required double tip,
      required double total,
      required String paymentMethod,
      Value<DateTime> createdAt,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<int> paymentId,
      Value<String> restaurantName,
      Value<String> branchName,
      Value<String?> hallName,
      Value<String?> serviceTableName,
      Value<String?> customerName,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> tax,
      Value<double> tip,
      Value<double> total,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
    });

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
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

  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hallName => $composableBuilder(
    column: $table.hallName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceTableName => $composableBuilder(
    column: $table.serviceTableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
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

  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hallName => $composableBuilder(
    column: $table.hallName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceTableName => $composableBuilder(
    column: $table.serviceTableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hallName =>
      $composableBuilder(column: $table.hallName, builder: (column) => column);

  GeneratedColumn<String> get serviceTableName => $composableBuilder(
    column: $table.serviceTableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
          Receipt,
          PrefetchHooks Function()
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> paymentId = const Value.absent(),
                Value<String> restaurantName = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<String?> hallName = const Value.absent(),
                Value<String?> serviceTableName = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> tip = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                orderId: orderId,
                paymentId: paymentId,
                restaurantName: restaurantName,
                branchName: branchName,
                hallName: hallName,
                serviceTableName: serviceTableName,
                customerName: customerName,
                subtotal: subtotal,
                discount: discount,
                tax: tax,
                tip: tip,
                total: total,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required int paymentId,
                required String restaurantName,
                required String branchName,
                Value<String?> hallName = const Value.absent(),
                Value<String?> serviceTableName = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                required double subtotal,
                required double discount,
                required double tax,
                required double tip,
                required double total,
                required String paymentMethod,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                orderId: orderId,
                paymentId: paymentId,
                restaurantName: restaurantName,
                branchName: branchName,
                hallName: hallName,
                serviceTableName: serviceTableName,
                customerName: customerName,
                subtotal: subtotal,
                discount: discount,
                tax: tax,
                tip: tip,
                total: total,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
      Receipt,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      required String senderName,
      Value<String?> recipientRole,
      required String title,
      required String body,
      Value<bool> isRead,
      Value<DateTime> createdAt,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<String> senderName,
      Value<String?> recipientRole,
      Value<String> title,
      Value<String> body,
      Value<bool> isRead,
      Value<DateTime> createdAt,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
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

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientRole => $composableBuilder(
    column: $table.recipientRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
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

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientRole => $composableBuilder(
    column: $table.recipientRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipientRole => $composableBuilder(
    column: $table.recipientRole,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String?> recipientRole = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                senderName: senderName,
                recipientRole: recipientRole,
                title: title,
                body: body,
                isRead: isRead,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String senderName,
                Value<String?> recipientRole = const Value.absent(),
                required String title,
                required String body,
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                senderName: senderName,
                recipientRole: recipientRole,
                title: title,
                body: body,
                isRead: isRead,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueEntriesTableCreateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      Value<int> id,
      required String entityTable,
      required int entityId,
      required String operation,
      Value<String?> payload,
      Value<bool> synced,
      Value<DateTime> createdAt,
    });
typedef $$SyncQueueEntriesTableUpdateCompanionBuilder =
    SyncQueueEntriesCompanion Function({
      Value<int> id,
      Value<String> entityTable,
      Value<int> entityId,
      Value<String> operation,
      Value<String?> payload,
      Value<bool> synced,
      Value<DateTime> createdAt,
    });

class $$SyncQueueEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableFilterComposer({
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

  ColumnFilters<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueEntriesTable> {
  $$SyncQueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueEntriesTable,
          SyncQueueEntry,
          $$SyncQueueEntriesTableFilterComposer,
          $$SyncQueueEntriesTableOrderingComposer,
          $$SyncQueueEntriesTableAnnotationComposer,
          $$SyncQueueEntriesTableCreateCompanionBuilder,
          $$SyncQueueEntriesTableUpdateCompanionBuilder,
          (
            SyncQueueEntry,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueEntriesTable,
              SyncQueueEntry
            >,
          ),
          SyncQueueEntry,
          PrefetchHooks Function()
        > {
  $$SyncQueueEntriesTableTableManager(
    _$AppDatabase db,
    $SyncQueueEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityTable = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueEntriesCompanion(
                id: id,
                entityTable: entityTable,
                entityId: entityId,
                operation: operation,
                payload: payload,
                synced: synced,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityTable,
                required int entityId,
                required String operation,
                Value<String?> payload = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueEntriesCompanion.insert(
                id: id,
                entityTable: entityTable,
                entityId: entityId,
                operation: operation,
                payload: payload,
                synced: synced,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueEntriesTable,
      SyncQueueEntry,
      $$SyncQueueEntriesTableFilterComposer,
      $$SyncQueueEntriesTableOrderingComposer,
      $$SyncQueueEntriesTableAnnotationComposer,
      $$SyncQueueEntriesTableCreateCompanionBuilder,
      $$SyncQueueEntriesTableUpdateCompanionBuilder,
      (
        SyncQueueEntry,
        BaseReferences<_$AppDatabase, $SyncQueueEntriesTable, SyncQueueEntry>,
      ),
      SyncQueueEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalProfilesTableTableManager get localProfiles =>
      $$LocalProfilesTableTableManager(_db, _db.localProfiles);
  $$StaffTableTableManager get staff =>
      $$StaffTableTableManager(_db, _db.staff);
  $$AppSettingsEntriesTableTableManager get appSettingsEntries =>
      $$AppSettingsEntriesTableTableManager(_db, _db.appSettingsEntries);
  $$RestaurantsTableTableManager get restaurants =>
      $$RestaurantsTableTableManager(_db, _db.restaurants);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$HallsTableTableManager get halls =>
      $$HallsTableTableManager(_db, _db.halls);
  $$ServiceTablesTableTableManager get serviceTables =>
      $$ServiceTablesTableTableManager(_db, _db.serviceTables);
  $$MenusTableTableManager get menus =>
      $$MenusTableTableManager(_db, _db.menus);
  $$MenuCategoriesTableTableManager get menuCategories =>
      $$MenuCategoriesTableTableManager(_db, _db.menuCategories);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db, _db.menuItems);
  $$MenuVariantsTableTableManager get menuVariants =>
      $$MenuVariantsTableTableManager(_db, _db.menuVariants);
  $$DiscountsTableTableManager get discounts =>
      $$DiscountsTableTableManager(_db, _db.discounts);
  $$ReservationsTableTableManager get reservations =>
      $$ReservationsTableTableManager(_db, _db.reservations);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderItemsTableTableManager get orderItems =>
      $$OrderItemsTableTableManager(_db, _db.orderItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SyncQueueEntriesTableTableManager get syncQueueEntries =>
      $$SyncQueueEntriesTableTableManager(_db, _db.syncQueueEntries);
}
