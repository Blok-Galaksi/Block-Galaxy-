import 'package:flutter/material.dart';

/// Background gradient yang dipakai di semua layar.
/// Ungu tua di atas, hampir hitam di bawah.
const LinearGradient appBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF3A0066), // ungu tua (atas)
    Color(0xFF100012), // ungu sangat gelap (bawah)
  ],
);
