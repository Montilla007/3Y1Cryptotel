import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String imagePath; // URL for network image
  final String hotelName;
  final String location;
  final double rating;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.hotelName,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 400.0,
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                imagePath, // Load image from network URL
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Return the image when fully loaded
                  }
                  return const Center(
                    child:
                        CircularProgressIndicator(), // Show a loader while the image is being loaded
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ), // Display an icon if the image fails to load
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      hotelName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(Icons.place, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 142, 142, 147),
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2.0),
                          color: const Color.fromARGB(255, 29, 53, 115),
                          child: Row(
                            children: [
                              Text(
                                rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
