import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:news/model/newsModel.dart'; // Import your NewsModel file here
import 'package:geocoding/geocoding.dart';

class NewsController extends GetxController {
  static const String newsTeslaApi =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=66af6e4c42564308b93d5633e4e9a50e";
  var isLoading = true.obs;
  var isTempLoading = true.obs;
  var newsList =
      <Articles>[].obs; // Change the type to match the "Articles" class

  RxString city = ''.obs;
  RxString state = ''.obs;
  RxString locality = ''.obs;
  RxDouble temperature = 21.5.obs;
  var weatherDataList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAsyncTasks();
    // fetchNews();
    // getCityAndState();
    // getWeatherForIndianCities();
  }

  Future<void> _initializeAsyncTasks() async {
    try {
      await Future.wait([
        fetchNews(),
        getCityAndState(),
        getWeatherForIndianCities(),
      ] as Iterable<Future>);
      print("All tasks completed concurrently!");
    } catch (e) {
      print("Error in _initializeAsyncTasks: $e");
    }
  }

  void fetchNews() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(newsTeslaApi));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var newsModel = NewsModel.fromJson(data);
        newsList.value = newsModel.articles ?? [];
      } else {
        Get.snackbar("Error", "Failed to fetch news");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  getCityAndState() async {
    try {
      // Step 1: Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }

      // Step 2: Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Step 3: Reverse geocoding to get placemarks
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        city.value = place.locality ?? "Unknown City";
        state.value = place.administrativeArea ?? "Unknown State";
        locality.value = place.subLocality ?? "Unknown name";

        // print("Country: ${place.name}");
        // print("Street: ${place.street}");
        // print("Locality (City): ${place.locality}");
        // print("Locality (City): ${place.subLocality}");
        // print("Administrative Area (State): ${place.administrativeArea}");
        // print("Postal Code: ${place.postalCode}");
        // print("Country: ${place.country}");
        // print("subAdministrativeArea: ${place.subAdministrativeArea}");
        // print("thoroughfare: ${place.thoroughfare}");
        // print("subThoroughfare: ${place.subThoroughfare}");
      } else {
        throw Exception("No placemarks found");
      }

      // Step 4: Fetch weather data using Open-Meteo (no API key required)
      String url =
          "https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true";

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);
        temperature.value = weatherData['current_weather']['temperature'];

        print("Temperature: ${temperature.value} °C");
      } else {
        print("Failed to fetch weather data: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
      return {
        "city": "Unknown City",
        "state": "Unknown State",
      };
    }
  }

  getWeatherForIndianCities() async {
    isTempLoading(true);
    // List of Indian cities with their latitude and longitude
    List<Map<String, dynamic>> indianCities = [
      {"city": "Kolkata", "latitude": 22.5726, "longitude": 88.3639},
      {"city": "Sahibganj", "latitude": 25.2517, "longitude": 87.6392},
      {"city": "Bhagalpur", "latitude": 25.2425, "longitude": 86.9842},
      {"city": "Patna", "latitude": 25.5941, "longitude": 85.1376},
      {"city": "Mumbai", "latitude": 19.0760, "longitude": 72.8777},
      {"city": "Delhi", "latitude": 28.6139, "longitude": 77.2090},
      {"city": "Chennai", "latitude": 13.0827, "longitude": 80.2707},
      {"city": "Hyderabad", "latitude": 17.3850, "longitude": 78.4867},
      {"city": "Ahmedabad", "latitude": 23.0225, "longitude": 72.5714},
      {"city": "Pune", "latitude": 18.5204, "longitude": 73.8567},
      {"city": "Jaipur", "latitude": 26.9124, "longitude": 75.7873},
      {"city": "Lucknow", "latitude": 26.8467, "longitude": 80.9462},
    ];

    try {
      // Clear the existing list before fetching new data
      weatherDataList.clear();

      for (var city in indianCities) {
        String url =
            "https://api.open-meteo.com/v1/forecast?latitude=${city['latitude']}&longitude=${city['longitude']}&current_weather=true";

        http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var weatherData = await jsonDecode(response.body);

          // Add city weather to the observable list
          weatherDataList.add({
            "city": city["city"],
            "temperature": weatherData['current_weather']['temperature'],
            "windSpeed": weatherData['current_weather']['windspeed'],
          });
          // Print specific data points
          print("City: ${city['city']}");
          print(
              "Temperature: ${weatherData['current_weather']['temperature']} °C");
          print(
              "Wind Speed: ${weatherData['current_weather']['windspeed']} km/h");
        } else {
          print(
              "Failed to fetch weather data for ${city['city']}: ${response.body}");
        }
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      isTempLoading(false);
    }
  }
}
