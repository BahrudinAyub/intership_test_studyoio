import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';

class CustomSearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomSearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyle.buttonSearchDashboard, // Background color
        shadowColor: Colors.black, // Shadow color
        side: BorderSide(color: Colors.black, width: 3.w), // Border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Border radius
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebar antara teks dan ikon
        children: [
          Text(
            'Search',
            style: SatoshiStyle.SatoshiStyleNormal.copyWith(fontSize: MediaQuery.of(context).size.width * 0.05, color: ColorStyle.textSearcj),
          ),
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }
}
