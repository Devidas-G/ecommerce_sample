import 'package:flutter/material.dart';

Widget BuildCategoryCard(
  String category,
  String imgPath,
  BuildContext context,
) {
  final cardWidth = (MediaQuery.of(context).size.width - 52) / 2;

  return SizedBox(
    child: Column(
      children: [
        Container(
          height: cardWidth, // Height equals width to make it square
          width: cardWidth, // Ensure width matches for clarity
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Category text
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
