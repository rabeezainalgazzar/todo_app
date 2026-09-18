import 'package:flutter/material.dart';
import 'package:todolist/core/style/text_style.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Calendar - Coming soon',
        style: TextStyles.textStyleNeutralSecondaryR14,
      ),
    );
  }
}
