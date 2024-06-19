
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/pages/profile/heart.dart';
import 'package:flutter_rpg/pages/profile/skill_list.dart';
import 'package:flutter_rpg/pages/profile/stats_table.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledHeading(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

              // basic info - image, vocation, description
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.secondaryColor.withOpacity(0.3),
                    child: Row(
                      children: [
                        Hero(
                          tag: character.id,
                          child: Image.asset('assets/img/vocations/${character.vocation.image}',
                            width: 140,
                            height: 140,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyledHeading(character.vocation.title),
                              StyledText(character.vocation.description),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 15,
                  right: 20,
                  child: Heart(character: character)
                  ),
                
              ],
            ),
            // basic info

                       Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading('Slogan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    const StyledHeading('Weapon of Choice'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    const StyledHeading('Unique Ability'),
                    StyledText(character.vocation.ability),
                    const SizedBox(height: 10),
                    SkillList(character),
                    const SizedBox(height: 10),
                    StatsTable(character: character)
                  ],
                ),
              ),
            ),


                        // save button
            StyledButton(onPressed: () {
              // show snackbar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const StyledHeading('Character saved.'),
                showCloseIcon: true,
                backgroundColor: AppColors.secondaryColor,
                duration: const Duration(seconds: 2),
              ));

            }, child: const StyledHeading('save character')),
            const SizedBox(height: 20),

          ],
          
        ),
      ),
    );
  }
}
