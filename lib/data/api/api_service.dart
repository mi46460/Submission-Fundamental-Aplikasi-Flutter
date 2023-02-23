import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission/data/model/list_restaurant.dart';
import 'package:submission/data/model/detail_restaurant.dart';
import 'package:submission/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResult> getListRestaurant() async {
    Uri uri = Uri.parse("$_baseUrl/list");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseRestaurant(response.body);
    } else {
      throw Exception('Restaurants Not Found');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    Uri uri = Uri.parse("$_baseUrl/detail/$id");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseDetailRestaurant(response.body);
    } else {
      throw Exception('Restaurant Not Found');
    }
  }

  Future<SearchRestaurantModel> searchRestaurantData(String query) async {
    Uri uri = Uri.parse("$_baseUrl/search?q=$query");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseSearchResult(response.body);
    } else {
      throw Exception('Restaurant Not Found');
    }
  }

  Future<DetailRestaurant> fetchDetailRestaurantMock(http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DetailRestaurant.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
