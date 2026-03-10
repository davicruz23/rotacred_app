// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_local.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AddressLocalSchema = Schema(
  name: r'AddressLocal',
  id: -6193487215922631433,
  properties: {
    r'city': PropertySchema(
      id: 0,
      name: r'city',
      type: IsarType.string,
    ),
    r'complement': PropertySchema(
      id: 1,
      name: r'complement',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 2,
      name: r'number',
      type: IsarType.string,
    ),
    r'state': PropertySchema(
      id: 3,
      name: r'state',
      type: IsarType.string,
    ),
    r'street': PropertySchema(
      id: 4,
      name: r'street',
      type: IsarType.string,
    ),
    r'zipCode': PropertySchema(
      id: 5,
      name: r'zipCode',
      type: IsarType.string,
    )
  },
  estimateSize: _addressLocalEstimateSize,
  serialize: _addressLocalSerialize,
  deserialize: _addressLocalDeserialize,
  deserializeProp: _addressLocalDeserializeProp,
);

int _addressLocalEstimateSize(
  AddressLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.city;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.complement;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.number;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.state;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.street;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.zipCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _addressLocalSerialize(
  AddressLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.city);
  writer.writeString(offsets[1], object.complement);
  writer.writeString(offsets[2], object.number);
  writer.writeString(offsets[3], object.state);
  writer.writeString(offsets[4], object.street);
  writer.writeString(offsets[5], object.zipCode);
}

AddressLocal _addressLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AddressLocal();
  object.city = reader.readStringOrNull(offsets[0]);
  object.complement = reader.readStringOrNull(offsets[1]);
  object.number = reader.readStringOrNull(offsets[2]);
  object.state = reader.readStringOrNull(offsets[3]);
  object.street = reader.readStringOrNull(offsets[4]);
  object.zipCode = reader.readStringOrNull(offsets[5]);
  return object;
}

P _addressLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AddressLocalQueryFilter
    on QueryBuilder<AddressLocal, AddressLocal, QFilterCondition> {
  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      cityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> cityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'complement',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'complement',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'complement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'complement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'complement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'complement',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      complementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'complement',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> numberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> numberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> numberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      numberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> stateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'street',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'street',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> streetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> streetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'street',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'street',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition> streetMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'street',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      streetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'street',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zipCode',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zipCode',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zipCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zipCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zipCode',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressLocal, AddressLocal, QAfterFilterCondition>
      zipCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zipCode',
        value: '',
      ));
    });
  }
}

extension AddressLocalQueryObject
    on QueryBuilder<AddressLocal, AddressLocal, QFilterCondition> {}
