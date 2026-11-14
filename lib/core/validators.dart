// Cek format sederhana saja (ada @ dan titik di domain).
// Validasi sebenarnya tetap harus dilakukan di backend.
final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Validator email untuk `TextFormField.validator`.
String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Email wajib diisi';
  if (!_emailPattern.hasMatch(email)) return 'Format email tidak valid';
  return null;
}
