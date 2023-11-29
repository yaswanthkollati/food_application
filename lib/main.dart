
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/screens/course_page.dart';
import 'package:food_application/screens/food_detail_page.dart';
import 'package:food_application/screens/home_page.dart';
import 'package:food_application/utils/parameters.dart';
import 'package:go_router/go_router.dart';
import 'cubit/app_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AppCubit(),
      child: MyApp(), // Your main widget
    ),
  );
}


/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'foodDetail',
          builder: (BuildContext context, GoRouterState state) {
            Parameters parameters = state.extra as Parameters;
            return FoodDetailPage(
              parameters: parameters, appCubit: AppCubit(),
            );
          },
        ),
        // GoRoute(
        //   path: 'course',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const CoursePage();
        //   },
        // ),

      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
