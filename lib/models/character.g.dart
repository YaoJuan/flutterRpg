// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as String,
      name: json['name'] as String,
      slogan: json['slogan'] as String,
      vocation: $enumDecode(_$VocationEnumMap, json['vocation']),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slogan': instance.slogan,
      'vocation': _$VocationEnumMap[instance.vocation]!,
    };

const _$VocationEnumMap = {
  Vocation.raider: 'raider',
  Vocation.junkie: 'junkie',
  Vocation.ninja: 'ninja',
  Vocation.wizard: 'wizard',
};
