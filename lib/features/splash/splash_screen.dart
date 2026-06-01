import 'package:flutter/material.dart';
import 'package:read_quran/constants/asset_consstant.dart';
import 'package:read_quran/shared/styles/color_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.primary900, // Dark green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with circular gold border
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  AssetConstants.icReadQuran,
                  width: 180,
                  height: 180,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // App Name
            const Text(
              'Read Quran',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // Bismillah
            const Text(
              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
                color: ColorStyle.secondary500, // Gold color
                fontFamily: 'Rajdhani',
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
