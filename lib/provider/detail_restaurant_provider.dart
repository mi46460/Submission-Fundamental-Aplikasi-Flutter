import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission/data/api/api_service.dart';
import 'package:submission/data/model/detail_restaurant.dart';

enum ResultState { hasData, noData, loading, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  String _message = '';
  late DetailRestaurant _detailRestaurant;
  late ResultState _state;

  DetailRestaurant get detailRestaurant => _detailRestaurant;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      final result = await apiService.getDetailRestaurant(id);

      if (result.message.toString() == "restaurant not found") {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _detailRestaurant = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message = 'tidak ada internet';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }
}
