import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_application/screens/favorites.dart';

import '../utils/colors.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25),
            width: 40,
            height: 40,
            child: Icon(
              Icons.home_outlined,
              size: 30,
              color: red,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
            child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.favorite,
                size: 27,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            width: 47,
            height: 47,
            child: Icon(
              CupertinoIcons.shopping_cart,
              color: Colors.black.withOpacity(0.5),
              size: 28,
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.discount_outlined,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            width: 40,
            height: 40,
            child: Icon(
              CupertinoIcons.person,
              color: Colors.black.withOpacity(0.5),
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
