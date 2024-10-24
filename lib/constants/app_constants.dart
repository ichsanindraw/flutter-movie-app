import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String apiUrl = dotenv.get('API_URL');
  static String imageUrl = dotenv.get('IMAGE_URL');
  static String apiKey = dotenv.get('API_KEY');
  static String bearerToken = dotenv.get('BEARER_TOKEN');

  static const String imagePlaceholder = "https://placehold.co/400x400.png";
}
