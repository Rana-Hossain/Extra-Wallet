import 'package:flutter/material.dart';

final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
    backgroundColor : const Color.fromARGB(255, 21, 187, 216), // Background color
    foregroundColor : Colors.white, // Text color
    elevation: 3, // Elevation (shadow)
    shape: RoundedRectangleBorder( // Rounded corners
          borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
);