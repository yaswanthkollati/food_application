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
      height: 80, // Set the desired height here
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
                    // Container(
                    //   margin: const EdgeInsets.only(top: 20),
                    //   height: 80,
                    //   child: ListView.separated(
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         return GestureDetector(
                    //           onTap: () {},
                    //           child: Container(
                    //             margin:
                    //                 EdgeInsets.only(left: index == 0 ? 20 : 0),
                    //             height: 60,
                    //             width: 120,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(14),
                    //               color: colorList[index],
                    //             ),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Container(
                    //                   margin: const EdgeInsets.only(
                    //                       top: 5, left: 16),
                    //                   child: Text(
                    //                     Strings.categoryListName[index],
                    //                     style: AppTheme.getTextTheme(null)
                    //                         .bodyMedium!
                    //                         .copyWith(
                    //                             fontWeight: FontWeight.w500,
                    //                             fontSize: 16,
                    //                             color: Colors.black),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   margin: const EdgeInsets.only(left: 70),
                    //                   child: ClipRRect(
                    //                     borderRadius: const BorderRadius.only(
                    //                       bottomRight: Radius.circular(14),
                    //                     ),
                    //                     child: Image.asset(
                    //                       croppedFoodImageList[index],
                    //                       height: 50,
                    //                       width: 50,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       separatorBuilder: (context, index) {
                    //         return Container(
                    //           width: 12,
                    //         );
                    //       },
                    //       itemCount: 4),
                    // ),
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
            Colors.grey.withOpacity(0.1),
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
     } else if (hour >= 11 && hour < 15) {
      mealTime = 'Lunch';
    } else if(hour >= 15 && hour < 18) {
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

  Container addressWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 22, left: 22, top: 30),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8, left: 24),
                        child: const Icon(
                          Icons.location_on,
                          size: 25,
                          color: Color.fromARGB(255, 236, 178, 7),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.yourDeliveryAddress,
                            style:
                                AppTheme.getTextTheme(null).bodySmall!.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            Strings.sampleAddress,
                            style: AppTheme.getTextTheme(null)
                                .bodyMedium!
                                .copyWith(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25, bottom: 5),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<FoodList> foodList = [
  FoodList(
    Strings.foodTitleList[0],
    foodImageList[0],
    Strings.foodDesc[0],
    Strings.foodPriceList[0],
  ),
  FoodList(
    Strings.foodTitleList[1],
    foodImageList[1],
    Strings.foodDesc[1],
    Strings.foodPriceList[1],
  ),
  FoodList(
    Strings.foodTitleList[2],
    foodImageList[2],
    Strings.foodDesc[2],
    Strings.foodPriceList[2],
  ),
  FoodList(
    Strings.foodTitleList[3],
    foodImageList[3],
    Strings.foodDesc[3],
    Strings.foodPriceList[3],
  ),
  FoodList(
    Strings.foodTitleList[4],
    foodImageList[4],
    Strings.foodDesc[4],
    Strings.foodPriceList[4],
  )
];
