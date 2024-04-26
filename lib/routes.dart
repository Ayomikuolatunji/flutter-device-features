import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:net_ninja_course/screens/add_new_place.dart';
import 'package:net_ninja_course/screens/home_screen.dart';

GoRouter appRoutes(BuildContext context) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'add-new-place',
            builder: (context, state) {
              return const AddNewPlace();
            },
          ),
        ],
      ),
    ],
  );
}
