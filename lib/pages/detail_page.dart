import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:submission/provider/detail_restaurant_provider.dart';
import 'package:submission/ui/DetailPage/menu_item.dart';
import '../data/model/detail_restaurant.dart';
import '../data/model/restaurant.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  static const route = '/detail_page';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    provider.getDetailRestaurant(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<DetailRestaurantProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: provider.state == ResultState.loading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.black,
                      ),
                    ),
                  )
                : provider.state == ResultState.hasData
                    ? _buildDetailPage(provider.detailRestaurant.restaurant)
                    : provider.state == ResultState.noData
                        ? Center(
                            child: Material(child: Text(provider.message)),
                          )
                        : provider.state == ResultState.error
                            ? Center(
                                child: Expanded(
                                  child: Material(
                                    child: Text(provider.message),
                                  ),
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                  child: Material(child: Text('')),
                                ),
                              ),
          );
        },
      ),
    );
  }

  Widget _buildDetailPage(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: restaurant.pictureId,
          child: Image.network(
              'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(restaurant.city)
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Icon(Icons.star_border_outlined),
                  const SizedBox(
                    width: 4,
                  ),
                  Text('${restaurant.rating}')
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(restaurant.description),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                'Menus',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Foods : ',
              ),
              SizedBox(
                  height: 36,
                  child: MenuRenderItem(listMenu: restaurant.menus.foods)),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Drinks : ',
              ),
              SizedBox(
                  height: 36,
                  child: MenuRenderItem(listMenu: restaurant.menus.drinks))
            ],
          ),
        )
      ],
    );
  }
}
