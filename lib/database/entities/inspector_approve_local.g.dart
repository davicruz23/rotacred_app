// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspector_approve_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInspectorApproveLocalCollection on Isar {
  IsarCollection<InspectorApproveLocal> get inspectorApproveLocals =>
      this.collection();
}

const InspectorApproveLocalSchema = CollectionSchema(
  name: r'InspectorApproveLocal',
  id: -3285414789306395215,
  properties: {
    r'cashPaid': PropertySchema(
      id: 0,
      name: r'cashPaid',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'inspectorId': PropertySchema(
      id: 2,
      name: r'inspectorId',
      type: IsarType.long,
    ),
    r'installments': PropertySchema(
      id: 3,
      name: r'installments',
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
    r'paymentMethod': PropertySchema(
      id: 6,
      name: r'paymentMethod',
      type: IsarType.string,
    ),
    r'preSaleId': PropertySchema(
      id: 7,
      name: r'preSaleId',
      type: IsarType.long,
    )
  },
  estimateSize: _inspectorApproveLocalEstimateSize,
  serialize: _inspectorApproveLocalSerialize,
  deserialize: _inspectorApproveLocalDeserialize,
  deserializeProp: _inspectorApproveLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _inspectorApproveLocalGetId,
  getLinks: _inspectorApproveLocalGetLinks,
  attach: _inspectorApproveLocalAttach,
  version: '3.1.0+1',
);

int _inspectorApproveLocalEstimateSize(
  InspectorApproveLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.paymentMethod.length * 3;
  return bytesCount;
}

void _inspectorApproveLocalSerialize(
  InspectorApproveLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cashPaid);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.inspectorId);
  writer.writeLong(offsets[3], object.installments);
  writer.writeDouble(offsets[4], object.latitude);
  writer.writeDouble(offsets[5], object.longitude);
  writer.writeString(offsets[6], object.paymentMethod);
  writer.writeLong(offsets[7], object.preSaleId);
}

InspectorApproveLocal _inspectorApproveLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InspectorApproveLocal();
  object.cashPaid = reader.readDoubleOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.inspectorId = reader.readLong(offsets[2]);
  object.installments = reader.readLong(offsets[3]);
  object.latitude = reader.readDoubleOrNull(offsets[4]);
  object.longitude = reader.readDoubleOrNull(offsets[5]);
  object.paymentMethod = reader.readString(offsets[6]);
  object.preSaleId = reader.readLong(offsets[7]);
  return object;
}

P _inspectorApproveLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _inspectorApproveLocalGetId(InspectorApproveLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _inspectorApproveLocalGetLinks(
    InspectorApproveLocal object) {
  return [];
}

void _inspectorApproveLocalAttach(
    IsarCollection<dynamic> col, Id id, InspectorApproveLocal object) {
  object.id = id;
}

extension InspectorApproveLocalQueryWhereSort
    on QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QWhere> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InspectorApproveLocalQueryWhere on QueryBuilder<InspectorApproveLocal,
    InspectorApproveLocal, QWhereClause> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterWhereClause>
      idBetween(
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

extension InspectorApproveLocalQueryFilter on QueryBuilder<
    InspectorApproveLocal, InspectorApproveLocal, QFilterCondition> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cashPaid',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cashPaid',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cashPaid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cashPaid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cashPaid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> cashPaidBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cashPaid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> inspectorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inspectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> inspectorIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inspectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> inspectorIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inspectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> inspectorIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inspectorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> installmentsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installments',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> installmentsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'installments',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> installmentsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'installments',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> installmentsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'installments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeEqualTo(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeGreaterThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeLessThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> latitudeBetween(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeEqualTo(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeGreaterThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeLessThan(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> longitudeBetween(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodEqualTo(
    String value, {
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodGreaterThan(
    String value, {
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodLessThan(
    String value, {
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodBetween(
    String lower,
    String upper, {
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodStartsWith(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodEndsWith(
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

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
          QAfterFilterCondition>
      paymentMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
          QAfterFilterCondition>
      paymentMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> paymentMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> preSaleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preSaleId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> preSaleIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preSaleId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> preSaleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preSaleId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal,
      QAfterFilterCondition> preSaleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preSaleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InspectorApproveLocalQueryObject on QueryBuilder<
    InspectorApproveLocal, InspectorApproveLocal, QFilterCondition> {}

extension InspectorApproveLocalQueryLinks on QueryBuilder<InspectorApproveLocal,
    InspectorApproveLocal, QFilterCondition> {}

extension InspectorApproveLocalQuerySortBy
    on QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QSortBy> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByCashPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashPaid', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByCashPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashPaid', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByInspectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByInstallments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installments', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByInstallmentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installments', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      sortByPreSaleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.desc);
    });
  }
}

extension InspectorApproveLocalQuerySortThenBy
    on QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QSortThenBy> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByCashPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashPaid', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByCashPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashPaid', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByInspectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByInstallments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installments', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByInstallmentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installments', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.asc);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QAfterSortBy>
      thenByPreSaleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.desc);
    });
  }
}

extension InspectorApproveLocalQueryWhereDistinct
    on QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct> {
  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByCashPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cashPaid');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inspectorId');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByInstallments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'installments');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorApproveLocal, InspectorApproveLocal, QDistinct>
      distinctByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preSaleId');
    });
  }
}

extension InspectorApproveLocalQueryProperty on QueryBuilder<
    InspectorApproveLocal, InspectorApproveLocal, QQueryProperty> {
  QueryBuilder<InspectorApproveLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InspectorApproveLocal, double?, QQueryOperations>
      cashPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cashPaid');
    });
  }

  QueryBuilder<InspectorApproveLocal, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<InspectorApproveLocal, int, QQueryOperations>
      inspectorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inspectorId');
    });
  }

  QueryBuilder<InspectorApproveLocal, int, QQueryOperations>
      installmentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'installments');
    });
  }

  QueryBuilder<InspectorApproveLocal, double?, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<InspectorApproveLocal, double?, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<InspectorApproveLocal, String, QQueryOperations>
      paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentMethod');
    });
  }

  QueryBuilder<InspectorApproveLocal, int, QQueryOperations>
      preSaleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preSaleId');
    });
  }
}
