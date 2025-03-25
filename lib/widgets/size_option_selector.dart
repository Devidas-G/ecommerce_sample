import 'package:flutter/material.dart';

class SizeOptionSelector extends StatelessWidget {
  const SizeOptionSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onTap,
  });

  final List<String> sizes;
  final String selectedSize;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 221, 221, 221),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              sizes.map((size) {
                return GestureDetector(
                  onTap: () => onTap(size),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          selectedSize == size
                              ? Colors.red
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: 50,

                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          color:
                              selectedSize == size
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
