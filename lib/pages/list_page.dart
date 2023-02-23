import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/provider/list_restaurant_provider.dart';
import 'package:submission/provider/search_restaurant_provider.dart';
import 'package:submission/ui/HomePage/restaurant_item.dart';
import 'package:submission/data/model/restaurant.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  static const String route = '/home_page';

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
      ),
      body: Consumer<SearchRestaurantProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Search your restaurants',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                    onChanged: (value) {
                      keyword = value;
                      if (keyword.isNotEmpty) {
                        _searchData(provider, keyword);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              keyword.isEmpty
                  ? Expanded(child: _listRestaurantBuilder())
                  : Expanded(child: _listSearchBuilder(provider))
            ],
          );
        },
      ),
    );
  }

  _searchData(SearchRestaurantProvider provider, String query) {
    provider.searchRestaurant(query);
  }

  Widget _listSearchBuilder(SearchRestaurantProvider provider) {
    if (provider.state == ResultSearchState.loading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Colors.black,
        ),
      );
    } else {
      if (provider.state == ResultSearchState.hasData) {
        return _listBuilder(provider.searchRestaurantData.restaurants);
      } else if (provider.state == ResultSearchState.noData) {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      } else if (provider.state == ResultSearchState.error) {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      } else {
        return Material(child: Text(provider.message));
      }
    }
  }

  Widget _listRestaurantBuilder() {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultListAllState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: Colors.black,
            ),
          );
        } else {
          if (provider.state == ResultListAllState.hasData) {
            return _listBuilder(provider.result.restaurants);
          } else if (provider.state == ResultListAllState.error) {
            return Center(
              child: Material(child: Text(provider.message)),
            );
          } else {
            return const Center(
              child: Material(child: Text('')),
            );
          }
        }
      },
    );
  }

  Widget _listBuilder(List<RestaurantModel> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return RestaurantItem(restaurant: restaurants[index]);
      },
    );
  }
}
