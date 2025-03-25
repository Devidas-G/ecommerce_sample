import 'package:flutter/material.dart';

Widget Footer() {
  return Container(
    color: Colors.red,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset('assets/images/logo.png', height: 100, width: 100),
        ),

        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildFooterLink('Products', true),
            BuildFooterLink('Company', false),
            BuildFooterLink('Shop', false),
            BuildFooterLink('Service', false),
          ],
        ),
        const SizedBox(height: 10),
        const Text('WHAT\'S NEW', style: TextStyle(color: Colors.white)),
        const Text('SUBSCRIBE', style: TextStyle(color: Colors.white)),
        const Text('LATEST', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '© 2025 K&D DigitalCurry. All Rights reserved.',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget BuildFooterLink(String title, bool isFilled) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 1),
      color: isFilled ? Colors.white : Colors.transparent,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(color: isFilled ? Colors.black : Colors.white),
      ),
    ),
  );
}
