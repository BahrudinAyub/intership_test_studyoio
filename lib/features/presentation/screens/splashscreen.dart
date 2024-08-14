import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
    });

    return  Scaffold(
      body: Center(
        child: Text(
          'Hi, Welcome',
          style: SatoshiStyle.SatoshiStyleNormal.copyWith(fontSize: MediaQuery.of(context).size.width * 0.08)
           // Menggunakan ScreenUtil untuk ukuran teks
        ),
      ),
    );
  }
}