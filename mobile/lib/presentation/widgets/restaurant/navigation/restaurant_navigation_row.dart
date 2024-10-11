import 'package:flutter/material.dart';

class RestaurantNavigationRow extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;
  final bool showBook;

  const RestaurantNavigationRow({
    super.key,
    required this.activeIndex,
    required this.onTap,
    this.showBook = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (showBook) ...[
          _buildNavItem('Book', 0), // Change the first item to "Book"
          const SizedBox(width: 20),
        ],
        _buildNavItem('Details', 1), // Add "Details"
        const SizedBox(width: 20),
        _buildNavItem('Ratings', 2), // Add "Ratings"
      ],
    );
  }

  Widget _buildNavItem(String title, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: activeIndex == index
                  ? const Color.fromARGB(255, 29, 53, 115)
                  : Colors.black,
              fontWeight:
                  activeIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (activeIndex == index)
            Container(
              height: 2,
              width: title.length * 10.0,
              color: const Color.fromARGB(255, 29, 53, 115),
            ),
        ],
      ),
    );
  }
}