import 'package:flutter/material.dart';

/// Style field input yang dipakai di layar auth (login, sign up).
InputDecoration authInputDecoration(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xFFDBDADA),
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
  );
}
