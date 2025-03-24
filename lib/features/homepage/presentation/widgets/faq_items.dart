import 'package:flutter/material.dart';

Widget BuildFAQItem(String question, String answer) {
  return ExpansionTile(
    title: Text(question),
    children: [
      Padding(padding: const EdgeInsets.all(16.0), child: Text(answer)),
    ],
  );
}
