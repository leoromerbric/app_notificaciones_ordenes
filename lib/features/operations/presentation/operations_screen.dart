import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_notificaciones_ordenes/domain/operation.dart';
import 'package:app_notificaciones_ordenes/domain/activity.dart';
import 'package:app_notificaciones_ordenes/core/constants.dart';

class OperationsScreen extends ConsumerWidget {
  const OperationsScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for demonstration
    final mockOperations = [
      Operation(
        id: 'OP001',
        workOrderId: orderId,
        code: 'OP-10',
        shortText: 'Setup and preparation',
        status: AppConstants.statusCompleted,
        plannedActivities: [
          Activity(
            id: 'ACT001',
            name: 'Machine setup',
            plannedDuration: const Duration(minutes: 30),
            actualDuration: const Duration(minutes: 25),
            status: AppConstants.statusCompleted,
          ),
        ],
        goodQuantity: 100,
        rejectQuantity: 5,
        reprocessQuantity: 2,
      ),
      Operation(
        id: 'OP002',
        workOrderId: orderId,
        code: 'OP-20',
        shortText: 'Main production',
        status: AppConstants.statusInProgress,
        plannedActivities: [
          Activity(
            id: 'ACT002',
            name: 'Production run',
            plannedDuration: const Duration(hours: 4),
            status: AppConstants.statusInProgress,
          ),
        ],
        goodQuantity: 50,
        rejectQuantity: 0,
        reprocessQuantity: 0,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Operations - $orderId'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mockOperations.length,
        itemBuilder: (context, index) {
          final operation = mockOperations[index];
          return _OperationCard(operation: operation);
        },
      ),
    );
  }
}

class _OperationCard extends StatelessWidget {
  const _OperationCard({required this.operation});

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(operation.status);

    return Card(
      child: ExpansionTile(
        title: Text(
          '${operation.code} - ${operation.shortText}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                operation.status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('Total: ${operation.totalQuantity}'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuantitySection(),
                const SizedBox(height: 16),
                _buildActivitiesSection(),
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantities:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuantityChip('Good', operation.goodQuantity, Colors.green),
            _buildQuantityChip('Reject', operation.rejectQuantity, Colors.red),
            _buildQuantityChip('Reprocess', operation.reprocessQuantity, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityChip(String label, int quantity, Color color) {
    return Column(
      children: [
        Text(
          quantity.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activities:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...operation.plannedActivities.map((activity) => ListTile(
          dense: true,
          leading: Icon(
            activity.status == AppConstants.statusCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: activity.status == AppConstants.statusCompleted
                ? Colors.green
                : Colors.grey,
          ),
          title: Text(activity.name),
          subtitle: Text(
            'Planned: ${activity.plannedDuration.inMinutes}min' +
            (activity.actualDuration != null
                ? ' | Actual: ${activity.actualDuration!.inMinutes}min'
                : ''),
          ),
        )),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            context.go('/materials/${operation.id}');
          },
          icon: const Icon(Icons.inventory),
          label: const Text('Materials'),
        ),
        FilledButton.icon(
          onPressed: () {
            _showConfirmationDialog(context);
          },
          icon: const Icon(Icons.check),
          label: const Text('Confirm'),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Operation'),
        content: const Text('Are you sure you want to confirm this operation?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Operation confirmed')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
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
}