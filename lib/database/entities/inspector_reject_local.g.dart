// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspector_reject_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInspectorRejectLocalCollection on Isar {
  IsarCollection<InspectorRejectLocal> get inspectorRejectLocals =>
      this.collection();
}

const InspectorRejectLocalSchema = CollectionSchema(
  name: r'InspectorRejectLocal',
  id: -6691851383585235467,
  properties: {
    r'preSaleId': PropertySchema(
      id: 0,
      name: r'preSaleId',
      type: IsarType.long,
    )
  },
  estimateSize: _inspectorRejectLocalEstimateSize,
  serialize: _inspectorRejectLocalSerialize,
  deserialize: _inspectorRejectLocalDeserialize,
  deserializeProp: _inspectorRejectLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _inspectorRejectLocalGetId,
  getLinks: _inspectorRejectLocalGetLinks,
  attach: _inspectorRejectLocalAttach,
  version: '3.1.0+1',
);

int _inspectorRejectLocalEstimateSize(
  InspectorRejectLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _inspectorRejectLocalSerialize(
  InspectorRejectLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.preSaleId);
}

InspectorRejectLocal _inspectorRejectLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InspectorRejectLocal();
  object.id = id;
  object.preSaleId = reader.readLong(offsets[0]);
  return object;
}

P _inspectorRejectLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _inspectorRejectLocalGetId(InspectorRejectLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _inspectorRejectLocalGetLinks(
    InspectorRejectLocal object) {
  return [];
}

void _inspectorRejectLocalAttach(
    IsarCollection<dynamic> col, Id id, InspectorRejectLocal object) {
  object.id = id;
}

extension InspectorRejectLocalQueryWhereSort
    on QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QWhere> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InspectorRejectLocalQueryWhere
    on QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QWhereClause> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhereClause>
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterWhereClause>
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

extension InspectorRejectLocalQueryFilter on QueryBuilder<InspectorRejectLocal,
    InspectorRejectLocal, QFilterCondition> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
      QAfterFilterCondition> preSaleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preSaleId',
        value: value,
      ));
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal,
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

extension InspectorRejectLocalQueryObject on QueryBuilder<InspectorRejectLocal,
    InspectorRejectLocal, QFilterCondition> {}

extension InspectorRejectLocalQueryLinks on QueryBuilder<InspectorRejectLocal,
    InspectorRejectLocal, QFilterCondition> {}

extension InspectorRejectLocalQuerySortBy
    on QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QSortBy> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      sortByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.asc);
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      sortByPreSaleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.desc);
    });
  }
}

extension InspectorRejectLocalQuerySortThenBy
    on QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QSortThenBy> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      thenByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.asc);
    });
  }

  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QAfterSortBy>
      thenByPreSaleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preSaleId', Sort.desc);
    });
  }
}

extension InspectorRejectLocalQueryWhereDistinct
    on QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QDistinct> {
  QueryBuilder<InspectorRejectLocal, InspectorRejectLocal, QDistinct>
      distinctByPreSaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preSaleId');
    });
  }
}

extension InspectorRejectLocalQueryProperty on QueryBuilder<
    InspectorRejectLocal, InspectorRejectLocal, QQueryProperty> {
  QueryBuilder<InspectorRejectLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InspectorRejectLocal, int, QQueryOperations>
      preSaleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preSaleId');
    });
  }
}
