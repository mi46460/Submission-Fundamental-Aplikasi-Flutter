import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:submission/provider/database_provider.dart';
import 'package:submission/ui/HomePage/restaurant_item.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.bookmarks.length,
          itemBuilder: (context, index) {
            return RestaurantItem(restaurant: provider.bookmarks[index]);
          },
        );
      },
    );
  }
}
