import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/view/artical_details.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String state;
  final String temperature;
  final int index;

  WeatherCard({
    required this.city,
    required this.state,
    required this.temperature,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Weather Info
          Row(
            children: [
              Icon(Icons.location_on,
                  color: index % 2 == 0 ? Colors.red : Colors.green, size: 30),
              const SizedBox(width: 8),
              Text(
                city,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  maxLines: 1,
                  "India",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                "$temperature °C",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
