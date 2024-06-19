import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rpg/base/theme.dart';

import 'package:flutter_rpg/pages/home/test_page.dart';
import 'package:flutter_rpg/routers/router.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
  // ChangeNotifierProvider(create: (ctx) => CharacterStore(),
  // child:
  // MaterialApp.router(
  //   routerConfig: ,
  //   home: const TestPage(),
  //   theme: theme)
  // ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
  
    return 
    MaterialApp.router(
      routerConfig: router,
      // routeInformationParser: router.routeInformationParser,
      theme: theme,);
  }
}
