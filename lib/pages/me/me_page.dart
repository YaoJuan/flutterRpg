import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/app_user.dart';
import 'package:flutter_rpg/services/fireauth_service.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  AppUser user = AppUser(uid: '222', email: 'bryce');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Profile'),
        // backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StyledHeading('Profile'),
            const SizedBox(height: 16),

            StyledText('uid: ${user.uid}'),
            StyledText('uid: ${user.email}'),

            // output user email here later

            StyledButton(
              onPressed: () {
                FireAuthService.signOut();
              },
              child: const StyledText('Log out'),
            )
          ],
        ),
      ),
    );
  }
}
