import 'package:flutter/material.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/services/fireauth_service.dart';
import 'package:flutter_rpg/shared/widgets/styled_button.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({required this.onPressed, super.key});
  final Function onPressed;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _secretController;

  String _errorFeedback = '';

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _secretController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //email
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      cursorColor: AppColors.textColor,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        label: const StyledText('Email'),
                        // border: InputBorder.none
                        hintStyle: GoogleFonts.kanit(
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                      style: GoogleFonts.kanit(
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),

                    const SizedBox(height: 16),
                    // secret
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      cursorColor: AppColors.textColor,
                      obscureText: true,
                      // keyboardType: TextInputType.password,
                      controller: _secretController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        label: const StyledText('Password'),
                        // border: InputBorder.none
                        hintStyle: GoogleFonts.kanit(
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                      style: GoogleFonts.kanit(
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),

                    const SizedBox(
                      height: 80,
                    ),

                    // confirm button
                  ],
                )),
            if (_errorFeedback.isNotEmpty) Text(_errorFeedback),
            SizedBox(height: 16),
            Text(
              _errorFeedback,
              style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
            ),

            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = '';
                  });
                  final email = _emailController.text.trim();
                  final password = _secretController.text.trim();

                  final user = await FireAuthService.signIn(email, password);
                  if (user != null) {
                    debugPrint(user.toString());
                    // success
                  } else {
                    _errorFeedback = 'Incorrect login credentials.';
                    // error feedback here later
                  }
                }
              },
              child: const StyledHeading('Sign in'),
            ),
            const SizedBox(
              height: 16,
            ),
            StyledButton(
              onPressed: () async {
                // if (_formKey.currentState!.validate()) {
                //   setState(() {
                //     _errorFeedback = '';
                //   });

                  final user = await FireAuthService.signInWithGoogle();
                  
                  if (user != null) {
                    debugPrint(user.toString());
                    // success
                  } else {
                    _errorFeedback = 'Incorrect login credentials.';
                    // error feedback here later
                  }
                },
              // },
              child: const StyledHeading('Google Sign in'),
            ),
            const SizedBox(height: 16),

            // switch
            const StyledText('Wanan create an acount?'),
            TextButton(
                onPressed: () => widget.onPressed(),
                child: const StyledText('Sign up instead')),
          ],
        ));
  }
}
