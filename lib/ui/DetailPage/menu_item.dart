import 'package:flutter/material.dart';
import 'package:submission/data/model/detail_restaurant.dart';

class MenuRenderItem extends StatelessWidget {
  const MenuRenderItem({super.key, required this.listMenu});

  final List<Category> listMenu;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listMenu.length,
        itemBuilder: (context, index) => _renderMenuItem(listMenu[index].name));
  }

  Widget _renderMenuItem(String name) {
    return (Card(
      color: const Color.fromARGB(250, 90, 202, 216),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          name,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    ));
  }
}
