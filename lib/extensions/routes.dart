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
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'restaurant',
          builder: (BuildContext context, GoRouterState state) {
            return RestaurantListScreen();
          },
          routes: [
            GoRoute(
              path: 'login',
              builder: (BuildContext context, GoRouterState state) {
                return const LoginPage();
              },
            ),
            GoRoute(
              path: 'cart',
              builder: (context, state) {
                final Map<String, dynamic> extras =
                    state.extra as Map<String, dynamic>;
                final OrderModel orderModel = extras['order'] as OrderModel;
                final Restaurant restaurant =
                    extras['restaurant'] as Restaurant;
                return CartScreen(
                  orderModel: orderModel,
                  restaurant: restaurant,
                );
              },
              routes: [
                GoRoute(
                  path: 'selectpayment',
                  builder: (BuildContext context, GoRouterState state) {
                    return PaymentSelectionScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'menu',
              builder: (context, state) {
                final Map<String, dynamic> extras =
                    state.extra as Map<String, dynamic>;
                final Restaurant restaurant =
                    extras['restaurant'] as Restaurant;
                return MenuScreen(restaurant: restaurant);
              },
              routes: [
                GoRoute(
                  path: 'cart',
                  builder: (context, state) {
                    final Map<String, dynamic> extras =
                        state.extra as Map<String, dynamic>;
                    final OrderModel orderModel = extras['order'] as OrderModel;
                    final Restaurant restaurant =
                        extras['restaurant'] as Restaurant;
                    return CartScreen(
                        orderModel: orderModel, restaurant: restaurant);
                  },
                  routes: [
                    GoRoute(
                      path: 'selectpayment',
                      builder: (BuildContext context, GoRouterState state) {
                        return PaymentSelectionScreen();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: 'selectpayment',
          builder: (BuildContext context, GoRouterState state) {
            return PaymentSelectionScreen();
          },
        ),
        GoRoute(
          path: 'cart',
          builder: (context, state) {
            OrderModel sample = state.extra as OrderModel;
            return CartScreen(
              orderModel: sample,
              restaurant: Restaurant(),
            );
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'menu',
          builder: (context, state) {
            Restaurant sample = state.extra as Restaurant;
            return MenuScreen(restaurant: sample);
          },
        ),
      ],
    ),
  ],
);
