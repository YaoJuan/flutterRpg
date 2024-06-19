import 'package:flutter/material.dart';
import 'package:flutter_rpg/pages/home/home.dart';
import 'package:flutter_rpg/pages/login/home_drawer.dart';
import 'package:flutter_rpg/routers/routes.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: const StyledTitle('TestPage'),
      ),
      body: Center(
          child: StyledButton(
        child: Text("GO HOME"),
        onPressed: () {
          const HomeRoute().push(context);
        },
      )),
    );
  }
}
