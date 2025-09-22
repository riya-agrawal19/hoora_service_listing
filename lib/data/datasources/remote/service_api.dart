import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:http/http.dart' as http;

final _serviceApiProvider = Provider<ServiceApi>((ref) => ServiceApi());

class ServiceApi {
  static const String baseUrl =
      "https://68d0f088e6c0cbeb39a2f4dd.mockapi.io/favoriteservice/favourite_service";

  static Provider<ServiceApi> get provider => _serviceApiProvider;

  Future<List<ServiceModel>> fetchServices({
    required int page,
    required int limit,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ServiceModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load services");
    }
  }
}
