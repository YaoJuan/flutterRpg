import 'package:flutter/material.dart';
import 'package:flutter_rpg/pages/create/create.dart';
import 'package:flutter_rpg/pages/home/character_card.dart';
import 'package:flutter_rpg/pages/login/home_drawer.dart';
import 'package:flutter_rpg/pages/me/me_page.dart';
import 'package:flutter_rpg/routers/routes.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(characterNotifierProvider.notifier).fetchCharatersOnce();
    super.initState();
  }

  // List characters = ['mario', 'luigi', 'peach', 'toad', 'bowser', 'koopa'];
  @override
  Widget build(BuildContext context) {
    final characterStore = ref.watch(characterNotifierProvider);
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: const StyledTitle('Your Character'),
        actions: [
          // go to mepage
          IconButton(
              onPressed: () {
                const MeRoute().push(context);
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(children: [
          Expanded(
           
                child:  ListView.builder(
                    itemCount: characterStore.length,
                    itemBuilder: (_, index) {
                      return CharacterCard(characterStore[index]);
                    })
          
          ),
          StyledButton(
              onPressed: () {
                const CreateRoute().push(context);
              
              },
              child: const StyledHeading('Create New'))
        ]),
      ),
    );
  }
}
