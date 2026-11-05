import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: GradientBackgroundPage(),
    );
  }
}

class GradientBackgroundPage extends StatelessWidget {
  const GradientBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      // Menggunakan Container di body agar gradasi memenuhi seluruh layar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Arah gradasi dari atas ke bawah
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3A0066), // Ungu tua (bagian atas)
              Color.fromARGB(
                255,
                16,
                0,
                18,
              ), // Ungu sangat gelap mendekati hitam (bagian bawah)
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/blockG.png', width: 483, height: 483),
                Text(
                  "Galaxy Corp",
                  style: GoogleFonts.montserrat(
                    color: Color.fromARGB(150, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
