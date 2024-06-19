import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/character_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'character_store.g.dart';

@riverpod
class CharacterNotifier extends _$CharacterNotifier {
  final _characterService = CharacterService();
  @override
  List<Character> build() {
    return [];
  }

  void addCharacter(Character character) {
    if (!state.contains(character)) {
      state = [...state, character];
    }

    _characterService.addDocument(character);
  }

  void fetchCharatersOnce() async {
    if (state.isNotEmpty) return;
    final characters = await _characterService.getDocumentsOnce();
    state = characters;
  }
}
