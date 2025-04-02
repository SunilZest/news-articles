import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:news/controller/newsController.dart';
import 'package:news/view/add_articals.dart';
import 'package:news/view/artical_card.dart';
import 'package:news/view/artical_details.dart';
import 'package:news/view/weather_card.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value || controller.isTempLoading.value) {
          return Center(
            child: Lottie.asset('assets/lotti/loading.json'),
          );
        }
        if (controller.newsList.isEmpty || controller.weatherDataList.isEmpty) {
          return const Center(child: Text("No news available"));
        }
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Featured Article Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        FeaturedCard(),
                        const SizedBox(height: 15),
                        WeatherHomeCard(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

                // New Articles Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SectionHeader(title: "City Weather"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.weatherDataList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        var weather = controller.weatherDataList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: SizedBox(
                            width: 250,
                            child: WeatherCard(
                              city: weather['city'].toString() ?? "",
                              state: weather['temperature'].toString() ?? "",
                              temperature:
                                  weather['temperature'].toString() ?? "",
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SectionHeader(title: "Articals"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ProfileCard();
                        }),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),

                // Most Popular Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SectionHeader(title: "New Articles"),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: PopularArticleCard(
                            title: controller.newsList[index].title ?? "",
                            author: getFirstTwoWords(
                                controller.newsList[index].author ?? ""),
                            daysAgo: formatDate(controller
                                .newsList[index].publishedAt
                                .toString()),
                            url: controller.newsList[index].urlToImage ?? "",
                            description:
                                controller.newsList[index].description ?? "",
                            source:
                                controller.newsList[index].source?.name ?? "",
                            content: controller.newsList[index].content ?? ""),
                      );
                    },
                    childCount: controller.newsList.length,
                  ),
                ),
              ],
            ),
            // Vertical Gradient Line
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal[700]!.withOpacity(0.8),
                      Colors.green[200]!
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

String formatDate(String dateTime) {
  try {
    final date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  } catch (e) {
    // Return a fallback or handle the error
    return "Invalid Date";
  }
}

String getFirstTwoWords(String input) {
  // Split the string by space
  List<String> words = input.split(' ');

  // Check if the list has at least two words
  if (words.length >= 2) {
    return '${words[0]} ${words[1]}'; // Concatenate the first two words
  } else {
    return input; // If less than two words, return the original input
  }
}

class FeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[600]!, Colors.teal[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user, size: 50, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Special for you",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const Text(
                  "Explore Tips & Tricks To Become a Better Author",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0)), // Smooth rounded corners
                        elevation: 10, // Adds shadow for depth effect
                        backgroundColor: Colors.white, // Background color
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.70,
                          padding:
                              const EdgeInsets.all(16.0), // Adds padding inside
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.purple, // Soft shadow effect
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Close button at the top
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.black54),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                              // Title
                              const Text(
                                "Add New Blog",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              const Expanded(child: AddBlogScreen()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Add New Blog"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String daysAgo;

  ArticleCard(
      {required this.title, required this.author, required this.daysAgo});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      shadowColor: Colors.teal[300],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  author,
                  style: GoogleFonts.lato(fontSize: 14, color: Colors.black54),
                ),
                const Spacer(),
                Text(daysAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PopularArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String daysAgo;
  final String url;
  final String description;
  final String source;
  final String content;

  PopularArticleCard({
    required this.title,
    required this.author,
    required this.daysAgo,
    required this.url,
    required this.description,
    required this.source,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleDetailsPage(
                    title: title,
                    imageUrl: url,
                    authorName: author,
                    description: description,
                    publishDate: daysAgo,
                    source: source,
                    content: content,
                  )),
        );
      },
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.teal.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Center(
                child: ClipOval(
                  child: Image.network(
                    url, // Replace with your image URL
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image fully loaded
                      }
                      return SizedBox(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Icon(
                        Icons.error,
                        size: 80,
                        color: Colors
                            .red, // Display error icon if image fails to load
                      );
                    },
                    width: 80, // Set the width
                    height: 80, // Set the height
                    fit: BoxFit
                        .cover, // Ensures the image fills the circular shape
                  ),
                ),
              ),

              // Center(
              //   child: Image.network(
              //     url, // Replace with your image URL
              //     loadingBuilder: (BuildContext context, Widget child,
              //         ImageChunkEvent? loadingProgress) {
              //       if (loadingProgress == null) {
              //         return child; // Image fully loaded
              //       }
              //       return Center(
              //         child: CircularProgressIndicator(
              //           value: loadingProgress.expectedTotalBytes != null
              //               ? loadingProgress.cumulativeBytesLoaded /
              //                   (loadingProgress.expectedTotalBytes ?? 1)
              //               : null,
              //         ),
              //       );
              //     },
              //     errorBuilder: (BuildContext context, Object error,
              //         StackTrace? stackTrace) {
              //       return const Icon(Icons.error,
              //           size: 50,
              //           color: Colors
              //               .red); // Display error icon if image fails to load
              //     },
              //     height: 100, width: 80,
              //   ),
              // ),
              const SizedBox(width: 16),
              // Article details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            size: 16, color: Colors.white70),
                        const SizedBox(width: 6),
                        SizedBox(
                          width: 100,
                          child: Text(
                            author,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          daysAgo,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.white70,
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
      ),
    );
  }
}

class WeatherHomeCard extends StatelessWidget {
  final NewsController locationController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Weather Info with Circular Chart
          Obx(() {
            if (locationController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (locationController.state.value.isEmpty) {
              return Row(
                children: [
                  Icon(Icons.wb_sunny, size: 40, color: Colors.orange[600]),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Bengaluru, Karnataka",
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "28°C, Sunny",
                        style: GoogleFonts.lato(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              );
            }
            return Row(
              children: [
                Icon(Icons.wb_sunny, size: 40, color: Colors.orange[600]),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "${locationController.locality.value} ",
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                    Text(
                      "${locationController.city.value} , ${locationController.state.value}",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${locationController.temperature.value.toString()} °C " ??
                          "",
                      // "28°C, Sunny",
                      style: GoogleFonts.lato(
                          fontSize: 16, color: Colors.purpleAccent),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            );
          }),

          const SizedBox(height: 8),
          // Next 7 Days Graph
          Text(
            "Next 7 Days",
            style: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 20),
          // Line Chart
          Row(
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.5,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(
                      show: false, // Hide all borders
                    ),
                    gridData: FlGridData(show: false),
                    // Remove grid lines
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: false), // Hide bottom titles
                      ),
                      leftTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: false), // Hide left titles
                      ),
                      rightTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: false), // Hide right titles
                      ),
                      topTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: false), // Hide top titles
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 1),
                          const FlSpot(1, 1.5),
                          const FlSpot(2, 2),
                          const FlSpot(3, 1.8),
                          const FlSpot(4, 1.2),
                          const FlSpot(5, 1.6),
                          const FlSpot(6, 2.1),
                        ],
                        isCurved: true,
                        color: Colors.teal,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.1),
                        ),
                        dotData: FlDotData(
                          show: true, // Show dots for each point
                        ),
                      ),
                    ],
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 3,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: 50,
                          title: "79%",
                          radius: 25,
                          titleStyle: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.orangeAccent[700],
                          value: 20,
                          title: "",
                          radius: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
