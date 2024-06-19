import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';
import 'firestore_service.dart'; // Assuming FirestoreService is defined in this file

class CharacterService extends FirestoreService<Character> {
  CharacterService() : super(Character.fromFirestore) {
    path = 'characters';
  }

  // ... other methods specific to CharacterService ...
}