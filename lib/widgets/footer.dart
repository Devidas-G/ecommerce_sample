import 'package:flutter/material.dart';

Widget Footer() {
  return Container(
    color: Colors.red,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        const Text(
          'K&D DigitalCurry',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildFooterLink('Products'),
            BuildFooterLink('Company'),
            BuildFooterLink('Shop'),
            BuildFooterLink('Service'),
          ],
        ),
        const SizedBox(height: 10),
        const Text('WHAT\'S NEW', style: TextStyle(color: Colors.white)),
        const Text('SUBSCRIBE', style: TextStyle(color: Colors.white)),
        const Text('LATEST', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        const Text(
          '© 2025 K&D DigitalCurry. All Rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget BuildFooterLink(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Text(title, style: const TextStyle(color: Colors.white)),
  );
}
