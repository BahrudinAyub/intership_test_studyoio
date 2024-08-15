import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';

class QuickHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Quick Help Screen', style: SatoshiStyle.SatoshiStyleBold.copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.08, color: Colors.white),
    ));
  }
}
