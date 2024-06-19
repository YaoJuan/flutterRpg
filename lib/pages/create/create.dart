import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/pages/create/vocation_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/v4.dart';

final uuid = const UuidV4();

class CreatePage extends ConsumerStatefulWidget {
  const CreatePage({super.key});

  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();
  Vocation _selectedVocation = Vocation.junkie;

  //methods
  void createCharacter(WidgetRef ref) {
    //safe check
    if (_nameController.text.isEmpty || _sloganController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: const StyledHeading('Error'),
                content: const StyledText('Name and slogan are required.'),
                actions: [
                  StyledButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const StyledHeading('OK'))
                ]);
          });
      return;
    }

    // create character
    final character = Character(
        id: uuid.generate(),
        name: _nameController.text,
        slogan: _sloganController.text,
        vocation: _selectedVocation);
    
    // 拿到characterNotifierProvider 並且呼叫addCharacter
    ref.read(characterNotifierProvider.notifier).addCharacter(character);

    Navigator.pop(context);
  }

  void chooseVocation(Vocation vocation) {
    setState(() {
      _selectedVocation = vocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Create Character'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // welcome msgs
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Welcome, new player.'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character.'),
              ),
              const SizedBox(height: 30),

              // textfiled
              TextField(
                controller: _nameController,
                cursorColor: AppColors.textColor,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  label: const StyledText('Character name'),
                  // border: InputBorder.none
                  hintText: 'Enter your character name',
                  hintStyle: GoogleFonts.kanit(
                      textStyle: Theme.of(context).textTheme.bodyMedium),
                ),
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
              ),

              const SizedBox(height: 20),
              TextField(
                controller: _sloganController,
                cursorColor: AppColors.textColor,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.chat),
                  label: const StyledText('Character slogan'),
                  hintText: 'Enter your character slogan',
                  hintStyle: GoogleFonts.kanit(
                      textStyle: Theme.of(context).textTheme.bodyMedium),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 30),

              // vocation title
              Center(
                  child: Icon(Icons.access_time_filled_outlined,
                      color: AppColors.primaryColor)),
              const Center(
                child: StyledHeading('Choose a vocation'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),

              // vocations
              const SizedBox(height: 20),
              VocationCard(
                vocation: Vocation.junkie,
                onTaped: chooseVocation,
                isSelected: _selectedVocation == Vocation.junkie,
              ),
              VocationCard(
                vocation: Vocation.ninja,
                onTaped: chooseVocation,
                isSelected: _selectedVocation == Vocation.ninja,
              ),
              VocationCard(
                vocation: Vocation.raider,
                onTaped: chooseVocation,
                isSelected: _selectedVocation == Vocation.raider,
              ),
              VocationCard(
                vocation: Vocation.wizard,
                onTaped: chooseVocation,
                isSelected: _selectedVocation == Vocation.wizard,
              ),

              const SizedBox(height: 20),

              // create character button
              StyledButton(
                onPressed: () => createCharacter(ref),
                child: const StyledHeading('create character'),
              ),

              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
