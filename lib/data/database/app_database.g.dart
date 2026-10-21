// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, Challenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 40),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetAmountCentsMeta =
      const VerificationMeta('targetAmountCents');
  @override
  late final GeneratedColumn<int> targetAmountCents = GeneratedColumn<int>(
      'target_amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentAmountCentsMeta =
      const VerificationMeta('currentAmountCents');
  @override
  late final GeneratedColumn<int> currentAmountCents = GeneratedColumn<int>(
      'current_amount_cents', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#B026FF'));
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
      'icon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('savings'));
  static const VerificationMeta _iconPathMeta =
      const VerificationMeta('iconPath');
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
      'icon_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _milestone25NotifiedMeta =
      const VerificationMeta('milestone25Notified');
  @override
  late final GeneratedColumn<bool> milestone25Notified = GeneratedColumn<bool>(
      'milestone25_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("milestone25_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _milestone50NotifiedMeta =
      const VerificationMeta('milestone50Notified');
  @override
  late final GeneratedColumn<bool> milestone50Notified = GeneratedColumn<bool>(
      'milestone50_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("milestone50_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _milestone75NotifiedMeta =
      const VerificationMeta('milestone75Notified');
  @override
  late final GeneratedColumn<bool> milestone75Notified = GeneratedColumn<bool>(
      'milestone75_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("milestone75_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nearCompletionNotifiedMeta =
      const VerificationMeta('nearCompletionNotified');
  @override
  late final GeneratedColumn<bool> nearCompletionNotified =
      GeneratedColumn<bool>('near_completion_notified', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("near_completion_notified" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _completionNotifiedMeta =
      const VerificationMeta('completionNotified');
  @override
  late final GeneratedColumn<bool> completionNotified = GeneratedColumn<bool>(
      'completion_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("completion_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        targetAmountCents,
        currentAmountCents,
        startDate,
        targetDate,
        frequency,
        status,
        colorHex,
        iconId,
        iconPath,
        milestone25Notified,
        milestone50Notified,
        milestone75Notified,
        nearCompletionNotified,
        completionNotified,
        createdAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(Insertable<Challenge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('target_amount_cents')) {
      context.handle(
          _targetAmountCentsMeta,
          targetAmountCents.isAcceptableOrUnknown(
              data['target_amount_cents']!, _targetAmountCentsMeta));
    } else if (isInserting) {
      context.missing(_targetAmountCentsMeta);
    }
    if (data.containsKey('current_amount_cents')) {
      context.handle(
          _currentAmountCentsMeta,
          currentAmountCents.isAcceptableOrUnknown(
              data['current_amount_cents']!, _currentAmountCentsMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    } else if (isInserting) {
      context.missing(_targetDateMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('icon_id')) {
      context.handle(_iconIdMeta,
          iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta));
    }
    if (data.containsKey('icon_path')) {
      context.handle(_iconPathMeta,
          iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta));
    }
    if (data.containsKey('milestone25_notified')) {
      context.handle(
          _milestone25NotifiedMeta,
          milestone25Notified.isAcceptableOrUnknown(
              data['milestone25_notified']!, _milestone25NotifiedMeta));
    }
    if (data.containsKey('milestone50_notified')) {
      context.handle(
          _milestone50NotifiedMeta,
          milestone50Notified.isAcceptableOrUnknown(
              data['milestone50_notified']!, _milestone50NotifiedMeta));
    }
    if (data.containsKey('milestone75_notified')) {
      context.handle(
          _milestone75NotifiedMeta,
          milestone75Notified.isAcceptableOrUnknown(
              data['milestone75_notified']!, _milestone75NotifiedMeta));
    }
    if (data.containsKey('near_completion_notified')) {
      context.handle(
          _nearCompletionNotifiedMeta,
          nearCompletionNotified.isAcceptableOrUnknown(
              data['near_completion_notified']!, _nearCompletionNotifiedMeta));
    }
    if (data.containsKey('completion_notified')) {
      context.handle(
          _completionNotifiedMeta,
          completionNotified.isAcceptableOrUnknown(
              data['completion_notified']!, _completionNotifiedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Challenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Challenge(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      targetAmountCents: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}target_amount_cents'])!,
      currentAmountCents: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_amount_cents'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      iconId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_id'])!,
      iconPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_path']),
      milestone25Notified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}milestone25_notified'])!,
      milestone50Notified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}milestone50_notified'])!,
      milestone75Notified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}milestone75_notified'])!,
      nearCompletionNotified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}near_completion_notified'])!,
      completionNotified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}completion_notified'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class Challenge extends DataClass implements Insertable<Challenge> {
  final String id;
  final String name;
  final String? description;
  final int targetAmountCents;
  final int currentAmountCents;
  final DateTime startDate;
  final DateTime targetDate;
  final String frequency;
  final String status;
  final String colorHex;
  final String iconId;
  final String? iconPath;
  final bool milestone25Notified;
  final bool milestone50Notified;
  final bool milestone75Notified;
  final bool nearCompletionNotified;
  final bool completionNotified;
  final DateTime createdAt;
  final DateTime? completedAt;
  const Challenge(
      {required this.id,
      required this.name,
      this.description,
      required this.targetAmountCents,
      required this.currentAmountCents,
      required this.startDate,
      required this.targetDate,
      required this.frequency,
      required this.status,
      required this.colorHex,
      required this.iconId,
      this.iconPath,
      required this.milestone25Notified,
      required this.milestone50Notified,
      required this.milestone75Notified,
      required this.nearCompletionNotified,
      required this.completionNotified,
      required this.createdAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['target_amount_cents'] = Variable<int>(targetAmountCents);
    map['current_amount_cents'] = Variable<int>(currentAmountCents);
    map['start_date'] = Variable<DateTime>(startDate);
    map['target_date'] = Variable<DateTime>(targetDate);
    map['frequency'] = Variable<String>(frequency);
    map['status'] = Variable<String>(status);
    map['color_hex'] = Variable<String>(colorHex);
    map['icon_id'] = Variable<String>(iconId);
    if (!nullToAbsent || iconPath != null) {
      map['icon_path'] = Variable<String>(iconPath);
    }
    map['milestone25_notified'] = Variable<bool>(milestone25Notified);
    map['milestone50_notified'] = Variable<bool>(milestone50Notified);
    map['milestone75_notified'] = Variable<bool>(milestone75Notified);
    map['near_completion_notified'] = Variable<bool>(nearCompletionNotified);
    map['completion_notified'] = Variable<bool>(completionNotified);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      targetAmountCents: Value(targetAmountCents),
      currentAmountCents: Value(currentAmountCents),
      startDate: Value(startDate),
      targetDate: Value(targetDate),
      frequency: Value(frequency),
      status: Value(status),
      colorHex: Value(colorHex),
      iconId: Value(iconId),
      iconPath: iconPath == null && nullToAbsent
          ? const Value.absent()
          : Value(iconPath),
      milestone25Notified: Value(milestone25Notified),
      milestone50Notified: Value(milestone50Notified),
      milestone75Notified: Value(milestone75Notified),
      nearCompletionNotified: Value(nearCompletionNotified),
      completionNotified: Value(completionNotified),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Challenge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Challenge(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      targetAmountCents: serializer.fromJson<int>(json['targetAmountCents']),
      currentAmountCents: serializer.fromJson<int>(json['currentAmountCents']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      frequency: serializer.fromJson<String>(json['frequency']),
      status: serializer.fromJson<String>(json['status']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      iconId: serializer.fromJson<String>(json['iconId']),
      iconPath: serializer.fromJson<String?>(json['iconPath']),
      milestone25Notified:
          serializer.fromJson<bool>(json['milestone25Notified']),
      milestone50Notified:
          serializer.fromJson<bool>(json['milestone50Notified']),
      milestone75Notified:
          serializer.fromJson<bool>(json['milestone75Notified']),
      nearCompletionNotified:
          serializer.fromJson<bool>(json['nearCompletionNotified']),
      completionNotified: serializer.fromJson<bool>(json['completionNotified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'targetAmountCents': serializer.toJson<int>(targetAmountCents),
      'currentAmountCents': serializer.toJson<int>(currentAmountCents),
      'startDate': serializer.toJson<DateTime>(startDate),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'frequency': serializer.toJson<String>(frequency),
      'status': serializer.toJson<String>(status),
      'colorHex': serializer.toJson<String>(colorHex),
      'iconId': serializer.toJson<String>(iconId),
      'iconPath': serializer.toJson<String?>(iconPath),
      'milestone25Notified': serializer.toJson<bool>(milestone25Notified),
      'milestone50Notified': serializer.toJson<bool>(milestone50Notified),
      'milestone75Notified': serializer.toJson<bool>(milestone75Notified),
      'nearCompletionNotified': serializer.toJson<bool>(nearCompletionNotified),
      'completionNotified': serializer.toJson<bool>(completionNotified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Challenge copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          int? targetAmountCents,
          int? currentAmountCents,
          DateTime? startDate,
          DateTime? targetDate,
          String? frequency,
          String? status,
          String? colorHex,
          String? iconId,
          Value<String?> iconPath = const Value.absent(),
          bool? milestone25Notified,
          bool? milestone50Notified,
          bool? milestone75Notified,
          bool? nearCompletionNotified,
          bool? completionNotified,
          DateTime? createdAt,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Challenge(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        targetAmountCents: targetAmountCents ?? this.targetAmountCents,
        currentAmountCents: currentAmountCents ?? this.currentAmountCents,
        startDate: startDate ?? this.startDate,
        targetDate: targetDate ?? this.targetDate,
        frequency: frequency ?? this.frequency,
        status: status ?? this.status,
        colorHex: colorHex ?? this.colorHex,
        iconId: iconId ?? this.iconId,
        iconPath: iconPath.present ? iconPath.value : this.iconPath,
        milestone25Notified: milestone25Notified ?? this.milestone25Notified,
        milestone50Notified: milestone50Notified ?? this.milestone50Notified,
        milestone75Notified: milestone75Notified ?? this.milestone75Notified,
        nearCompletionNotified:
            nearCompletionNotified ?? this.nearCompletionNotified,
        completionNotified: completionNotified ?? this.completionNotified,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Challenge copyWithCompanion(ChallengesCompanion data) {
    return Challenge(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      targetAmountCents: data.targetAmountCents.present
          ? data.targetAmountCents.value
          : this.targetAmountCents,
      currentAmountCents: data.currentAmountCents.present
          ? data.currentAmountCents.value
          : this.currentAmountCents,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      status: data.status.present ? data.status.value : this.status,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
      milestone25Notified: data.milestone25Notified.present
          ? data.milestone25Notified.value
          : this.milestone25Notified,
      milestone50Notified: data.milestone50Notified.present
          ? data.milestone50Notified.value
          : this.milestone50Notified,
      milestone75Notified: data.milestone75Notified.present
          ? data.milestone75Notified.value
          : this.milestone75Notified,
      nearCompletionNotified: data.nearCompletionNotified.present
          ? data.nearCompletionNotified.value
          : this.nearCompletionNotified,
      completionNotified: data.completionNotified.present
          ? data.completionNotified.value
          : this.completionNotified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Challenge(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetAmountCents: $targetAmountCents, ')
          ..write('currentAmountCents: $currentAmountCents, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('frequency: $frequency, ')
          ..write('status: $status, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconId: $iconId, ')
          ..write('iconPath: $iconPath, ')
          ..write('milestone25Notified: $milestone25Notified, ')
          ..write('milestone50Notified: $milestone50Notified, ')
          ..write('milestone75Notified: $milestone75Notified, ')
          ..write('nearCompletionNotified: $nearCompletionNotified, ')
          ..write('completionNotified: $completionNotified, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      targetAmountCents,
      currentAmountCents,
      startDate,
      targetDate,
      frequency,
      status,
      colorHex,
      iconId,
      iconPath,
      milestone25Notified,
      milestone50Notified,
      milestone75Notified,
      nearCompletionNotified,
      completionNotified,
      createdAt,
      completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Challenge &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.targetAmountCents == this.targetAmountCents &&
          other.currentAmountCents == this.currentAmountCents &&
          other.startDate == this.startDate &&
          other.targetDate == this.targetDate &&
          other.frequency == this.frequency &&
          other.status == this.status &&
          other.colorHex == this.colorHex &&
          other.iconId == this.iconId &&
          other.iconPath == this.iconPath &&
          other.milestone25Notified == this.milestone25Notified &&
          other.milestone50Notified == this.milestone50Notified &&
          other.milestone75Notified == this.milestone75Notified &&
          other.nearCompletionNotified == this.nearCompletionNotified &&
          other.completionNotified == this.completionNotified &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class ChallengesCompanion extends UpdateCompanion<Challenge> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> targetAmountCents;
  final Value<int> currentAmountCents;
  final Value<DateTime> startDate;
  final Value<DateTime> targetDate;
  final Value<String> frequency;
  final Value<String> status;
  final Value<String> colorHex;
  final Value<String> iconId;
  final Value<String?> iconPath;
  final Value<bool> milestone25Notified;
  final Value<bool> milestone50Notified;
  final Value<bool> milestone75Notified;
  final Value<bool> nearCompletionNotified;
  final Value<bool> completionNotified;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.targetAmountCents = const Value.absent(),
    this.currentAmountCents = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.frequency = const Value.absent(),
    this.status = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.iconId = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.milestone25Notified = const Value.absent(),
    this.milestone50Notified = const Value.absent(),
    this.milestone75Notified = const Value.absent(),
    this.nearCompletionNotified = const Value.absent(),
    this.completionNotified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required int targetAmountCents,
    this.currentAmountCents = const Value.absent(),
    required DateTime startDate,
    required DateTime targetDate,
    required String frequency,
    this.status = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.iconId = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.milestone25Notified = const Value.absent(),
    this.milestone50Notified = const Value.absent(),
    this.milestone75Notified = const Value.absent(),
    this.nearCompletionNotified = const Value.absent(),
    this.completionNotified = const Value.absent(),
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        targetAmountCents = Value(targetAmountCents),
        startDate = Value(startDate),
        targetDate = Value(targetDate),
        frequency = Value(frequency),
        createdAt = Value(createdAt);
  static Insertable<Challenge> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? targetAmountCents,
    Expression<int>? currentAmountCents,
    Expression<DateTime>? startDate,
    Expression<DateTime>? targetDate,
    Expression<String>? frequency,
    Expression<String>? status,
    Expression<String>? colorHex,
    Expression<String>? iconId,
    Expression<String>? iconPath,
    Expression<bool>? milestone25Notified,
    Expression<bool>? milestone50Notified,
    Expression<bool>? milestone75Notified,
    Expression<bool>? nearCompletionNotified,
    Expression<bool>? completionNotified,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (targetAmountCents != null) 'target_amount_cents': targetAmountCents,
      if (currentAmountCents != null)
        'current_amount_cents': currentAmountCents,
      if (startDate != null) 'start_date': startDate,
      if (targetDate != null) 'target_date': targetDate,
      if (frequency != null) 'frequency': frequency,
      if (status != null) 'status': status,
      if (colorHex != null) 'color_hex': colorHex,
      if (iconId != null) 'icon_id': iconId,
      if (iconPath != null) 'icon_path': iconPath,
      if (milestone25Notified != null)
        'milestone25_notified': milestone25Notified,
      if (milestone50Notified != null)
        'milestone50_notified': milestone50Notified,
      if (milestone75Notified != null)
        'milestone75_notified': milestone75Notified,
      if (nearCompletionNotified != null)
        'near_completion_notified': nearCompletionNotified,
      if (completionNotified != null) 'completion_notified': completionNotified,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? targetAmountCents,
      Value<int>? currentAmountCents,
      Value<DateTime>? startDate,
      Value<DateTime>? targetDate,
      Value<String>? frequency,
      Value<String>? status,
      Value<String>? colorHex,
      Value<String>? iconId,
      Value<String?>? iconPath,
      Value<bool>? milestone25Notified,
      Value<bool>? milestone50Notified,
      Value<bool>? milestone75Notified,
      Value<bool>? nearCompletionNotified,
      Value<bool>? completionNotified,
      Value<DateTime>? createdAt,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return ChallengesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetAmountCents: targetAmountCents ?? this.targetAmountCents,
      currentAmountCents: currentAmountCents ?? this.currentAmountCents,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      frequency: frequency ?? this.frequency,
      status: status ?? this.status,
      colorHex: colorHex ?? this.colorHex,
      iconId: iconId ?? this.iconId,
      iconPath: iconPath ?? this.iconPath,
      milestone25Notified: milestone25Notified ?? this.milestone25Notified,
      milestone50Notified: milestone50Notified ?? this.milestone50Notified,
      milestone75Notified: milestone75Notified ?? this.milestone75Notified,
      nearCompletionNotified:
          nearCompletionNotified ?? this.nearCompletionNotified,
      completionNotified: completionNotified ?? this.completionNotified,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetAmountCents.present) {
      map['target_amount_cents'] = Variable<int>(targetAmountCents.value);
    }
    if (currentAmountCents.present) {
      map['current_amount_cents'] = Variable<int>(currentAmountCents.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (milestone25Notified.present) {
      map['milestone25_notified'] = Variable<bool>(milestone25Notified.value);
    }
    if (milestone50Notified.present) {
      map['milestone50_notified'] = Variable<bool>(milestone50Notified.value);
    }
    if (milestone75Notified.present) {
      map['milestone75_notified'] = Variable<bool>(milestone75Notified.value);
    }
    if (nearCompletionNotified.present) {
      map['near_completion_notified'] =
          Variable<bool>(nearCompletionNotified.value);
    }
    if (completionNotified.present) {
      map['completion_notified'] = Variable<bool>(completionNotified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetAmountCents: $targetAmountCents, ')
          ..write('currentAmountCents: $currentAmountCents, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('frequency: $frequency, ')
          ..write('status: $status, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconId: $iconId, ')
          ..write('iconPath: $iconPath, ')
          ..write('milestone25Notified: $milestone25Notified, ')
          ..write('milestone50Notified: $milestone50Notified, ')
          ..write('milestone75Notified: $milestone75Notified, ')
          ..write('nearCompletionNotified: $nearCompletionNotified, ')
          ..write('completionNotified: $completionNotified, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsRecordsTable extends SavingsRecords
    with TableInfo<$SavingsRecordsTable, SavingsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _challengeIdMeta =
      const VerificationMeta('challengeId');
  @override
  late final GeneratedColumn<String> challengeId = GeneratedColumn<String>(
      'challenge_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES challenges (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountCentsMeta =
      const VerificationMeta('amountCents');
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
      'amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _proofPathMeta =
      const VerificationMeta('proofPath');
  @override
  late final GeneratedColumn<String> proofPath = GeneratedColumn<String>(
      'proof_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _proofWidthMeta =
      const VerificationMeta('proofWidth');
  @override
  late final GeneratedColumn<int> proofWidth = GeneratedColumn<int>(
      'proof_width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _proofHeightMeta =
      const VerificationMeta('proofHeight');
  @override
  late final GeneratedColumn<int> proofHeight = GeneratedColumn<int>(
      'proof_height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        challengeId,
        amountCents,
        date,
        note,
        proofPath,
        proofWidth,
        proofHeight,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_records';
  @override
  VerificationContext validateIntegrity(Insertable<SavingsRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('challenge_id')) {
      context.handle(
          _challengeIdMeta,
          challengeId.isAcceptableOrUnknown(
              data['challenge_id']!, _challengeIdMeta));
    } else if (isInserting) {
      context.missing(_challengeIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
          _amountCentsMeta,
          amountCents.isAcceptableOrUnknown(
              data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('proof_path')) {
      context.handle(_proofPathMeta,
          proofPath.isAcceptableOrUnknown(data['proof_path']!, _proofPathMeta));
    }
    if (data.containsKey('proof_width')) {
      context.handle(
          _proofWidthMeta,
          proofWidth.isAcceptableOrUnknown(
              data['proof_width']!, _proofWidthMeta));
    }
    if (data.containsKey('proof_height')) {
      context.handle(
          _proofHeightMeta,
          proofHeight.isAcceptableOrUnknown(
              data['proof_height']!, _proofHeightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      challengeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}challenge_id'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      proofPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}proof_path']),
      proofWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}proof_width']),
      proofHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}proof_height']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SavingsRecordsTable createAlias(String alias) {
    return $SavingsRecordsTable(attachedDatabase, alias);
  }
}

class SavingsRecord extends DataClass implements Insertable<SavingsRecord> {
  final String id;
  final String challengeId;
  final int amountCents;
  final DateTime date;
  final String? note;
  final String? proofPath;
  final int? proofWidth;
  final int? proofHeight;
  final DateTime createdAt;
  const SavingsRecord(
      {required this.id,
      required this.challengeId,
      required this.amountCents,
      required this.date,
      this.note,
      this.proofPath,
      this.proofWidth,
      this.proofHeight,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['challenge_id'] = Variable<String>(challengeId);
    map['amount_cents'] = Variable<int>(amountCents);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || proofPath != null) {
      map['proof_path'] = Variable<String>(proofPath);
    }
    if (!nullToAbsent || proofWidth != null) {
      map['proof_width'] = Variable<int>(proofWidth);
    }
    if (!nullToAbsent || proofHeight != null) {
      map['proof_height'] = Variable<int>(proofHeight);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavingsRecordsCompanion toCompanion(bool nullToAbsent) {
    return SavingsRecordsCompanion(
      id: Value(id),
      challengeId: Value(challengeId),
      amountCents: Value(amountCents),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      proofPath: proofPath == null && nullToAbsent
          ? const Value.absent()
          : Value(proofPath),
      proofWidth: proofWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(proofWidth),
      proofHeight: proofHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(proofHeight),
      createdAt: Value(createdAt),
    );
  }

  factory SavingsRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsRecord(
      id: serializer.fromJson<String>(json['id']),
      challengeId: serializer.fromJson<String>(json['challengeId']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      proofPath: serializer.fromJson<String?>(json['proofPath']),
      proofWidth: serializer.fromJson<int?>(json['proofWidth']),
      proofHeight: serializer.fromJson<int?>(json['proofHeight']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'challengeId': serializer.toJson<String>(challengeId),
      'amountCents': serializer.toJson<int>(amountCents),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'proofPath': serializer.toJson<String?>(proofPath),
      'proofWidth': serializer.toJson<int?>(proofWidth),
      'proofHeight': serializer.toJson<int?>(proofHeight),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavingsRecord copyWith(
          {String? id,
          String? challengeId,
          int? amountCents,
          DateTime? date,
          Value<String?> note = const Value.absent(),
          Value<String?> proofPath = const Value.absent(),
          Value<int?> proofWidth = const Value.absent(),
          Value<int?> proofHeight = const Value.absent(),
          DateTime? createdAt}) =>
      SavingsRecord(
        id: id ?? this.id,
        challengeId: challengeId ?? this.challengeId,
        amountCents: amountCents ?? this.amountCents,
        date: date ?? this.date,
        note: note.present ? note.value : this.note,
        proofPath: proofPath.present ? proofPath.value : this.proofPath,
        proofWidth: proofWidth.present ? proofWidth.value : this.proofWidth,
        proofHeight: proofHeight.present ? proofHeight.value : this.proofHeight,
        createdAt: createdAt ?? this.createdAt,
      );
  SavingsRecord copyWithCompanion(SavingsRecordsCompanion data) {
    return SavingsRecord(
      id: data.id.present ? data.id.value : this.id,
      challengeId:
          data.challengeId.present ? data.challengeId.value : this.challengeId,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      proofPath: data.proofPath.present ? data.proofPath.value : this.proofPath,
      proofWidth:
          data.proofWidth.present ? data.proofWidth.value : this.proofWidth,
      proofHeight:
          data.proofHeight.present ? data.proofHeight.value : this.proofHeight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsRecord(')
          ..write('id: $id, ')
          ..write('challengeId: $challengeId, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('proofPath: $proofPath, ')
          ..write('proofWidth: $proofWidth, ')
          ..write('proofHeight: $proofHeight, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, challengeId, amountCents, date, note,
      proofPath, proofWidth, proofHeight, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsRecord &&
          other.id == this.id &&
          other.challengeId == this.challengeId &&
          other.amountCents == this.amountCents &&
          other.date == this.date &&
          other.note == this.note &&
          other.proofPath == this.proofPath &&
          other.proofWidth == this.proofWidth &&
          other.proofHeight == this.proofHeight &&
          other.createdAt == this.createdAt);
}

class SavingsRecordsCompanion extends UpdateCompanion<SavingsRecord> {
  final Value<String> id;
  final Value<String> challengeId;
  final Value<int> amountCents;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<String?> proofPath;
  final Value<int?> proofWidth;
  final Value<int?> proofHeight;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SavingsRecordsCompanion({
    this.id = const Value.absent(),
    this.challengeId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.proofPath = const Value.absent(),
    this.proofWidth = const Value.absent(),
    this.proofHeight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsRecordsCompanion.insert({
    required String id,
    required String challengeId,
    required int amountCents,
    required DateTime date,
    this.note = const Value.absent(),
    this.proofPath = const Value.absent(),
    this.proofWidth = const Value.absent(),
    this.proofHeight = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        challengeId = Value(challengeId),
        amountCents = Value(amountCents),
        date = Value(date),
        createdAt = Value(createdAt);
  static Insertable<SavingsRecord> custom({
    Expression<String>? id,
    Expression<String>? challengeId,
    Expression<int>? amountCents,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<String>? proofPath,
    Expression<int>? proofWidth,
    Expression<int>? proofHeight,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (challengeId != null) 'challenge_id': challengeId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (proofPath != null) 'proof_path': proofPath,
      if (proofWidth != null) 'proof_width': proofWidth,
      if (proofHeight != null) 'proof_height': proofHeight,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? challengeId,
      Value<int>? amountCents,
      Value<DateTime>? date,
      Value<String?>? note,
      Value<String?>? proofPath,
      Value<int?>? proofWidth,
      Value<int?>? proofHeight,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SavingsRecordsCompanion(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      amountCents: amountCents ?? this.amountCents,
      date: date ?? this.date,
      note: note ?? this.note,
      proofPath: proofPath ?? this.proofPath,
      proofWidth: proofWidth ?? this.proofWidth,
      proofHeight: proofHeight ?? this.proofHeight,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (proofPath.present) {
      map['proof_path'] = Variable<String>(proofPath.value);
    }
    if (proofWidth.present) {
      map['proof_width'] = Variable<int>(proofWidth.value);
    }
    if (proofHeight.present) {
      map['proof_height'] = Variable<int>(proofHeight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsRecordsCompanion(')
          ..write('id: $id, ')
          ..write('challengeId: $challengeId, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('proofPath: $proofPath, ')
          ..write('proofWidth: $proofWidth, ')
          ..write('proofHeight: $proofHeight, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 24),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _avatarPathMeta =
      const VerificationMeta('avatarPath');
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
      'avatar_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalXpMeta =
      const VerificationMeta('totalXp');
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
      'total_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
      'rank', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('E'));
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _unlockedAchievementIdsMeta =
      const VerificationMeta('unlockedAchievementIds');
  @override
  late final GeneratedColumn<String> unlockedAchievementIds =
      GeneratedColumn<String>('unlocked_achievement_ids', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dailyReminderTimeMeta =
      const VerificationMeta('dailyReminderTime');
  @override
  late final GeneratedColumn<String> dailyReminderTime =
      GeneratedColumn<String>('daily_reminder_time', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('20:00'));
  static const VerificationMeta _notificationDeclineCountMeta =
      const VerificationMeta('notificationDeclineCount');
  @override
  late final GeneratedColumn<int> notificationDeclineCount =
      GeneratedColumn<int>('notification_decline_count', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _lastNotificationPromptMeta =
      const VerificationMeta('lastNotificationPrompt');
  @override
  late final GeneratedColumn<DateTime> lastNotificationPrompt =
      GeneratedColumn<DateTime>('last_notification_prompt', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
      'onboarding_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _systemVoiceEnabledMeta =
      const VerificationMeta('systemVoiceEnabled');
  @override
  late final GeneratedColumn<bool> systemVoiceEnabled = GeneratedColumn<bool>(
      'system_voice_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("system_voice_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        displayName,
        avatarPath,
        totalXp,
        level,
        rank,
        currentStreak,
        longestStreak,
        unlockedAchievementIds,
        locale,
        notificationsEnabled,
        dailyReminderTime,
        notificationDeclineCount,
        lastNotificationPrompt,
        onboardingComplete,
        systemVoiceEnabled,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
          _avatarPathMeta,
          avatarPath.isAcceptableOrUnknown(
              data['avatar_path']!, _avatarPathMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(_totalXpMeta,
          totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('unlocked_achievement_ids')) {
      context.handle(
          _unlockedAchievementIdsMeta,
          unlockedAchievementIds.isAcceptableOrUnknown(
              data['unlocked_achievement_ids']!, _unlockedAchievementIdsMeta));
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('daily_reminder_time')) {
      context.handle(
          _dailyReminderTimeMeta,
          dailyReminderTime.isAcceptableOrUnknown(
              data['daily_reminder_time']!, _dailyReminderTimeMeta));
    }
    if (data.containsKey('notification_decline_count')) {
      context.handle(
          _notificationDeclineCountMeta,
          notificationDeclineCount.isAcceptableOrUnknown(
              data['notification_decline_count']!,
              _notificationDeclineCountMeta));
    }
    if (data.containsKey('last_notification_prompt')) {
      context.handle(
          _lastNotificationPromptMeta,
          lastNotificationPrompt.isAcceptableOrUnknown(
              data['last_notification_prompt']!, _lastNotificationPromptMeta));
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
          _onboardingCompleteMeta,
          onboardingComplete.isAcceptableOrUnknown(
              data['onboarding_complete']!, _onboardingCompleteMeta));
    }
    if (data.containsKey('system_voice_enabled')) {
      context.handle(
          _systemVoiceEnabledMeta,
          systemVoiceEnabled.isAcceptableOrUnknown(
              data['system_voice_enabled']!, _systemVoiceEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      avatarPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_path']),
      totalXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_xp'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rank'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      unlockedAchievementIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unlocked_achievement_ids'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      dailyReminderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}daily_reminder_time'])!,
      notificationDeclineCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}notification_decline_count'])!,
      lastNotificationPrompt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_notification_prompt']),
      onboardingComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_complete'])!,
      systemVoiceEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}system_voice_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String displayName;
  final String? avatarPath;
  final int totalXp;
  final int level;
  final String rank;
  final int currentStreak;
  final int longestStreak;
  final String unlockedAchievementIds;
  final String locale;
  final bool notificationsEnabled;
  final String dailyReminderTime;
  final int notificationDeclineCount;
  final DateTime? lastNotificationPrompt;
  final bool onboardingComplete;
  final bool systemVoiceEnabled;
  final DateTime createdAt;
  const UserProfile(
      {required this.id,
      required this.displayName,
      this.avatarPath,
      required this.totalXp,
      required this.level,
      required this.rank,
      required this.currentStreak,
      required this.longestStreak,
      required this.unlockedAchievementIds,
      required this.locale,
      required this.notificationsEnabled,
      required this.dailyReminderTime,
      required this.notificationDeclineCount,
      this.lastNotificationPrompt,
      required this.onboardingComplete,
      required this.systemVoiceEnabled,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['total_xp'] = Variable<int>(totalXp);
    map['level'] = Variable<int>(level);
    map['rank'] = Variable<String>(rank);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['unlocked_achievement_ids'] = Variable<String>(unlockedAchievementIds);
    map['locale'] = Variable<String>(locale);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['daily_reminder_time'] = Variable<String>(dailyReminderTime);
    map['notification_decline_count'] = Variable<int>(notificationDeclineCount);
    if (!nullToAbsent || lastNotificationPrompt != null) {
      map['last_notification_prompt'] =
          Variable<DateTime>(lastNotificationPrompt);
    }
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['system_voice_enabled'] = Variable<bool>(systemVoiceEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      totalXp: Value(totalXp),
      level: Value(level),
      rank: Value(rank),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      unlockedAchievementIds: Value(unlockedAchievementIds),
      locale: Value(locale),
      notificationsEnabled: Value(notificationsEnabled),
      dailyReminderTime: Value(dailyReminderTime),
      notificationDeclineCount: Value(notificationDeclineCount),
      lastNotificationPrompt: lastNotificationPrompt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastNotificationPrompt),
      onboardingComplete: Value(onboardingComplete),
      systemVoiceEnabled: Value(systemVoiceEnabled),
      createdAt: Value(createdAt),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      level: serializer.fromJson<int>(json['level']),
      rank: serializer.fromJson<String>(json['rank']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      unlockedAchievementIds:
          serializer.fromJson<String>(json['unlockedAchievementIds']),
      locale: serializer.fromJson<String>(json['locale']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      dailyReminderTime: serializer.fromJson<String>(json['dailyReminderTime']),
      notificationDeclineCount:
          serializer.fromJson<int>(json['notificationDeclineCount']),
      lastNotificationPrompt:
          serializer.fromJson<DateTime?>(json['lastNotificationPrompt']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      systemVoiceEnabled: serializer.fromJson<bool>(json['systemVoiceEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'totalXp': serializer.toJson<int>(totalXp),
      'level': serializer.toJson<int>(level),
      'rank': serializer.toJson<String>(rank),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'unlockedAchievementIds':
          serializer.toJson<String>(unlockedAchievementIds),
      'locale': serializer.toJson<String>(locale),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'dailyReminderTime': serializer.toJson<String>(dailyReminderTime),
      'notificationDeclineCount':
          serializer.toJson<int>(notificationDeclineCount),
      'lastNotificationPrompt':
          serializer.toJson<DateTime?>(lastNotificationPrompt),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'systemVoiceEnabled': serializer.toJson<bool>(systemVoiceEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserProfile copyWith(
          {String? id,
          String? displayName,
          Value<String?> avatarPath = const Value.absent(),
          int? totalXp,
          int? level,
          String? rank,
          int? currentStreak,
          int? longestStreak,
          String? unlockedAchievementIds,
          String? locale,
          bool? notificationsEnabled,
          String? dailyReminderTime,
          int? notificationDeclineCount,
          Value<DateTime?> lastNotificationPrompt = const Value.absent(),
          bool? onboardingComplete,
          bool? systemVoiceEnabled,
          DateTime? createdAt}) =>
      UserProfile(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
        totalXp: totalXp ?? this.totalXp,
        level: level ?? this.level,
        rank: rank ?? this.rank,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        unlockedAchievementIds:
            unlockedAchievementIds ?? this.unlockedAchievementIds,
        locale: locale ?? this.locale,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
        notificationDeclineCount:
            notificationDeclineCount ?? this.notificationDeclineCount,
        lastNotificationPrompt: lastNotificationPrompt.present
            ? lastNotificationPrompt.value
            : this.lastNotificationPrompt,
        onboardingComplete: onboardingComplete ?? this.onboardingComplete,
        systemVoiceEnabled: systemVoiceEnabled ?? this.systemVoiceEnabled,
        createdAt: createdAt ?? this.createdAt,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      avatarPath:
          data.avatarPath.present ? data.avatarPath.value : this.avatarPath,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      level: data.level.present ? data.level.value : this.level,
      rank: data.rank.present ? data.rank.value : this.rank,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      unlockedAchievementIds: data.unlockedAchievementIds.present
          ? data.unlockedAchievementIds.value
          : this.unlockedAchievementIds,
      locale: data.locale.present ? data.locale.value : this.locale,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      dailyReminderTime: data.dailyReminderTime.present
          ? data.dailyReminderTime.value
          : this.dailyReminderTime,
      notificationDeclineCount: data.notificationDeclineCount.present
          ? data.notificationDeclineCount.value
          : this.notificationDeclineCount,
      lastNotificationPrompt: data.lastNotificationPrompt.present
          ? data.lastNotificationPrompt.value
          : this.lastNotificationPrompt,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      systemVoiceEnabled: data.systemVoiceEnabled.present
          ? data.systemVoiceEnabled.value
          : this.systemVoiceEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('unlockedAchievementIds: $unlockedAchievementIds, ')
          ..write('locale: $locale, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('dailyReminderTime: $dailyReminderTime, ')
          ..write('notificationDeclineCount: $notificationDeclineCount, ')
          ..write('lastNotificationPrompt: $lastNotificationPrompt, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('systemVoiceEnabled: $systemVoiceEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      displayName,
      avatarPath,
      totalXp,
      level,
      rank,
      currentStreak,
      longestStreak,
      unlockedAchievementIds,
      locale,
      notificationsEnabled,
      dailyReminderTime,
      notificationDeclineCount,
      lastNotificationPrompt,
      onboardingComplete,
      systemVoiceEnabled,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.avatarPath == this.avatarPath &&
          other.totalXp == this.totalXp &&
          other.level == this.level &&
          other.rank == this.rank &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.unlockedAchievementIds == this.unlockedAchievementIds &&
          other.locale == this.locale &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.dailyReminderTime == this.dailyReminderTime &&
          other.notificationDeclineCount == this.notificationDeclineCount &&
          other.lastNotificationPrompt == this.lastNotificationPrompt &&
          other.onboardingComplete == this.onboardingComplete &&
          other.systemVoiceEnabled == this.systemVoiceEnabled &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String?> avatarPath;
  final Value<int> totalXp;
  final Value<int> level;
  final Value<String> rank;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<String> unlockedAchievementIds;
  final Value<String> locale;
  final Value<bool> notificationsEnabled;
  final Value<String> dailyReminderTime;
  final Value<int> notificationDeclineCount;
  final Value<DateTime?> lastNotificationPrompt;
  final Value<bool> onboardingComplete;
  final Value<bool> systemVoiceEnabled;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.unlockedAchievementIds = const Value.absent(),
    this.locale = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.dailyReminderTime = const Value.absent(),
    this.notificationDeclineCount = const Value.absent(),
    this.lastNotificationPrompt = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.systemVoiceEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String displayName,
    this.avatarPath = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.unlockedAchievementIds = const Value.absent(),
    this.locale = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.dailyReminderTime = const Value.absent(),
    this.notificationDeclineCount = const Value.absent(),
    this.lastNotificationPrompt = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.systemVoiceEnabled = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        displayName = Value(displayName),
        createdAt = Value(createdAt);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? avatarPath,
    Expression<int>? totalXp,
    Expression<int>? level,
    Expression<String>? rank,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<String>? unlockedAchievementIds,
    Expression<String>? locale,
    Expression<bool>? notificationsEnabled,
    Expression<String>? dailyReminderTime,
    Expression<int>? notificationDeclineCount,
    Expression<DateTime>? lastNotificationPrompt,
    Expression<bool>? onboardingComplete,
    Expression<bool>? systemVoiceEnabled,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (totalXp != null) 'total_xp': totalXp,
      if (level != null) 'level': level,
      if (rank != null) 'rank': rank,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (unlockedAchievementIds != null)
        'unlocked_achievement_ids': unlockedAchievementIds,
      if (locale != null) 'locale': locale,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (dailyReminderTime != null) 'daily_reminder_time': dailyReminderTime,
      if (notificationDeclineCount != null)
        'notification_decline_count': notificationDeclineCount,
      if (lastNotificationPrompt != null)
        'last_notification_prompt': lastNotificationPrompt,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (systemVoiceEnabled != null)
        'system_voice_enabled': systemVoiceEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? displayName,
      Value<String?>? avatarPath,
      Value<int>? totalXp,
      Value<int>? level,
      Value<String>? rank,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<String>? unlockedAchievementIds,
      Value<String>? locale,
      Value<bool>? notificationsEnabled,
      Value<String>? dailyReminderTime,
      Value<int>? notificationDeclineCount,
      Value<DateTime?>? lastNotificationPrompt,
      Value<bool>? onboardingComplete,
      Value<bool>? systemVoiceEnabled,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarPath: avatarPath ?? this.avatarPath,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      unlockedAchievementIds:
          unlockedAchievementIds ?? this.unlockedAchievementIds,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
      notificationDeclineCount:
          notificationDeclineCount ?? this.notificationDeclineCount,
      lastNotificationPrompt:
          lastNotificationPrompt ?? this.lastNotificationPrompt,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      systemVoiceEnabled: systemVoiceEnabled ?? this.systemVoiceEnabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (unlockedAchievementIds.present) {
      map['unlocked_achievement_ids'] =
          Variable<String>(unlockedAchievementIds.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (dailyReminderTime.present) {
      map['daily_reminder_time'] = Variable<String>(dailyReminderTime.value);
    }
    if (notificationDeclineCount.present) {
      map['notification_decline_count'] =
          Variable<int>(notificationDeclineCount.value);
    }
    if (lastNotificationPrompt.present) {
      map['last_notification_prompt'] =
          Variable<DateTime>(lastNotificationPrompt.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (systemVoiceEnabled.present) {
      map['system_voice_enabled'] = Variable<bool>(systemVoiceEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('unlockedAchievementIds: $unlockedAchievementIds, ')
          ..write('locale: $locale, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('dailyReminderTime: $dailyReminderTime, ')
          ..write('notificationDeclineCount: $notificationDeclineCount, ')
          ..write('lastNotificationPrompt: $lastNotificationPrompt, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('systemVoiceEnabled: $systemVoiceEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameFilMeta =
      const VerificationMeta('nameFil');
  @override
  late final GeneratedColumn<String> nameFil = GeneratedColumn<String>(
      'name_fil', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionEnMeta =
      const VerificationMeta('descriptionEn');
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
      'description_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionFilMeta =
      const VerificationMeta('descriptionFil');
  @override
  late final GeneratedColumn<String> descriptionFil = GeneratedColumn<String>(
      'description_fil', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nameEn, nameFil, descriptionEn, descriptionFil, icon, xpReward];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(Insertable<Achievement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_fil')) {
      context.handle(_nameFilMeta,
          nameFil.isAcceptableOrUnknown(data['name_fil']!, _nameFilMeta));
    } else if (isInserting) {
      context.missing(_nameFilMeta);
    }
    if (data.containsKey('description_en')) {
      context.handle(
          _descriptionEnMeta,
          descriptionEn.isAcceptableOrUnknown(
              data['description_en']!, _descriptionEnMeta));
    } else if (isInserting) {
      context.missing(_descriptionEnMeta);
    }
    if (data.containsKey('description_fil')) {
      context.handle(
          _descriptionFilMeta,
          descriptionFil.isAcceptableOrUnknown(
              data['description_fil']!, _descriptionFilMeta));
    } else if (isInserting) {
      context.missing(_descriptionFilMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameFil: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_fil'])!,
      descriptionEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_en'])!,
      descriptionFil: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}description_fil'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final String id;
  final String nameEn;
  final String nameFil;
  final String descriptionEn;
  final String descriptionFil;
  final String icon;
  final int xpReward;
  const Achievement(
      {required this.id,
      required this.nameEn,
      required this.nameFil,
      required this.descriptionEn,
      required this.descriptionFil,
      required this.icon,
      required this.xpReward});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_fil'] = Variable<String>(nameFil);
    map['description_en'] = Variable<String>(descriptionEn);
    map['description_fil'] = Variable<String>(descriptionFil);
    map['icon'] = Variable<String>(icon);
    map['xp_reward'] = Variable<int>(xpReward);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameFil: Value(nameFil),
      descriptionEn: Value(descriptionEn),
      descriptionFil: Value(descriptionFil),
      icon: Value(icon),
      xpReward: Value(xpReward),
    );
  }

  factory Achievement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameFil: serializer.fromJson<String>(json['nameFil']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      descriptionFil: serializer.fromJson<String>(json['descriptionFil']),
      icon: serializer.fromJson<String>(json['icon']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameFil': serializer.toJson<String>(nameFil),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'descriptionFil': serializer.toJson<String>(descriptionFil),
      'icon': serializer.toJson<String>(icon),
      'xpReward': serializer.toJson<int>(xpReward),
    };
  }

  Achievement copyWith(
          {String? id,
          String? nameEn,
          String? nameFil,
          String? descriptionEn,
          String? descriptionFil,
          String? icon,
          int? xpReward}) =>
      Achievement(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameFil: nameFil ?? this.nameFil,
        descriptionEn: descriptionEn ?? this.descriptionEn,
        descriptionFil: descriptionFil ?? this.descriptionFil,
        icon: icon ?? this.icon,
        xpReward: xpReward ?? this.xpReward,
      );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameFil: data.nameFil.present ? data.nameFil.value : this.nameFil,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      descriptionFil: data.descriptionFil.present
          ? data.descriptionFil.value
          : this.descriptionFil,
      icon: data.icon.present ? data.icon.value : this.icon,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFil: $nameFil, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionFil: $descriptionFil, ')
          ..write('icon: $icon, ')
          ..write('xpReward: $xpReward')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nameEn, nameFil, descriptionEn, descriptionFil, icon, xpReward);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameFil == this.nameFil &&
          other.descriptionEn == this.descriptionEn &&
          other.descriptionFil == this.descriptionFil &&
          other.icon == this.icon &&
          other.xpReward == this.xpReward);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<String> id;
  final Value<String> nameEn;
  final Value<String> nameFil;
  final Value<String> descriptionEn;
  final Value<String> descriptionFil;
  final Value<String> icon;
  final Value<int> xpReward;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameFil = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.descriptionFil = const Value.absent(),
    this.icon = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String nameEn,
    required String nameFil,
    required String descriptionEn,
    required String descriptionFil,
    required String icon,
    required int xpReward,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameEn = Value(nameEn),
        nameFil = Value(nameFil),
        descriptionEn = Value(descriptionEn),
        descriptionFil = Value(descriptionFil),
        icon = Value(icon),
        xpReward = Value(xpReward);
  static Insertable<Achievement> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameFil,
    Expression<String>? descriptionEn,
    Expression<String>? descriptionFil,
    Expression<String>? icon,
    Expression<int>? xpReward,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameFil != null) 'name_fil': nameFil,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (descriptionFil != null) 'description_fil': descriptionFil,
      if (icon != null) 'icon': icon,
      if (xpReward != null) 'xp_reward': xpReward,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameEn,
      Value<String>? nameFil,
      Value<String>? descriptionEn,
      Value<String>? descriptionFil,
      Value<String>? icon,
      Value<int>? xpReward,
      Value<int>? rowid}) {
    return AchievementsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameFil: nameFil ?? this.nameFil,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionFil: descriptionFil ?? this.descriptionFil,
      icon: icon ?? this.icon,
      xpReward: xpReward ?? this.xpReward,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameFil.present) {
      map['name_fil'] = Variable<String>(nameFil.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (descriptionFil.present) {
      map['description_fil'] = Variable<String>(descriptionFil.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFil: $nameFil, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionFil: $descriptionFil, ')
          ..write('icon: $icon, ')
          ..write('xpReward: $xpReward, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationLogsTable extends NotificationLogs
    with TableInfo<$NotificationLogsTable, NotificationLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _challengeIdMeta =
      const VerificationMeta('challengeId');
  @override
  late final GeneratedColumn<String> challengeId = GeneratedColumn<String>(
      'challenge_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
      'sent_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type, challengeId, sentAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_logs';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('challenge_id')) {
      context.handle(
          _challengeIdMeta,
          challengeId.isAcceptableOrUnknown(
              data['challenge_id']!, _challengeIdMeta));
    }
    if (data.containsKey('sent_at')) {
      context.handle(_sentAtMeta,
          sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta));
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      challengeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}challenge_id']),
      sentAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sent_at'])!,
    );
  }

  @override
  $NotificationLogsTable createAlias(String alias) {
    return $NotificationLogsTable(attachedDatabase, alias);
  }
}

class NotificationLog extends DataClass implements Insertable<NotificationLog> {
  final String id;
  final String type;
  final String? challengeId;
  final DateTime sentAt;
  const NotificationLog(
      {required this.id,
      required this.type,
      this.challengeId,
      required this.sentAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || challengeId != null) {
      map['challenge_id'] = Variable<String>(challengeId);
    }
    map['sent_at'] = Variable<DateTime>(sentAt);
    return map;
  }

  NotificationLogsCompanion toCompanion(bool nullToAbsent) {
    return NotificationLogsCompanion(
      id: Value(id),
      type: Value(type),
      challengeId: challengeId == null && nullToAbsent
          ? const Value.absent()
          : Value(challengeId),
      sentAt: Value(sentAt),
    );
  }

  factory NotificationLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationLog(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      challengeId: serializer.fromJson<String?>(json['challengeId']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'challengeId': serializer.toJson<String?>(challengeId),
      'sentAt': serializer.toJson<DateTime>(sentAt),
    };
  }

  NotificationLog copyWith(
          {String? id,
          String? type,
          Value<String?> challengeId = const Value.absent(),
          DateTime? sentAt}) =>
      NotificationLog(
        id: id ?? this.id,
        type: type ?? this.type,
        challengeId: challengeId.present ? challengeId.value : this.challengeId,
        sentAt: sentAt ?? this.sentAt,
      );
  NotificationLog copyWithCompanion(NotificationLogsCompanion data) {
    return NotificationLog(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      challengeId:
          data.challengeId.present ? data.challengeId.value : this.challengeId,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLog(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('challengeId: $challengeId, ')
          ..write('sentAt: $sentAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, challengeId, sentAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationLog &&
          other.id == this.id &&
          other.type == this.type &&
          other.challengeId == this.challengeId &&
          other.sentAt == this.sentAt);
}

class NotificationLogsCompanion extends UpdateCompanion<NotificationLog> {
  final Value<String> id;
  final Value<String> type;
  final Value<String?> challengeId;
  final Value<DateTime> sentAt;
  final Value<int> rowid;
  const NotificationLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.challengeId = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationLogsCompanion.insert({
    required String id,
    required String type,
    this.challengeId = const Value.absent(),
    required DateTime sentAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        sentAt = Value(sentAt);
  static Insertable<NotificationLog> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? challengeId,
    Expression<DateTime>? sentAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (challengeId != null) 'challenge_id': challengeId,
      if (sentAt != null) 'sent_at': sentAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String?>? challengeId,
      Value<DateTime>? sentAt,
      Value<int>? rowid}) {
    return NotificationLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      challengeId: challengeId ?? this.challengeId,
      sentAt: sentAt ?? this.sentAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('challengeId: $challengeId, ')
          ..write('sentAt: $sentAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $SavingsRecordsTable savingsRecords = $SavingsRecordsTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $NotificationLogsTable notificationLogs =
      $NotificationLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        challenges,
        savingsRecords,
        userProfiles,
        achievements,
        notificationLogs
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('challenges',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('savings_records', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ChallengesTableCreateCompanionBuilder = ChallengesCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  required int targetAmountCents,
  Value<int> currentAmountCents,
  required DateTime startDate,
  required DateTime targetDate,
  required String frequency,
  Value<String> status,
  Value<String> colorHex,
  Value<String> iconId,
  Value<String?> iconPath,
  Value<bool> milestone25Notified,
  Value<bool> milestone50Notified,
  Value<bool> milestone75Notified,
  Value<bool> nearCompletionNotified,
  Value<bool> completionNotified,
  required DateTime createdAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$ChallengesTableUpdateCompanionBuilder = ChallengesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<int> targetAmountCents,
  Value<int> currentAmountCents,
  Value<DateTime> startDate,
  Value<DateTime> targetDate,
  Value<String> frequency,
  Value<String> status,
  Value<String> colorHex,
  Value<String> iconId,
  Value<String?> iconPath,
  Value<bool> milestone25Notified,
  Value<bool> milestone50Notified,
  Value<bool> milestone75Notified,
  Value<bool> nearCompletionNotified,
  Value<bool> completionNotified,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$ChallengesTableReferences
    extends BaseReferences<_$AppDatabase, $ChallengesTable, Challenge> {
  $$ChallengesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SavingsRecordsTable, List<SavingsRecord>>
      _savingsRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.savingsRecords,
              aliasName: $_aliasNameGenerator(
                  db.challenges.id, db.savingsRecords.challengeId));

  $$SavingsRecordsTableProcessedTableManager get savingsRecordsRefs {
    final manager = $$SavingsRecordsTableTableManager($_db, $_db.savingsRecords)
        .filter((f) => f.challengeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_savingsRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetAmountCents => $composableBuilder(
      column: $table.targetAmountCents,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentAmountCents => $composableBuilder(
      column: $table.currentAmountCents,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconId => $composableBuilder(
      column: $table.iconId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get milestone25Notified => $composableBuilder(
      column: $table.milestone25Notified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get milestone50Notified => $composableBuilder(
      column: $table.milestone50Notified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get milestone75Notified => $composableBuilder(
      column: $table.milestone75Notified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get nearCompletionNotified => $composableBuilder(
      column: $table.nearCompletionNotified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completionNotified => $composableBuilder(
      column: $table.completionNotified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> savingsRecordsRefs(
      Expression<bool> Function($$SavingsRecordsTableFilterComposer f) f) {
    final $$SavingsRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savingsRecords,
        getReferencedColumn: (t) => t.challengeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavingsRecordsTableFilterComposer(
              $db: $db,
              $table: $db.savingsRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetAmountCents => $composableBuilder(
      column: $table.targetAmountCents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentAmountCents => $composableBuilder(
      column: $table.currentAmountCents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconId => $composableBuilder(
      column: $table.iconId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get milestone25Notified => $composableBuilder(
      column: $table.milestone25Notified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get milestone50Notified => $composableBuilder(
      column: $table.milestone50Notified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get milestone75Notified => $composableBuilder(
      column: $table.milestone75Notified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get nearCompletionNotified => $composableBuilder(
      column: $table.nearCompletionNotified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completionNotified => $composableBuilder(
      column: $table.completionNotified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get targetAmountCents => $composableBuilder(
      column: $table.targetAmountCents, builder: (column) => column);

  GeneratedColumn<int> get currentAmountCents => $composableBuilder(
      column: $table.currentAmountCents, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<String> get iconId =>
      $composableBuilder(column: $table.iconId, builder: (column) => column);

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  GeneratedColumn<bool> get milestone25Notified => $composableBuilder(
      column: $table.milestone25Notified, builder: (column) => column);

  GeneratedColumn<bool> get milestone50Notified => $composableBuilder(
      column: $table.milestone50Notified, builder: (column) => column);

  GeneratedColumn<bool> get milestone75Notified => $composableBuilder(
      column: $table.milestone75Notified, builder: (column) => column);

  GeneratedColumn<bool> get nearCompletionNotified => $composableBuilder(
      column: $table.nearCompletionNotified, builder: (column) => column);

  GeneratedColumn<bool> get completionNotified => $composableBuilder(
      column: $table.completionNotified, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  Expression<T> savingsRecordsRefs<T extends Object>(
      Expression<T> Function($$SavingsRecordsTableAnnotationComposer a) f) {
    final $$SavingsRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savingsRecords,
        getReferencedColumn: (t) => t.challengeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavingsRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.savingsRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChallengesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChallengesTable,
    Challenge,
    $$ChallengesTableFilterComposer,
    $$ChallengesTableOrderingComposer,
    $$ChallengesTableAnnotationComposer,
    $$ChallengesTableCreateCompanionBuilder,
    $$ChallengesTableUpdateCompanionBuilder,
    (Challenge, $$ChallengesTableReferences),
    Challenge,
    PrefetchHooks Function({bool savingsRecordsRefs})> {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> targetAmountCents = const Value.absent(),
            Value<int> currentAmountCents = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> targetDate = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<String> iconId = const Value.absent(),
            Value<String?> iconPath = const Value.absent(),
            Value<bool> milestone25Notified = const Value.absent(),
            Value<bool> milestone50Notified = const Value.absent(),
            Value<bool> milestone75Notified = const Value.absent(),
            Value<bool> nearCompletionNotified = const Value.absent(),
            Value<bool> completionNotified = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChallengesCompanion(
            id: id,
            name: name,
            description: description,
            targetAmountCents: targetAmountCents,
            currentAmountCents: currentAmountCents,
            startDate: startDate,
            targetDate: targetDate,
            frequency: frequency,
            status: status,
            colorHex: colorHex,
            iconId: iconId,
            iconPath: iconPath,
            milestone25Notified: milestone25Notified,
            milestone50Notified: milestone50Notified,
            milestone75Notified: milestone75Notified,
            nearCompletionNotified: nearCompletionNotified,
            completionNotified: completionNotified,
            createdAt: createdAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            required int targetAmountCents,
            Value<int> currentAmountCents = const Value.absent(),
            required DateTime startDate,
            required DateTime targetDate,
            required String frequency,
            Value<String> status = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<String> iconId = const Value.absent(),
            Value<String?> iconPath = const Value.absent(),
            Value<bool> milestone25Notified = const Value.absent(),
            Value<bool> milestone50Notified = const Value.absent(),
            Value<bool> milestone75Notified = const Value.absent(),
            Value<bool> nearCompletionNotified = const Value.absent(),
            Value<bool> completionNotified = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChallengesCompanion.insert(
            id: id,
            name: name,
            description: description,
            targetAmountCents: targetAmountCents,
            currentAmountCents: currentAmountCents,
            startDate: startDate,
            targetDate: targetDate,
            frequency: frequency,
            status: status,
            colorHex: colorHex,
            iconId: iconId,
            iconPath: iconPath,
            milestone25Notified: milestone25Notified,
            milestone50Notified: milestone50Notified,
            milestone75Notified: milestone75Notified,
            nearCompletionNotified: nearCompletionNotified,
            completionNotified: completionNotified,
            createdAt: createdAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChallengesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({savingsRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (savingsRecordsRefs) db.savingsRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (savingsRecordsRefs)
                    await $_getPrefetchedData<Challenge, $ChallengesTable,
                            SavingsRecord>(
                        currentTable: table,
                        referencedTable: $$ChallengesTableReferences
                            ._savingsRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChallengesTableReferences(db, table, p0)
                                .savingsRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.challengeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChallengesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChallengesTable,
    Challenge,
    $$ChallengesTableFilterComposer,
    $$ChallengesTableOrderingComposer,
    $$ChallengesTableAnnotationComposer,
    $$ChallengesTableCreateCompanionBuilder,
    $$ChallengesTableUpdateCompanionBuilder,
    (Challenge, $$ChallengesTableReferences),
    Challenge,
    PrefetchHooks Function({bool savingsRecordsRefs})>;
typedef $$SavingsRecordsTableCreateCompanionBuilder = SavingsRecordsCompanion
    Function({
  required String id,
  required String challengeId,
  required int amountCents,
  required DateTime date,
  Value<String?> note,
  Value<String?> proofPath,
  Value<int?> proofWidth,
  Value<int?> proofHeight,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SavingsRecordsTableUpdateCompanionBuilder = SavingsRecordsCompanion
    Function({
  Value<String> id,
  Value<String> challengeId,
  Value<int> amountCents,
  Value<DateTime> date,
  Value<String?> note,
  Value<String?> proofPath,
  Value<int?> proofWidth,
  Value<int?> proofHeight,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SavingsRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $SavingsRecordsTable, SavingsRecord> {
  $$SavingsRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChallengesTable _challengeIdTable(_$AppDatabase db) =>
      db.challenges.createAlias($_aliasNameGenerator(
          db.savingsRecords.challengeId, db.challenges.id));

  $$ChallengesTableProcessedTableManager get challengeId {
    final $_column = $_itemColumn<String>('challenge_id')!;

    final manager = $$ChallengesTableTableManager($_db, $_db.challenges)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_challengeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SavingsRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsRecordsTable> {
  $$SavingsRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get proofPath => $composableBuilder(
      column: $table.proofPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get proofWidth => $composableBuilder(
      column: $table.proofWidth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get proofHeight => $composableBuilder(
      column: $table.proofHeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChallengesTableFilterComposer get challengeId {
    final $$ChallengesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.challengeId,
        referencedTable: $db.challenges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChallengesTableFilterComposer(
              $db: $db,
              $table: $db.challenges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavingsRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsRecordsTable> {
  $$SavingsRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get proofPath => $composableBuilder(
      column: $table.proofPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get proofWidth => $composableBuilder(
      column: $table.proofWidth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get proofHeight => $composableBuilder(
      column: $table.proofHeight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChallengesTableOrderingComposer get challengeId {
    final $$ChallengesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.challengeId,
        referencedTable: $db.challenges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChallengesTableOrderingComposer(
              $db: $db,
              $table: $db.challenges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavingsRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsRecordsTable> {
  $$SavingsRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get proofPath =>
      $composableBuilder(column: $table.proofPath, builder: (column) => column);

  GeneratedColumn<int> get proofWidth => $composableBuilder(
      column: $table.proofWidth, builder: (column) => column);

  GeneratedColumn<int> get proofHeight => $composableBuilder(
      column: $table.proofHeight, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChallengesTableAnnotationComposer get challengeId {
    final $$ChallengesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.challengeId,
        referencedTable: $db.challenges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChallengesTableAnnotationComposer(
              $db: $db,
              $table: $db.challenges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavingsRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavingsRecordsTable,
    SavingsRecord,
    $$SavingsRecordsTableFilterComposer,
    $$SavingsRecordsTableOrderingComposer,
    $$SavingsRecordsTableAnnotationComposer,
    $$SavingsRecordsTableCreateCompanionBuilder,
    $$SavingsRecordsTableUpdateCompanionBuilder,
    (SavingsRecord, $$SavingsRecordsTableReferences),
    SavingsRecord,
    PrefetchHooks Function({bool challengeId})> {
  $$SavingsRecordsTableTableManager(
      _$AppDatabase db, $SavingsRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> challengeId = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> proofPath = const Value.absent(),
            Value<int?> proofWidth = const Value.absent(),
            Value<int?> proofHeight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsRecordsCompanion(
            id: id,
            challengeId: challengeId,
            amountCents: amountCents,
            date: date,
            note: note,
            proofPath: proofPath,
            proofWidth: proofWidth,
            proofHeight: proofHeight,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String challengeId,
            required int amountCents,
            required DateTime date,
            Value<String?> note = const Value.absent(),
            Value<String?> proofPath = const Value.absent(),
            Value<int?> proofWidth = const Value.absent(),
            Value<int?> proofHeight = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavingsRecordsCompanion.insert(
            id: id,
            challengeId: challengeId,
            amountCents: amountCents,
            date: date,
            note: note,
            proofPath: proofPath,
            proofWidth: proofWidth,
            proofHeight: proofHeight,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavingsRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({challengeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (challengeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.challengeId,
                    referencedTable:
                        $$SavingsRecordsTableReferences._challengeIdTable(db),
                    referencedColumn: $$SavingsRecordsTableReferences
                        ._challengeIdTable(db)
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
        ));
}

typedef $$SavingsRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavingsRecordsTable,
    SavingsRecord,
    $$SavingsRecordsTableFilterComposer,
    $$SavingsRecordsTableOrderingComposer,
    $$SavingsRecordsTableAnnotationComposer,
    $$SavingsRecordsTableCreateCompanionBuilder,
    $$SavingsRecordsTableUpdateCompanionBuilder,
    (SavingsRecord, $$SavingsRecordsTableReferences),
    SavingsRecord,
    PrefetchHooks Function({bool challengeId})>;
typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String id,
  required String displayName,
  Value<String?> avatarPath,
  Value<int> totalXp,
  Value<int> level,
  Value<String> rank,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String> unlockedAchievementIds,
  Value<String> locale,
  Value<bool> notificationsEnabled,
  Value<String> dailyReminderTime,
  Value<int> notificationDeclineCount,
  Value<DateTime?> lastNotificationPrompt,
  Value<bool> onboardingComplete,
  Value<bool> systemVoiceEnabled,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> id,
  Value<String> displayName,
  Value<String?> avatarPath,
  Value<int> totalXp,
  Value<int> level,
  Value<String> rank,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String> unlockedAchievementIds,
  Value<String> locale,
  Value<bool> notificationsEnabled,
  Value<String> dailyReminderTime,
  Value<int> notificationDeclineCount,
  Value<DateTime?> lastNotificationPrompt,
  Value<bool> onboardingComplete,
  Value<bool> systemVoiceEnabled,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockedAchievementIds => $composableBuilder(
      column: $table.unlockedAchievementIds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dailyReminderTime => $composableBuilder(
      column: $table.dailyReminderTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get notificationDeclineCount => $composableBuilder(
      column: $table.notificationDeclineCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastNotificationPrompt => $composableBuilder(
      column: $table.lastNotificationPrompt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get systemVoiceEnabled => $composableBuilder(
      column: $table.systemVoiceEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockedAchievementIds => $composableBuilder(
      column: $table.unlockedAchievementIds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dailyReminderTime => $composableBuilder(
      column: $table.dailyReminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get notificationDeclineCount => $composableBuilder(
      column: $table.notificationDeclineCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastNotificationPrompt => $composableBuilder(
      column: $table.lastNotificationPrompt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get systemVoiceEnabled => $composableBuilder(
      column: $table.systemVoiceEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<String> get unlockedAchievementIds => $composableBuilder(
      column: $table.unlockedAchievementIds, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<String> get dailyReminderTime => $composableBuilder(
      column: $table.dailyReminderTime, builder: (column) => column);

  GeneratedColumn<int> get notificationDeclineCount => $composableBuilder(
      column: $table.notificationDeclineCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastNotificationPrompt => $composableBuilder(
      column: $table.lastNotificationPrompt, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete, builder: (column) => column);

  GeneratedColumn<bool> get systemVoiceEnabled => $composableBuilder(
      column: $table.systemVoiceEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String?> avatarPath = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> rank = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String> unlockedAchievementIds = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String> dailyReminderTime = const Value.absent(),
            Value<int> notificationDeclineCount = const Value.absent(),
            Value<DateTime?> lastNotificationPrompt = const Value.absent(),
            Value<bool> onboardingComplete = const Value.absent(),
            Value<bool> systemVoiceEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            displayName: displayName,
            avatarPath: avatarPath,
            totalXp: totalXp,
            level: level,
            rank: rank,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            unlockedAchievementIds: unlockedAchievementIds,
            locale: locale,
            notificationsEnabled: notificationsEnabled,
            dailyReminderTime: dailyReminderTime,
            notificationDeclineCount: notificationDeclineCount,
            lastNotificationPrompt: lastNotificationPrompt,
            onboardingComplete: onboardingComplete,
            systemVoiceEnabled: systemVoiceEnabled,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String displayName,
            Value<String?> avatarPath = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> rank = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String> unlockedAchievementIds = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String> dailyReminderTime = const Value.absent(),
            Value<int> notificationDeclineCount = const Value.absent(),
            Value<DateTime?> lastNotificationPrompt = const Value.absent(),
            Value<bool> onboardingComplete = const Value.absent(),
            Value<bool> systemVoiceEnabled = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            displayName: displayName,
            avatarPath: avatarPath,
            totalXp: totalXp,
            level: level,
            rank: rank,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            unlockedAchievementIds: unlockedAchievementIds,
            locale: locale,
            notificationsEnabled: notificationsEnabled,
            dailyReminderTime: dailyReminderTime,
            notificationDeclineCount: notificationDeclineCount,
            lastNotificationPrompt: lastNotificationPrompt,
            onboardingComplete: onboardingComplete,
            systemVoiceEnabled: systemVoiceEnabled,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;
typedef $$AchievementsTableCreateCompanionBuilder = AchievementsCompanion
    Function({
  required String id,
  required String nameEn,
  required String nameFil,
  required String descriptionEn,
  required String descriptionFil,
  required String icon,
  required int xpReward,
  Value<int> rowid,
});
typedef $$AchievementsTableUpdateCompanionBuilder = AchievementsCompanion
    Function({
  Value<String> id,
  Value<String> nameEn,
  Value<String> nameFil,
  Value<String> descriptionEn,
  Value<String> descriptionFil,
  Value<String> icon,
  Value<int> xpReward,
  Value<int> rowid,
});

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameFil => $composableBuilder(
      column: $table.nameFil, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionFil => $composableBuilder(
      column: $table.descriptionFil,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameFil => $composableBuilder(
      column: $table.nameFil, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionFil => $composableBuilder(
      column: $table.descriptionFil,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameFil =>
      $composableBuilder(column: $table.nameFil, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn, builder: (column) => column);

  GeneratedColumn<String> get descriptionFil => $composableBuilder(
      column: $table.descriptionFil, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);
}

class $$AchievementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AchievementsTable,
    Achievement,
    $$AchievementsTableFilterComposer,
    $$AchievementsTableOrderingComposer,
    $$AchievementsTableAnnotationComposer,
    $$AchievementsTableCreateCompanionBuilder,
    $$AchievementsTableUpdateCompanionBuilder,
    (
      Achievement,
      BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>
    ),
    Achievement,
    PrefetchHooks Function()> {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String> nameFil = const Value.absent(),
            Value<String> descriptionEn = const Value.absent(),
            Value<String> descriptionFil = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AchievementsCompanion(
            id: id,
            nameEn: nameEn,
            nameFil: nameFil,
            descriptionEn: descriptionEn,
            descriptionFil: descriptionFil,
            icon: icon,
            xpReward: xpReward,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameEn,
            required String nameFil,
            required String descriptionEn,
            required String descriptionFil,
            required String icon,
            required int xpReward,
            Value<int> rowid = const Value.absent(),
          }) =>
              AchievementsCompanion.insert(
            id: id,
            nameEn: nameEn,
            nameFil: nameFil,
            descriptionEn: descriptionEn,
            descriptionFil: descriptionFil,
            icon: icon,
            xpReward: xpReward,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AchievementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AchievementsTable,
    Achievement,
    $$AchievementsTableFilterComposer,
    $$AchievementsTableOrderingComposer,
    $$AchievementsTableAnnotationComposer,
    $$AchievementsTableCreateCompanionBuilder,
    $$AchievementsTableUpdateCompanionBuilder,
    (
      Achievement,
      BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>
    ),
    Achievement,
    PrefetchHooks Function()>;
typedef $$NotificationLogsTableCreateCompanionBuilder
    = NotificationLogsCompanion Function({
  required String id,
  required String type,
  Value<String?> challengeId,
  required DateTime sentAt,
  Value<int> rowid,
});
typedef $$NotificationLogsTableUpdateCompanionBuilder
    = NotificationLogsCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String?> challengeId,
  Value<DateTime> sentAt,
  Value<int> rowid,
});

class $$NotificationLogsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationLogsTable> {
  $$NotificationLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get challengeId => $composableBuilder(
      column: $table.challengeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
      column: $table.sentAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationLogsTable> {
  $$NotificationLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get challengeId => $composableBuilder(
      column: $table.challengeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
      column: $table.sentAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationLogsTable> {
  $$NotificationLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get challengeId => $composableBuilder(
      column: $table.challengeId, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);
}

class $$NotificationLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationLogsTable,
    NotificationLog,
    $$NotificationLogsTableFilterComposer,
    $$NotificationLogsTableOrderingComposer,
    $$NotificationLogsTableAnnotationComposer,
    $$NotificationLogsTableCreateCompanionBuilder,
    $$NotificationLogsTableUpdateCompanionBuilder,
    (
      NotificationLog,
      BaseReferences<_$AppDatabase, $NotificationLogsTable, NotificationLog>
    ),
    NotificationLog,
    PrefetchHooks Function()> {
  $$NotificationLogsTableTableManager(
      _$AppDatabase db, $NotificationLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> challengeId = const Value.absent(),
            Value<DateTime> sentAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationLogsCompanion(
            id: id,
            type: type,
            challengeId: challengeId,
            sentAt: sentAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            Value<String?> challengeId = const Value.absent(),
            required DateTime sentAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationLogsCompanion.insert(
            id: id,
            type: type,
            challengeId: challengeId,
            sentAt: sentAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationLogsTable,
    NotificationLog,
    $$NotificationLogsTableFilterComposer,
    $$NotificationLogsTableOrderingComposer,
    $$NotificationLogsTableAnnotationComposer,
    $$NotificationLogsTableCreateCompanionBuilder,
    $$NotificationLogsTableUpdateCompanionBuilder,
    (
      NotificationLog,
      BaseReferences<_$AppDatabase, $NotificationLogsTable, NotificationLog>
    ),
    NotificationLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$SavingsRecordsTableTableManager get savingsRecords =>
      $$SavingsRecordsTableTableManager(_db, _db.savingsRecords);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$NotificationLogsTableTableManager get notificationLogs =>
      $$NotificationLogsTableTableManager(_db, _db.notificationLogs);
}
