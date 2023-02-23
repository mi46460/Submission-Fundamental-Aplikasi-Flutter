import 'dart:convert';

import 'package:submission/data/model/restaurant.dart';

SearchRestaurantModel parseSearchResult(String str) =>
    SearchRestaurantModel.fromJson(json.decode(str));

class SearchRestaurantModel {
  SearchRestaurantModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantModel> restaurants;

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantModel>.from(
            json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );
}
