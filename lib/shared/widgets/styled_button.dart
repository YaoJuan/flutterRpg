import 'package:flutter/material.dart';
import 'package:flutter_rpg/base/theme.dart';

class StyledButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const StyledButton({
    super.key,
    required this.onPressed, 
    required this.child, 
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.primaryAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: child,
        ));
  }
}
