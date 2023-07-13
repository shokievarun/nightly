import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightly/models/models.dart';
import 'package:nightly/models/restaurant.dart';
import 'package:nightly/views/cart_screen.dart';
import 'package:nightly/views/error_screen.dart';
import 'package:nightly/views/login.dart';
import 'package:nightly/views/menu/menu_screen.dart';
import 'package:nightly/views/payment_screen.dart';
import 'package:nightly/views/restaurant/restaurant_list_screen.dart';
import 'package:nightly/views/splashscreen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  errorBuilder: (context, state) => ErrorScreen(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/restaurant',
          builder: (BuildContext context, GoRouterState state) {
            return RestaurantListScreen();
          },
        ),
        GoRoute(
          path: '/selectpayment',
          builder: (BuildContext context, GoRouterState state) {
            return PaymentSelectionScreen();
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) {
            OrderModel sample =
                state.extra as OrderModel; // 👈 casting is important
            return CartScreen(orderModel: sample, isFromHome: true);
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: '/menu',
          builder: (context, state) {
            Restaurant sample =
                state.extra as Restaurant; // 👈 casting is important
            return MenuScreen(restaurant: sample);
          },
        ),
      ],
    ),
  ],
);
