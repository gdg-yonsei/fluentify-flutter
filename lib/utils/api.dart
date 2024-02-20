import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static Dio getClient() {
    return Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));
  }

  static Future<Dio> getAuthenticatedClient() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    return Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }
}
