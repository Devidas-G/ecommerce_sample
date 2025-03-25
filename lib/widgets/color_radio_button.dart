import 'package:flutter/material.dart';

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Red Base Circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          // Hollow Circle (Transparent with Black Inner Border & White Outer Border)
          isSelected
              ? Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ), // Outer White Border
                ),
                child: Center(
                  child: Container(
                    width:
                        50, // Slightly smaller to create a gap for white border
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ), // Inner Black Border
                      color: Colors.transparent, // Hollow center
                    ),
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
