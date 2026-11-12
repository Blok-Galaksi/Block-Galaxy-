import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/../Core/app_gradient.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Tutup keyboard dulu.
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    // TODO: sambungkan ke backend (Firebase Auth / REST API) setelah
    // keputusan backend dibuat. Ambil nilai dari
    // _usernameController.text.trim() dan _passwordController.text.
    // Jangan taruh logika auth asli di widget ini; pindahkan ke class
    // terpisah (mis. AuthService). Jangan pernah print/log password.
    _showPlaceholder('Backend belum terhubung');
  }

  void _showPlaceholder(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi';
    }
    return null;
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFDBDADA),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: appBackgroundGradient),
        child: SafeArea(
          child: Center(
            // Scrollable supaya tidak overflow saat keyboard muncul.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: ConstrainedBox(
                // Batasi lebar agar tetap rapi di tablet/web.
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset('assets/fix-logo.jpg', height: 150),
                      const SizedBox(height: 30),
                      Text(
                        'Sign In',
                        style: GoogleFonts.jaro(
                          color: Colors.white,
                          fontSize: 42,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration('Username'),
                        validator: (v) => _requiredValidator(v, 'Username'),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: _inputDecoration('Password'),
                        validator: (v) => _requiredValidator(v, 'Password'),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          // TODO: ganti dengan navigasi ke layar reset password.
                          onPressed: () =>
                              _showPlaceholder('Fitur belum tersedia'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCC0000),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 55,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum Punya Akun?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            // TODO: ganti dengan navigasi ke SignUpScreen.
                            onPressed: () =>
                                _showPlaceholder('Fitur belum tersedia'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                            ),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
