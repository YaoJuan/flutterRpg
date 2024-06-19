import 'package:flutter/material.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class VocationCard extends StatelessWidget {
  const VocationCard(
      {super.key,
      required this.vocation,
      required this.onTaped,
      required this.isSelected});

  final Vocation vocation;
  final void Function(Vocation vocation) onTaped;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTaped(vocation)},
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 2)),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset('assets/img/vocations/${vocation.image}',
                    width: 80,
                    colorBlendMode: BlendMode.color,
                    color: !isSelected
                        ? Colors.black.withOpacity(0.8)
                        : Colors.transparent),
                const SizedBox(width: 10),
                // vocations info
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledHeading(vocation.title),
                    StyledText(vocation.description)
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
