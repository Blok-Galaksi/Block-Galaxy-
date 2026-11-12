import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(30),
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
                children: [
                  SizedBox(height: 20),
                  Image.asset('assets/fix-logo.jpg', height: 150),
                  SizedBox(height: 30),
                  Text(
                    "Login",
                    style: GoogleFonts.jaro(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 42,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: nameController,
                    onChanged: (e) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFDBDADA),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (e) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFDBDADA),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Forgot Password ?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCC0000),
                      padding: EdgeInsets.symmetric(
                        horizontal: 55,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum Punya Akun?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(" Sign In", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
