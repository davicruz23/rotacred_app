// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspector_pre_sale_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInspectorPreSaleLocalCollection on Isar {
  IsarCollection<InspectorPreSaleLocal> get inspectorPreSaleLocals =>
      this.collection();
}

const InspectorPreSaleLocalSchema = CollectionSchema(
  name: r'InspectorPreSaleLocal',
  id: 7826690438102750763,
  properties: {
    r'clientCity': PropertySchema(
      id: 0,
      name: r'clientCity',
      type: IsarType.string,
    ),
    r'clientComplement': PropertySchema(
      id: 1,
      name: r'clientComplement',
      type: IsarType.string,
    ),
    r'clientCpf': PropertySchema(
      id: 2,
      name: r'clientCpf',
      type: IsarType.string,
    ),
    r'clientId': PropertySchema(
      id: 3,
      name: r'clientId',
      type: IsarType.long,
    ),
    r'clientName': PropertySchema(
      id: 4,
      name: r'clientName',
      type: IsarType.string,
    ),
    r'clientNumber': PropertySchema(
      id: 5,
      name: r'clientNumber',
      type: IsarType.string,
    ),
    r'clientPhone': PropertySchema(
      id: 6,
      name: r'clientPhone',
      type: IsarType.string,
    ),
    r'clientState': PropertySchema(
      id: 7,
      name: r'clientState',
      type: IsarType.string,
    ),
    r'clientStreet': PropertySchema(
      id: 8,
      name: r'clientStreet',
      type: IsarType.string,
    ),
    r'clientZipCode': PropertySchema(
      id: 9,
      name: r'clientZipCode',
      type: IsarType.string,
    ),
    r'inspectorId': PropertySchema(
      id: 10,
      name: r'inspectorId',
      type: IsarType.long,
    ),
    r'itemsJson': PropertySchema(
      id: 11,
      name: r'itemsJson',
      type: IsarType.string,
    ),
    r'preSaleDate': PropertySchema(
      id: 12,
      name: r'preSaleDate',
      type: IsarType.dateTime,
    ),
    r'sellerId': PropertySchema(
      id: 13,
      name: r'sellerId',
      type: IsarType.long,
    ),
    r'sellerName': PropertySchema(
      id: 14,
      name: r'sellerName',
      type: IsarType.string,
    ),
    r'serverId': PropertySchema(
      id: 15,
      name: r'serverId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 16,
      name: r'status',
      type: IsarType.string,
    ),
    r'totalPreSale': PropertySchema(
      id: 17,
      name: r'totalPreSale',
      type: IsarType.double,
    )
  },
  estimateSize: _inspectorPreSaleLocalEstimateSize,
  serialize: _inspectorPreSaleLocalSerialize,
  deserialize: _inspectorPreSaleLocalDeserialize,
  deserializeProp: _inspectorPreSaleLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _inspectorPreSaleLocalGetId,
  getLinks: _inspectorPreSaleLocalGetLinks,
  attach: _inspectorPreSaleLocalAttach,
  version: '3.1.0+1',
);

int _inspectorPreSaleLocalEstimateSize(
  InspectorPreSaleLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clientCity.length * 3;
  bytesCount += 3 + object.clientComplement.length * 3;
  bytesCount += 3 + object.clientCpf.length * 3;
  bytesCount += 3 + object.clientName.length * 3;
  bytesCount += 3 + object.clientNumber.length * 3;
  bytesCount += 3 + object.clientPhone.length * 3;
  bytesCount += 3 + object.clientState.length * 3;
  bytesCount += 3 + object.clientStreet.length * 3;
  bytesCount += 3 + object.clientZipCode.length * 3;
  bytesCount += 3 + object.itemsJson.length * 3;
  bytesCount += 3 + object.sellerName.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _inspectorPreSaleLocalSerialize(
  InspectorPreSaleLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clientCity);
  writer.writeString(offsets[1], object.clientComplement);
  writer.writeString(offsets[2], object.clientCpf);
  writer.writeLong(offsets[3], object.clientId);
  writer.writeString(offsets[4], object.clientName);
  writer.writeString(offsets[5], object.clientNumber);
  writer.writeString(offsets[6], object.clientPhone);
  writer.writeString(offsets[7], object.clientState);
  writer.writeString(offsets[8], object.clientStreet);
  writer.writeString(offsets[9], object.clientZipCode);
  writer.writeLong(offsets[10], object.inspectorId);
  writer.writeString(offsets[11], object.itemsJson);
  writer.writeDateTime(offsets[12], object.preSaleDate);
  writer.writeLong(offsets[13], object.sellerId);
  writer.writeString(offsets[14], object.sellerName);
  writer.writeLong(offsets[15], object.serverId);
  writer.writeString(offsets[16], object.status);
  writer.writeDouble(offsets[17], object.totalPreSale);
}

InspectorPreSaleLocal _inspectorPreSaleLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InspectorPreSaleLocal();
  object.clientCity = reader.readString(offsets[0]);
  object.clientComplement = reader.readString(offsets[1]);
  object.clientCpf = reader.readString(offsets[2]);
  object.clientId = reader.readLong(offsets[3]);
  object.clientName = reader.readString(offsets[4]);
  object.clientNumber = reader.readString(offsets[5]);
  object.clientPhone = reader.readString(offsets[6]);
  object.clientState = reader.readString(offsets[7]);
  object.clientStreet = reader.readString(offsets[8]);
  object.clientZipCode = reader.readString(offsets[9]);
  object.id = id;
  object.inspectorId = reader.readLong(offsets[10]);
  object.itemsJson = reader.readString(offsets[11]);
  object.preSaleDate = reader.readDateTime(offsets[12]);
  object.sellerId = reader.readLong(offsets[13]);
  object.sellerName = reader.readString(offsets[14]);
  object.serverId = reader.readLong(offsets[15]);
  object.status = reader.readString(offsets[16]);
  object.totalPreSale = reader.readDouble(offsets[17]);
  return object;
}

P _inspectorPreSaleLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _inspectorPreSaleLocalGetId(InspectorPreSaleLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _inspectorPreSaleLocalGetLinks(
    InspectorPreSaleLocal object) {
  return [];
}

void _inspectorPreSaleLocalAttach(
    IsarCollection<dynamic> col, Id id, InspectorPreSaleLocal object) {
  object.id = id;
}

extension InspectorPreSaleLocalQueryWhereSort
    on QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QWhere> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InspectorPreSaleLocalQueryWhere on QueryBuilder<InspectorPreSaleLocal,
    InspectorPreSaleLocal, QWhereClause> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhereClause>
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterWhereClause>
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

extension InspectorPreSaleLocalQueryFilter on QueryBuilder<
    InspectorPreSaleLocal, InspectorPreSaleLocal, QFilterCondition> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientCity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientCityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientCity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientCityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientCity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCity',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientCity',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientComplement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientComplementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientComplement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientComplementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientComplement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientComplement',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientComplementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientComplement',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientCpf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientCpfContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientCpfMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientCpf',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCpf',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientCpfIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientCpf',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientStateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientStateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientState',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientState',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientStreet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientStreetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientStreet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientStreetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientStreet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientStreet',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientStreetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientStreet',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientZipCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientZipCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientZipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      clientZipCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientZipCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientZipCode',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> clientZipCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientZipCode',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> inspectorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inspectorId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
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

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      itemsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      itemsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> itemsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> preSaleDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preSaleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> preSaleDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preSaleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> preSaleDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preSaleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> preSaleDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preSaleDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellerId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellerId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      sellerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      sellerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sellerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerName',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> sellerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sellerName',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> serverIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> serverIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> serverIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> serverIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
          QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> totalPreSaleEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPreSale',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> totalPreSaleGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPreSale',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> totalPreSaleLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPreSale',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal,
      QAfterFilterCondition> totalPreSaleBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPreSale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension InspectorPreSaleLocalQueryObject on QueryBuilder<
    InspectorPreSaleLocal, InspectorPreSaleLocal, QFilterCondition> {}

extension InspectorPreSaleLocalQueryLinks on QueryBuilder<InspectorPreSaleLocal,
    InspectorPreSaleLocal, QFilterCondition> {}

extension InspectorPreSaleLocalQuerySortBy
    on QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QSortBy> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCity', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCity', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientComplement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientComplement', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientComplementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientComplement', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientNumber', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientNumber', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientState', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientState', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientStreet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientStreet', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientStreetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientStreet', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientZipCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientZipCode', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByClientZipCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientZipCode', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByInspectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByItemsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByItemsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByPreSaleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortBySellerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortBySellerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortBySellerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      sortByTotalPreSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.desc);
    });
  }
}

extension InspectorPreSaleLocalQuerySortThenBy
    on QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QSortThenBy> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCity', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCity', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientComplement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientComplement', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientComplementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientComplement', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientNumber', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientNumber', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientState', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientState', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientStreet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientStreet', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientStreetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientStreet', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientZipCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientZipCode', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByClientZipCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientZipCode', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByInspectorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspectorId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByItemsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByItemsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByPreSaleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenBySellerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenBySellerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenBySellerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.asc);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QAfterSortBy>
      thenByTotalPreSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.desc);
    });
  }
}

extension InspectorPreSaleLocalQueryWhereDistinct
    on QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct> {
  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientCity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientCity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientComplement({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientComplement',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientCpf({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientCpf', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientState({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientState', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientStreet({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientStreet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByClientZipCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientZipCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByInspectorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inspectorId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByItemsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemsJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preSaleDate');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctBySellerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectorPreSaleLocal, InspectorPreSaleLocal, QDistinct>
      distinctByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPreSale');
    });
  }
}

extension InspectorPreSaleLocalQueryProperty on QueryBuilder<
    InspectorPreSaleLocal, InspectorPreSaleLocal, QQueryProperty> {
  QueryBuilder<InspectorPreSaleLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientCityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientCity');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientComplementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientComplement');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientCpfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientCpf');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, int, QQueryOperations>
      clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientName');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientNumber');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientPhone');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientState');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientStreetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientStreet');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      clientZipCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientZipCode');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, int, QQueryOperations>
      inspectorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inspectorId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      itemsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemsJson');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, DateTime, QQueryOperations>
      preSaleDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preSaleDate');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, int, QQueryOperations>
      sellerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      sellerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerName');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, int, QQueryOperations>
      serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverId');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, String, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<InspectorPreSaleLocal, double, QQueryOperations>
      totalPreSaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPreSale');
    });
  }
}
