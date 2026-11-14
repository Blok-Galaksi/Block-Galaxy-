import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_gradient.dart';
import '../../core/app_input_decoration.dart';
import '../../core/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Asumsi: password minimal 6 karakter. Sesuaikan dengan aturan backend
  // yang nanti dipilih (Firebase Auth, misalnya, mewajibkan minimal 6).
  static const _minPasswordLength = 6;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    // TODO: sambungkan ke backend setelah keputusan backend dibuat.
    // Ambil nilai dari _emailController.text.trim(),
    // _usernameController.text.trim(), dan _passwordController.text.
    // Logika register asli sebaiknya di class terpisah (mis. AuthService).
    // Jangan pernah print/log password.
    _showPlaceholder('Backend belum terhubung');
  }

  void _showPlaceholder(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username wajib diisi';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < _minPasswordLength) {
      return 'Password minimal $_minPasswordLength karakter';
    }
    return null;
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset('assets/fix-logo.jpg', height: 150),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jaro(
                          color: Colors.white,
                          fontSize: 42,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _label('Email'),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: authInputDecoration('Email'),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 20),
                      _label('Username'),
                      TextFormField(
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: authInputDecoration('Username'),
                        validator: _validateUsername,
                      ),
                      const SizedBox(height: 20),
                      _label('Password'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: authInputDecoration('Password'),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 36),
                      Center(
                        child: ElevatedButton(
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
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah Punya Akun?',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            // Kembali ke LoginScreen yang ada di bawah stack.
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                            ),
                            child: const Text('Sign In'),
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
