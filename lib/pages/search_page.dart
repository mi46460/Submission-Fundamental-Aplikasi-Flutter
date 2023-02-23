import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/provider/search_restaurant_provider.dart';

import '../ui/SearchPage/restaurant_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String route = '/search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<SearchRestaurantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Consumer<SearchRestaurantProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
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
                      _searchData(provider, value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: _buildList(provider),
              )
            ],
          );
        },
      ),
    );
  }

  _searchData(SearchRestaurantProvider provider, String query) {
    provider.searchRestaurant(query);
  }

  Widget _buildList(SearchRestaurantProvider newProvider) {
    if (newProvider.state == ResultSearchState.loading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Colors.black,
        ),
      );
    } else {
      if (newProvider.state == ResultSearchState.hasData) {
        return ListView.builder(
            itemCount: newProvider.searchRestaurantData.restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantItem(
                  restaurant:
                      newProvider.searchRestaurantData.restaurants[index]);
            });
      } else if (newProvider.state == ResultSearchState.noData) {
        return Center(
          child: Material(
            child: Text(newProvider.message),
          ),
        );
      } else if (newProvider.state == ResultSearchState.error) {
        return Center(
          child: Material(
            child: Text(newProvider.message),
          ),
        );
      } else {
        return Material(child: Text(newProvider.message));
      }
    }
  }
}
