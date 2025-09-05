import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_notificaciones_ordenes/domain/work_order.dart';
import 'package:app_notificaciones_ordenes/core/constants.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for demonstration
    final mockOrders = [
      WorkOrder(
        id: 'WO001',
        customerOrder: 'CO-2024-001',
        customerItem: 'ITEM-ABC-123',
        plant: 'Plant 01',
        workCenter: 'WC-001',
        status: AppConstants.statusPending,
        scheduledStart: DateTime.now(),
        scheduledEnd: DateTime.now().add(const Duration(hours: 8)),
        description: 'Production order for customer ABC',
      ),
      WorkOrder(
        id: 'WO002',
        customerOrder: 'CO-2024-002',
        customerItem: 'ITEM-XYZ-456',
        plant: 'Plant 01',
        workCenter: 'WC-002',
        status: AppConstants.statusInProgress,
        scheduledStart: DateTime.now().subtract(const Duration(hours: 2)),
        scheduledEnd: DateTime.now().add(const Duration(hours: 6)),
        description: 'Production order for customer XYZ',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Orders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mockOrders.length,
        itemBuilder: (context, index) {
          final order = mockOrders[index];
          return _OrderCard(order: order);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement barcode scanning
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Barcode scanning not implemented yet')),
          );
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final WorkOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(order.status);

    return Card(
      child: ListTile(
        title: Text(
          order.customerOrder,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item: ${order.customerItem}'),
            Text('Plant: ${order.plant} - ${order.workCenter}'),
            Text('Scheduled: ${_formatDateTime(order.scheduledStart)}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                order.status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          context.go('/operations/${order.id}');
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case AppConstants.statusPending:
        return Colors.orange;
      case AppConstants.statusInProgress:
        return Colors.blue;
      case AppConstants.statusCompleted:
        return Colors.green;
      case AppConstants.statusCancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}