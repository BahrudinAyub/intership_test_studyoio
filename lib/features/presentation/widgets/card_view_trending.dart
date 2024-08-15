import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';

class CardViewTrending extends StatelessWidget {
  final String text;
  final IconData icon;

  CardViewTrending({
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: ColorStyle.backgroundCardView,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize
            .min, // Ensure the Row only takes up as much width as its content
        children: [
          Text(
            text,
            style: SatoshiStyle.SatoshiStyleBold.copyWith(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8.0),
          Icon(icon, color: Colors.white),
        ],
      ),
    );
  }
}
