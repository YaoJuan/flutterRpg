import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rpg/base/theme.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/widgets/styled_text.dart';

class StatsTable extends StatefulWidget {
  const StatsTable({required this.character, super.key});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // available points
        Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.secondaryColor,
            child: Row(children: [
              AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 500),
                child: Icon(Icons.star,
                    color: widget.character.points > 0
                        ? Colors.yellow
                        : Colors.grey),
              ),
              const SizedBox(width: 20),
              const StyledText('Stat points available:'),
              const Spacer(),
              StyledHeading(widget.character.points.toString())
            ])),

        // stats table
        Table(
          border: TableBorder.all(color: Colors.green),
          children: widget.character.statsAsFormattedList.map((stat) {
            return TableRow(
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.5)),
                children: [
                  // health
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child:
                            Center(child: StyledHeading(stat['title'] ?? ""))),
                  ),

                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                              child: StyledHeading(stat['value'] ?? "0")))),

                  // plus - substract value
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                              icon: const Icon(Icons.arrow_upward),
                              onPressed: () {
                                setState(() {
                                  turns += 1.0;
                                  widget.character
                                      .increaseStats(stat['title'] ?? "");
                                });
                              }))),

                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                              icon: const Icon(Icons.arrow_downward),
                              onPressed: () {
                                setState(() {
                                  turns -= 1.0;
                                  widget.character
                                      .decreaseStats(stat['title'] ?? "");
                                });
                              })))
                ]);
          }).toList(),
        )
      ],
    );
  }
}
