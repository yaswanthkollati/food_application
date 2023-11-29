import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/components/bottom_bar.dart';
import 'package:food_application/utils/parameters.dart';
import 'package:go_router/go_router.dart';

import '../components/see_all_row.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import '../data/foodList.dart';
import '../utils/app_theme.dart';
import '../utils/colors.dart';
import '../utils/image_list.dart';
import '../utils/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  children: [
                    appBarWidget(context),
                    SizedBox(height: 30,),

               CarouselSlider(
  options: CarouselOptions(
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    enlargeCenterPage: true,
    aspectRatio: 16 / 9,
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    viewportFraction: 0.8,
    onPageChanged: (index, reason) {
      setState(() {
        _currentIndex = index;
      });
    },
  ),
  items: sliderimageList.map((assetPath) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Image.asset(
          assetPath,

        ),
      ),
    );
  }).toList(),
),

                    seeAllRowWidget(Strings.category, state),
                    Container(
                      height: 160,
                      padding: EdgeInsets.all(8),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Image.asset(
                                    croppedFoodImageList[index],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              width: 12,
                            );
                          },
                          itemCount: 5),
                    ),

                    seeAllRowWidget(Strings.nearbyFood, state),
                    locationWidget(),
                    foodListWidget(state),
                  ],
                ),
                const BottomBarWidget()
              ],
            ),
          ),
        );
      },
    );
  }

  Container foodListWidget(AppState state) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color.fromARGB(255, 225, 211, 211).withOpacity(0.1),
          ],
        ),
      ),
      height: 450,
      child: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final foodItem = foodList[index];
              return Container(
                margin: EdgeInsets.only(
                    left: index == 0 ? 13 : 0, top: 15, right: 8),
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    context.read<AppCubit>().clearStatesValues();
                    Parameters parameters =
                        Parameters(foodItem: foodItem, foodIndex: index);
                    context.push('/foodDetail', extra: parameters);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.asset(
                                foodImageList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15, left: 18),
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.amber,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  Strings.scoreList[index].toString(),
                                  style: AppTheme.getTextTheme(null)
                                      .bodySmall!
                                      .copyWith(
                                          color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 7, left: 16),
                            child: Text(
                              foodItem.name,
                              style: AppTheme.getTextTheme(null)
                                  .bodyMedium!
                                  .copyWith(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Text(
                                      "${foodItem.price} ",
                                      style: AppTheme.getTextTheme(null)
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<AppCubit>()
                                        .likeDislikeFood(index);
                                  },
                                  child: state.likedFoodList.contains(index)
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: const Icon(
                                            CupertinoIcons.heart_fill,
                                            size: 28,
                                            color: Colors.red,
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: const Icon(
                                            CupertinoIcons.heart,
                                            size: 28,
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: 12,
              );
            },
            itemCount: foodList.length),
      ),
    );
  }

  Container locationWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 8),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            size: 18,
            color: Colors.black.withOpacity(0.4),
          ),
          Text(Strings.location),
        ],
      ),
    );
  }

  Container appBarWidget(BuildContext context) {
    final currentTime = DateTime.now().toLocal();
    final hour = currentTime.hour;

    String mealTime = '';

    if (hour >= 4 && hour < 11) {
      mealTime = 'Breakfast';
     } else if (hour >= 11 && hour < 16) {
      mealTime = 'Lunch';
    } else if(hour >= 16 && hour < 19) {
      mealTime = 'snacks';
    }else
    mealTime = 'Dinner';
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.hiyaswanth,
                style: AppTheme.getTextTheme(null).titleLarge,
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  'It\'s $mealTime time',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () => context.push('/course'),
            child: const Icon(
              CupertinoIcons.search,
              size: 30,
            ),
          )
        ],
      ),
    );
  }


}
List<FoodList> foodList = List.generate(
  Strings.foodTitleList.length,
  (index) => FoodList(
    name: Strings.foodTitleList[index],
    image: foodImageList[index],
    description: Strings.foodDesc[index],
    price: Strings.foodPriceList[index],
  ),
);

// List<FoodList> foodList = [
//   FoodList(
//     name: Strings.foodTitleList[0],
//     image: foodImageList[0],
//     description: Strings.foodDesc[0],
//     price: Strings.foodPriceList[0],
//   ),
//   FoodList(
//     name: Strings.foodTitleList[1],
//     image: foodImageList[1],
//     description: Strings.foodDesc[1],
//     price: Strings.foodPriceList[1],
//   ),
//   FoodList(
//     name: Strings.foodTitleList[2],
//     image: foodImageList[2],
//     description: Strings.foodDesc[2],
//     price: Strings.foodPriceList[2],
//   ),
//   FoodList(
//     name: Strings.foodTitleList[3],
//     image: foodImageList[3],
//     description: Strings.foodDesc[3],
//     price: Strings.foodPriceList[3],
//   ),
//   FoodList(
//     name: Strings.foodTitleList[4],
//     image: foodImageList[4],
//     description: Strings.foodDesc[4],
//     price: Strings.foodPriceList[4],
//   )
// ];
