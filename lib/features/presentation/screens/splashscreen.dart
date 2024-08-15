import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';
import 'chose_screens.dart';  // Import halaman ChoseScreens

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Mengarahkan ke halaman ChoseScreens setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ChoseScreens()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hi, Welcome',
          style: SatoshiStyle.SatoshiStyleNormal.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.08,
            // Menggunakan ScreenUtil atau ukuran teks dinamis lainnya
          ),
        ),
      ),
    );
  }
}
