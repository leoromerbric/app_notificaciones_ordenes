import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app_notificaciones_ordenes/features/orders/presentation/orders_screen.dart';
import 'package:app_notificaciones_ordenes/features/operations/presentation/operations_screen.dart';
import 'package:app_notificaciones_ordenes/features/materials/presentation/materials_screen.dart';
import 'package:app_notificaciones_ordenes/features/receipt/presentation/receipt_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/orders',
    routes: [
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/operations/:orderId',
        name: 'operations',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return OperationsScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/materials/:operationId',
        name: 'materials',
        builder: (context, state) {
          final operationId = state.pathParameters['operationId']!;
          return MaterialsScreen(operationId: operationId);
        },
      ),
      GoRoute(
        path: '/receipt/:orderId',
        name: 'receipt',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return ReceiptScreen(orderId: orderId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.fullPath}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/orders'),
              child: const Text('Go to Orders'),
            ),
          ],
        ),
      ),
    ),
  );
}