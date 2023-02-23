import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/data/model/restaurant.dart';
import 'package:submission/pages/detail_page.dart';
import 'package:submission/provider/database_provider.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.route,
          arguments: restaurant,
        );
      },
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
              future: provider.isBookmarked(restaurant.id),
              builder: (context, snapshot) {
                var isBookmarked = snapshot.data ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      elevation: 4.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: restaurant.pictureId,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              child: SizedBox.fromSize(
                                child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12),
                            child: Text(
                              restaurant.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    restaurant.description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.star_border_outlined),
                                      Text(
                                        '${restaurant.rating}',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_city),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.5, left: 4.0),
                                      child: Text(restaurant.city),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      isBookmarked
                                          ? IconButton(
                                              icon: const Icon(Icons.bookmark),
                                              onPressed: () =>
                                                  provider.removeBookmark(
                                                      restaurant.id),
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                  Icons.bookmark_border),
                                              onPressed: () => provider
                                                  .addBookmark(restaurant),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                );
              });
        },
      ),
    );
  }
}
