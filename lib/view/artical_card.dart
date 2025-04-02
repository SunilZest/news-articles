import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth * 0.9, // 90% of the screen width
      height: screenHeight * 0.45, // 40% of the screen height
      child: Row(
        children: [
          // Left side: Image with details overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/banner.jpg", // Replace with your image
                  height: screenHeight * 0.40, // 35% of screen height
                  width: screenWidth * 0.45, // 40% of screen width
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                bottom: 60,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jessica Jones - 23",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Fashion Designer, Model",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 16,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    print("Read More Button Clicked!");
                    // Add navigation or dialog here
                  },
                  child: const Text("Read More"),
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.05), // 5% of screen width for spacing
          // Right side: Description text with Read More feature
          Expanded(
            child: SizedBox(
              height: screenHeight * 0.40, // 35% of screen height
              child: const ReadMoreText(
                "Jessica Jones is a talented fashion designer and model known for her innovative designs and captivating presence. "
                    "At just 23, she has already made a mark in the industry with her unique fashion sense and modeling skills. "
                    "Follow her journey as she continues to redefine trends and inspire young designers worldwide.",
                trimLines: 6, // Number of lines before showing 'Read More'
                colorClickableText: Colors.blue, // Blue color for Read More
                trimMode: TrimMode.Line, // Trim by line
                trimCollapsedText: "Read More", // Show this when collapsed
                trimExpandedText: "Show Less",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Underline for effect
                ),
                // Show this when expanded
                moreStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  decoration: TextDecoration.underline, // Underline for effect
                ),
                lessStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  decoration: TextDecoration.underline, // Underline for effect
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
