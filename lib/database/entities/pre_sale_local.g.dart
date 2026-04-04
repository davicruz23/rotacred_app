// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sale_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPreSaleLocalCollection on Isar {
  IsarCollection<PreSaleLocal> get preSaleLocals => this.collection();
}

const PreSaleLocalSchema = CollectionSchema(
  name: r'PreSaleLocal',
  id: 5432415997080780589,
  properties: {
    r'chargingId': PropertySchema(
      id: 0,
      name: r'chargingId',
      type: IsarType.long,
    ),
    r'clientAddress': PropertySchema(
      id: 1,
      name: r'clientAddress',
      type: IsarType.object,
      target: r'AddressLocal',
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
    r'clientPhone': PropertySchema(
      id: 5,
      name: r'clientPhone',
      type: IsarType.string,
    ),
    r'inspector': PropertySchema(
      id: 6,
      name: r'inspector',
      type: IsarType.string,
    ),
    r'localUuid': PropertySchema(
      id: 7,
      name: r'localUuid',
      type: IsarType.string,
    ),
    r'preSaleDate': PropertySchema(
      id: 8,
      name: r'preSaleDate',
      type: IsarType.dateTime,
    ),
    r'sellerId': PropertySchema(
      id: 9,
      name: r'sellerId',
      type: IsarType.long,
    ),
    r'sellerName': PropertySchema(
      id: 10,
      name: r'sellerName',
      type: IsarType.string,
    ),
    r'serverId': PropertySchema(
      id: 11,
      name: r'serverId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 12,
      name: r'status',
      type: IsarType.string,
    ),
    r'synced': PropertySchema(
      id: 13,
      name: r'synced',
      type: IsarType.bool,
    ),
    r'totalPreSale': PropertySchema(
      id: 14,
      name: r'totalPreSale',
      type: IsarType.double,
    )
  },
  estimateSize: _preSaleLocalEstimateSize,
  serialize: _preSaleLocalSerialize,
  deserialize: _preSaleLocalDeserialize,
  deserializeProp: _preSaleLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AddressLocal': AddressLocalSchema},
  getId: _preSaleLocalGetId,
  getLinks: _preSaleLocalGetLinks,
  attach: _preSaleLocalAttach,
  version: '3.1.0+1',
);

int _preSaleLocalEstimateSize(
  PreSaleLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.clientAddress;
    if (value != null) {
      bytesCount += 3 +
          AddressLocalSchema.estimateSize(
              value, allOffsets[AddressLocal]!, allOffsets);
    }
  }
  bytesCount += 3 + object.clientCpf.length * 3;
  bytesCount += 3 + object.clientName.length * 3;
  bytesCount += 3 + object.clientPhone.length * 3;
  {
    final value = object.inspector;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localUuid.length * 3;
  bytesCount += 3 + object.sellerName.length * 3;
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _preSaleLocalSerialize(
  PreSaleLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.chargingId);
  writer.writeObject<AddressLocal>(
    offsets[1],
    allOffsets,
    AddressLocalSchema.serialize,
    object.clientAddress,
  );
  writer.writeString(offsets[2], object.clientCpf);
  writer.writeLong(offsets[3], object.clientId);
  writer.writeString(offsets[4], object.clientName);
  writer.writeString(offsets[5], object.clientPhone);
  writer.writeString(offsets[6], object.inspector);
  writer.writeString(offsets[7], object.localUuid);
  writer.writeDateTime(offsets[8], object.preSaleDate);
  writer.writeLong(offsets[9], object.sellerId);
  writer.writeString(offsets[10], object.sellerName);
  writer.writeLong(offsets[11], object.serverId);
  writer.writeString(offsets[12], object.status);
  writer.writeBool(offsets[13], object.synced);
  writer.writeDouble(offsets[14], object.totalPreSale);
}

PreSaleLocal _preSaleLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PreSaleLocal();
  object.chargingId = reader.readLongOrNull(offsets[0]);
  object.clientAddress = reader.readObjectOrNull<AddressLocal>(
    offsets[1],
    AddressLocalSchema.deserialize,
    allOffsets,
  );
  object.clientCpf = reader.readString(offsets[2]);
  object.clientId = reader.readLong(offsets[3]);
  object.clientName = reader.readString(offsets[4]);
  object.clientPhone = reader.readString(offsets[5]);
  object.id = id;
  object.inspector = reader.readStringOrNull(offsets[6]);
  object.localUuid = reader.readString(offsets[7]);
  object.preSaleDate = reader.readDateTime(offsets[8]);
  object.sellerId = reader.readLong(offsets[9]);
  object.sellerName = reader.readString(offsets[10]);
  object.serverId = reader.readLongOrNull(offsets[11]);
  object.status = reader.readStringOrNull(offsets[12]);
  object.synced = reader.readBool(offsets[13]);
  object.totalPreSale = reader.readDoubleOrNull(offsets[14]);
  return object;
}

P _preSaleLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<AddressLocal>(
        offset,
        AddressLocalSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _preSaleLocalGetId(PreSaleLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _preSaleLocalGetLinks(PreSaleLocal object) {
  return [];
}

void _preSaleLocalAttach(
    IsarCollection<dynamic> col, Id id, PreSaleLocal object) {
  object.id = id;
}

extension PreSaleLocalQueryWhereSort
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QWhere> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PreSaleLocalQueryWhere
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QWhereClause> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterWhereClause> idBetween(
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

extension PreSaleLocalQueryFilter
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QFilterCondition> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chargingId',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chargingId',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chargingId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chargingId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chargingId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      chargingIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chargingId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clientAddress',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clientAddress',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfEqualTo(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfStartsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfEndsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientCpf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientCpf',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientCpf',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientCpfIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientCpf',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientIdGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientIdLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientIdBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameEqualTo(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameStartsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameEndsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneEqualTo(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneStartsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneEndsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      clientPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inspector',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inspector',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inspector',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inspector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inspector',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inspector',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      inspectorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inspector',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      localUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      preSaleDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preSaleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      preSaleDateGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      preSaleDateLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      preSaleDateBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerIdGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerIdLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerIdBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameEqualTo(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameGreaterThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameLessThan(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameBetween(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameStartsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameEndsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sellerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sellerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerName',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      sellerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sellerName',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverId',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverId',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdGreaterThan(
    int? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdLessThan(
    int? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      serverIdBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> statusEqualTo(
    String? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusGreaterThan(
    String? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusLessThan(
    String? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusStartsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusEndsWith(
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalPreSale',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalPreSale',
      ));
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleEqualTo(
    double? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleGreaterThan(
    double? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleLessThan(
    double? value, {
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

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition>
      totalPreSaleBetween(
    double? lower,
    double? upper, {
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

extension PreSaleLocalQueryObject
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QFilterCondition> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterFilterCondition> clientAddress(
      FilterQuery<AddressLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'clientAddress');
    });
  }
}

extension PreSaleLocalQueryLinks
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QFilterCondition> {}

extension PreSaleLocalQuerySortBy
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QSortBy> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByChargingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortByChargingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByClientPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortByClientPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByInspector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspector', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByInspectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspector', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByLocalUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByLocalUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortByPreSaleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortBySellerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortBySellerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortBySellerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> sortByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      sortByTotalPreSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.desc);
    });
  }
}

extension PreSaleLocalQuerySortThenBy
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QSortThenBy> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByChargingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenByChargingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientCpf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientCpfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientCpf', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByClientPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenByClientPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientPhone', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByInspector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspector', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByInspectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inspector', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByLocalUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByLocalUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUuid', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenByPreSaleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleDate', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenBySellerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenBySellerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenBySellerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerName', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy> thenByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.asc);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QAfterSortBy>
      thenByTotalPreSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPreSale', Sort.desc);
    });
  }
}

extension PreSaleLocalQueryWhereDistinct
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> {
  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByChargingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chargingId');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByClientCpf(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientCpf', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByClientName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByClientPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByInspector(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inspector', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByLocalUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByPreSaleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preSaleDate');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctBySellerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerId');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctBySellerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverId');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }

  QueryBuilder<PreSaleLocal, PreSaleLocal, QDistinct> distinctByTotalPreSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPreSale');
    });
  }
}

extension PreSaleLocalQueryProperty
    on QueryBuilder<PreSaleLocal, PreSaleLocal, QQueryProperty> {
  QueryBuilder<PreSaleLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PreSaleLocal, int?, QQueryOperations> chargingIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chargingId');
    });
  }

  QueryBuilder<PreSaleLocal, AddressLocal?, QQueryOperations>
      clientAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientAddress');
    });
  }

  QueryBuilder<PreSaleLocal, String, QQueryOperations> clientCpfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientCpf');
    });
  }

  QueryBuilder<PreSaleLocal, int, QQueryOperations> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<PreSaleLocal, String, QQueryOperations> clientNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientName');
    });
  }

  QueryBuilder<PreSaleLocal, String, QQueryOperations> clientPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientPhone');
    });
  }

  QueryBuilder<PreSaleLocal, String?, QQueryOperations> inspectorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inspector');
    });
  }

  QueryBuilder<PreSaleLocal, String, QQueryOperations> localUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localUuid');
    });
  }

  QueryBuilder<PreSaleLocal, DateTime, QQueryOperations> preSaleDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preSaleDate');
    });
  }

  QueryBuilder<PreSaleLocal, int, QQueryOperations> sellerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerId');
    });
  }

  QueryBuilder<PreSaleLocal, String, QQueryOperations> sellerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerName');
    });
  }

  QueryBuilder<PreSaleLocal, int?, QQueryOperations> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverId');
    });
  }

  QueryBuilder<PreSaleLocal, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<PreSaleLocal, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }

  QueryBuilder<PreSaleLocal, double?, QQueryOperations> totalPreSaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPreSale');
    });
  }
}
