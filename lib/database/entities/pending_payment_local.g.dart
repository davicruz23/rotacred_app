// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_payment_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPendingPaymentCollection on Isar {
  IsarCollection<PendingPayment> get pendingPayments => this.collection();
}

const PendingPaymentSchema = CollectionSchema(
  name: r'PendingPayment',
  id: -2078600070721413568,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'collectorId': PropertySchema(
      id: 1,
      name: r'collectorId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'installmentId': PropertySchema(
      id: 3,
      name: r'installmentId',
      type: IsarType.long,
    ),
    r'latitude': PropertySchema(
      id: 4,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 5,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'newDueDate': PropertySchema(
      id: 6,
      name: r'newDueDate',
      type: IsarType.dateTime,
    ),
    r'note': PropertySchema(
      id: 7,
      name: r'note',
      type: IsarType.string,
    ),
    r'paySent': PropertySchema(
      id: 8,
      name: r'paySent',
      type: IsarType.bool,
    ),
    r'paymentMethod': PropertySchema(
      id: 9,
      name: r'paymentMethod',
      type: IsarType.string,
    ),
    r'requiresPaySale': PropertySchema(
      id: 10,
      name: r'requiresPaySale',
      type: IsarType.bool,
    )
  },
  estimateSize: _pendingPaymentEstimateSize,
  serialize: _pendingPaymentSerialize,
  deserialize: _pendingPaymentDeserialize,
  deserializeProp: _pendingPaymentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pendingPaymentGetId,
  getLinks: _pendingPaymentGetLinks,
  attach: _pendingPaymentAttach,
  version: '3.1.0+1',
);

int _pendingPaymentEstimateSize(
  PendingPayment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _pendingPaymentSerialize(
  PendingPayment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeLong(offsets[1], object.collectorId);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.installmentId);
  writer.writeDouble(offsets[4], object.latitude);
  writer.writeDouble(offsets[5], object.longitude);
  writer.writeDateTime(offsets[6], object.newDueDate);
  writer.writeString(offsets[7], object.note);
  writer.writeBool(offsets[8], object.paySent);
  writer.writeString(offsets[9], object.paymentMethod);
  writer.writeBool(offsets[10], object.requiresPaySale);
}

PendingPayment _pendingPaymentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PendingPayment();
  object.amount = reader.readDoubleOrNull(offsets[0]);
  object.collectorId = reader.readLong(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.installmentId = reader.readLong(offsets[3]);
  object.latitude = reader.readDoubleOrNull(offsets[4]);
  object.longitude = reader.readDoubleOrNull(offsets[5]);
  object.newDueDate = reader.readDateTimeOrNull(offsets[6]);
  object.note = reader.readStringOrNull(offsets[7]);
  object.paySent = reader.readBool(offsets[8]);
  object.paymentMethod = reader.readStringOrNull(offsets[9]);
  object.requiresPaySale = reader.readBool(offsets[10]);
  return object;
}

P _pendingPaymentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pendingPaymentGetId(PendingPayment object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pendingPaymentGetLinks(PendingPayment object) {
  return [];
}

void _pendingPaymentAttach(
    IsarCollection<dynamic> col, Id id, PendingPayment object) {
  object.id = id;
}

extension PendingPaymentQueryWhereSort
    on QueryBuilder<PendingPayment, PendingPayment, QWhere> {
  QueryBuilder<PendingPayment, PendingPayment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PendingPaymentQueryWhere
    on QueryBuilder<PendingPayment, PendingPayment, QWhereClause> {
  QueryBuilder<PendingPayment, PendingPayment, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PendingPaymentQueryFilter
    on QueryBuilder<PendingPayment, PendingPayment, QFilterCondition> {
  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      amountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      collectorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      collectorIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      collectorIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      collectorIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      installmentIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installmentId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      installmentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'installmentId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      installmentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'installmentId',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      installmentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'installmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newDueDate',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newDueDate',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      newDueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paySentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paySent',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentMethod',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentMethod',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      paymentMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterFilterCondition>
      requiresPaySaleEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiresPaySale',
        value: value,
      ));
    });
  }
}

extension PendingPaymentQueryObject
    on QueryBuilder<PendingPayment, PendingPayment, QFilterCondition> {}

extension PendingPaymentQueryLinks
    on QueryBuilder<PendingPayment, PendingPayment, QFilterCondition> {}

extension PendingPaymentQuerySortBy
    on QueryBuilder<PendingPayment, PendingPayment, QSortBy> {
  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByCollectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectorId', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByCollectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectorId', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByInstallmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installmentId', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByInstallmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installmentId', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByNewDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDueDate', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByNewDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDueDate', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> sortByPaySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paySent', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByPaySentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paySent', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByRequiresPaySale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresPaySale', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      sortByRequiresPaySaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresPaySale', Sort.desc);
    });
  }
}

extension PendingPaymentQuerySortThenBy
    on QueryBuilder<PendingPayment, PendingPayment, QSortThenBy> {
  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByCollectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectorId', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByCollectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectorId', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByInstallmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installmentId', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByInstallmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installmentId', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByNewDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDueDate', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByNewDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newDueDate', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy> thenByPaySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paySent', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByPaySentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paySent', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByRequiresPaySale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresPaySale', Sort.asc);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QAfterSortBy>
      thenByRequiresPaySaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresPaySale', Sort.desc);
    });
  }
}

extension PendingPaymentQueryWhereDistinct
    on QueryBuilder<PendingPayment, PendingPayment, QDistinct> {
  QueryBuilder<PendingPayment, PendingPayment, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByCollectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectorId');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByInstallmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'installmentId');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByNewDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newDueDate');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct> distinctByPaySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paySent');
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingPayment, PendingPayment, QDistinct>
      distinctByRequiresPaySale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requiresPaySale');
    });
  }
}

extension PendingPaymentQueryProperty
    on QueryBuilder<PendingPayment, PendingPayment, QQueryProperty> {
  QueryBuilder<PendingPayment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PendingPayment, double?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<PendingPayment, int, QQueryOperations> collectorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectorId');
    });
  }

  QueryBuilder<PendingPayment, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PendingPayment, int, QQueryOperations> installmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'installmentId');
    });
  }

  QueryBuilder<PendingPayment, double?, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<PendingPayment, double?, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<PendingPayment, DateTime?, QQueryOperations>
      newDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newDueDate');
    });
  }

  QueryBuilder<PendingPayment, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<PendingPayment, bool, QQueryOperations> paySentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paySent');
    });
  }

  QueryBuilder<PendingPayment, String?, QQueryOperations>
      paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentMethod');
    });
  }

  QueryBuilder<PendingPayment, bool, QQueryOperations>
      requiresPaySaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requiresPaySale');
    });
  }
}
