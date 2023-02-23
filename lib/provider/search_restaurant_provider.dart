import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission/data/api/api_service.dart';
import 'package:submission/data/model/search_restaurant.dart';

enum ResultSearchState { hasData, noData, loading, error, firstInitialize }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  ResultSearchState _state = ResultSearchState.firstInitialize;
  late SearchRestaurantModel _searchRestaurantData;
  String _message = '';

  String get message => _message;

  SearchRestaurantModel get searchRestaurantData => _searchRestaurantData;

  ResultSearchState get state => _state;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultSearchState.loading;
      final result = await apiService.searchRestaurantData(query);

      if (result.founded == 0) {
        _state = ResultSearchState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ResultSearchState.hasData;
        notifyListeners();
        _searchRestaurantData = result;
      }
    } catch (e) {
      _state = ResultSearchState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message = 'tidak ada internet';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }
}
