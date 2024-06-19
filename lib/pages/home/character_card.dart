import 'package:flutter/material.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/pages/profile/profile_page.dart';
import 'package:flutter_rpg/routers/routes.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Hero(
                tag: character.id,
                child: Image.asset(
                    'assets/img/vocations/${character.vocation.image}',
                    width: 80),
              )),
          const SizedBox(width: 12),

          // 让column里的2个text  一个顶住顶部，一个站在底部
          SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledHeading(character.name),
                StyledText(character.vocation.name)
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                ProfileRoute($extra: character).push(context);
        
              },
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor))
        ],
      ),
    ));
  }
}
