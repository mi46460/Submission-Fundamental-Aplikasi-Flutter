import 'dart:io';

import 'package:submission/data/api/api_service.dart';
import 'package:submission/data/model/list_restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:submission/data/model/search_restaurant.dart';

enum ResultListAllState { hasData, noData, loading, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurtant();
  }

  late RestaurantResult _restaurants;
  late ResultListAllState _state;
  late SearchRestaurantModel _searchRestaurantData;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaurants;

  SearchRestaurantModel get searchRestaurantData => _searchRestaurantData;

  ResultListAllState get state => _state;

  Future<dynamic> fetchAllRestaurtant() async {
    try {
      _state = ResultListAllState.loading;
      final restaurant = await apiService.getListRestaurant();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultListAllState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultListAllState.hasData;
        notifyListeners();
        _restaurants = restaurant;
      }
    } catch (e) {
      _state = ResultListAllState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message = 'tidak ada internet';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultListAllState.loading;
      final result = await apiService.searchRestaurantData(query);

      if (result.founded == 0) {
        _state = ResultListAllState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ResultListAllState.hasData;
        notifyListeners();
        _searchRestaurantData = result;
      }
    } catch (e) {
      _state = ResultListAllState.error;
      notifyListeners();
      if (e.toString() == 'No route to host') {
        return _message = 'tidak ada internet';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }
}
