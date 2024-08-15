import 'package:flutter/material.dart';
import 'package:intership_test_studyoio/features/presentation/styles/text_style.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/button_custom.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/button_navigation.dart'; // Import DashboardScreen

class ChoseScreens extends StatelessWidget {
  const ChoseScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Menu',
          style: PoppinsStyle.PoppinsStyleNormal.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Membungkus CustomButton dengan Padding untuk memberikan jarak di kiri dan kanan
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50.0), // Jarak horizontal
              child: CustomButton(
                text: 'Test Internship Flutter 1',
                textStyle: SatoshiStyle.SatoshiStyleBold.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(),
                    ),
                  );
                },
              ),
            ),
            // Jarak antara dua tombol
            const SizedBox(height: 20), // Jarak antara dua tombol
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50.0), // Jarak horizontal
              child: CustomButton(
                text: 'Test Internship Flutter 2',
                textStyle: SatoshiStyle.SatoshiStyleBold.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
                onPressed: () {
                  // Implementasi tindakan untuk tombol kedua jika diperlukan
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
