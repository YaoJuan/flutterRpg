import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/services/firestore_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable()
class Character with Stats  implements FirestoreModel{
  // constructor
  Character(
      {required this.id,
      required this.name,
      required this.slogan,
      required this.vocation});

  // fields
  final Set<Skill> skills = {};
  final String id;
  final String name;
  final String slogan;
  bool _isFav = false;
  final Vocation vocation;

  // getters;
  bool get isFavorite => _isFav;

  // methods
  void toggleFavorite() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

   // character to firestore (map)
  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'isFav': _isFav,
      'vocation': vocation.toString(),
      'skills': skills.map((s) => s.id).toList(),
      'stats': statsAsMap,
      'points': points
    };
  }

  // return querySnapshot.docs.map((doc) => fromFirestore(doc.data() as Map<String, dynamic>)).toList();

  factory Character.fromFirestore(Map<String, dynamic> data,
    String id,
  ) {
    // make character instance
    Character character = Character(
      name: data['name'],
      vocation: Vocation.values.firstWhere((v) => v.toString() == data['vocation']),
      slogan: data['slogan'],
      id: id
    );

    // update skills
    for (String id in data['skills']) {
      Skill skill = allSkills.firstWhere((element) => element.id == id);
      character.updateSkill(skill);
    }

    // set isFav
    if(data['isFav'] == true) {
      character.toggleFavorite();
    }

    // update stats & points
    character.setStats(points: data['points'], stats: data['stats']);

    return character;
  } 
}


