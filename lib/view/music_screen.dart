import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MusicHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'POPULAR',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    StylishCard(
                      imagePath: 'assets/images/banner.jpg',
                      title: 'Pop Rock',
                      subtitle: '751K Followers',
                    ),
                    StylishCard(
                      imagePath: 'assets/images/banner.jpg',
                      title: 'Heavy Metal',
                      subtitle: '482K Followers',
                    ),
                    StylishCard(
                      imagePath: 'assets/images/banner.jpg',
                      title: 'Pop Rock',
                      subtitle: '360K Followers',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'TRENDING ALBUMS',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 10),
              trendingAlbum('Everyday Life', 'Coldplay', '3:42', context,
                  'assets/images/banner.jpg'),
              trendingAlbum('Shape Of You', 'Ed Sheeran', '4:24', context,
                  'assets/images/banner.jpg'),
              trendingAlbum('Intentions', 'Justin Bieber', '3:51', context,
                  'assets/images/banner.jpg'),
              trendingAlbum('Shape Of You', 'Ed Sheeran', '4:24', context,
                  'assets/images/banner.jpg'),
              trendingAlbum('Shape Of You', 'Ed Sheeran', '4:24', context,
                  'assets/images/banner.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget trendingAlbum(String title, String artist, String duration,
      BuildContext context, String imagePath) {
    // Randomly select a card color (Pink or Teal)
    final List<Color> colors = [Colors.yellow.shade300, Colors.teal.shade300];
    final Color cardColor = colors[Random().nextInt(colors.length)];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: cardColor.withOpacity(0.8), // Transparency Effect
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Image.asset(imagePath,
                  width: 50, height: 50, fit: BoxFit.cover),
            ), // Play Icon
          ],
        ),
        title: Text(title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black)),
        subtitle: Text(artist,
            style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 14)),
        trailing:
            const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MusicPlayerPage(title, artist, imagePath)),
          );
        },
      ),
    );
  }
}

class MusicPlayerPage extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;

  MusicPlayerPage(this.title, this.artist, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(imagePath,
                  width: 150, height: 150, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text(artist, style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(height: 20),
            const Icon(Icons.audiotrack, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous,
                      size: 40, color: Colors.blueGrey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow,
                      size: 40, color: Colors.blueGrey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next,
                      size: 40, color: Colors.blueGrey),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StylishCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const StylishCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
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
