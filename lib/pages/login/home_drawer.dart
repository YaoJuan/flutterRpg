import 'package:flutter/material.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/pages/login/sign_in.dart';
import 'package:flutter_rpg/pages/login/sign_up.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool isSignUpForm = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 0),
      color: AppColors.secondaryColor,
      child: Drawer(
        backgroundColor: AppColors.secondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header
              const SizedBox(
                  height: 100,
                  child: DrawerHeader(child: StyledHeading('Welcome.'))),

              const SizedBox(height: 15),
              // sign up form
              if (!isSignUpForm)
                SignUpForm(
                    onPressed: ()  {
                          
                          setState(() {
                            isSignUpForm = true;
                          });
                        }),

              // sign in form
              if (isSignUpForm)
                SignInForm(onPressed: () {
                  setState(() {
                    isSignUpForm = false;
                  });
                }),
            ],
          ),
        ),
      ),
    );
  }
}
