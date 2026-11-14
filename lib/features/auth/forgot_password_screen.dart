import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_gradient.dart';
import '../../core/app_input_decoration.dart';
import '../../core/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    // TODO: sambungkan ke backend setelah keputusan backend dibuat.
    // Ambil email dari _emailController.text.trim().
    // - Firebase Auth: sendPasswordResetEmail(email) sudah cukup.
    // - REST API sendiri: perlu endpoint + alur tambahan (OTP/token,
    //   layar kode, layar password baru).
    // Saran: tampilkan pesan netral setelah submit ("Jika email terdaftar,
    // instruksi akan dikirim") supaya tidak membocorkan email mana yang
    // punya akun.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Backend belum terhubung')));
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
                        'Lupa Password',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jaro(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Masukkan email yang terdaftar. Kami akan kirim '
                        'instruksi untuk mengatur ulang password kamu.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(180, 255, 255, 255),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          'Email',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: authInputDecoration('Email'),
                        validator: validateEmail,
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
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          // Kembali ke LoginScreen yang ada di bawah stack.
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                          child: const Text('Kembali ke Login'),
                        ),
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
