import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_notificaciones_ordenes/domain/material.dart';
import 'package:app_notificaciones_ordenes/domain/material_movement.dart';
import 'package:app_notificaciones_ordenes/core/constants.dart';

class MaterialsScreen extends ConsumerStatefulWidget {
  const MaterialsScreen({super.key, required this.operationId});

  final String operationId;

  @override
  ConsumerState<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends ConsumerState<MaterialsScreen> {
  final List<MaterialMovement> movements = [];

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final mockMaterials = [
      const Material(
        id: 'MAT001',
        code: 'STEEL-001',
        description: 'Steel plate 10mm',
        unit: 'kg',
        availableQuantity: 500.0,
        reservedQuantity: 50.0,
        batchNumber: 'BATCH-2024-001',
      ),
      const Material(
        id: 'MAT002',
        code: 'BOLT-M8',
        description: 'Bolt M8x20',
        unit: 'pcs',
        availableQuantity: 1000.0,
        reservedQuantity: 0.0,
        batchNumber: 'BATCH-2024-002',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Materials - ${widget.operationId}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mockMaterials.length,
              itemBuilder: (context, index) {
                final material = mockMaterials[index];
                return _MaterialCard(
                  material: material,
                  onMovement: (movement) {
                    setState(() {
                      movements.add(movement);
                    });
                    _showMovementSuccess(movement);
                  },
                );
              },
            ),
          ),
          if (movements.isNotEmpty) _buildMovementsSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBarcodeScanner();
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Widget _buildMovementsSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.history),
                const SizedBox(width: 8),
                const Text(
                  'Recent Movements',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text('${movements.length} items'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movements.length,
              itemBuilder: (context, index) {
                final movement = movements[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    movement.movementType == AppConstants.movementTypeOutput
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    color:
                        movement.movementType == AppConstants.movementTypeOutput
                        ? Colors.red
                        : Colors.green,
                  ),
                  title: Text(movement.materialId),
                  subtitle: Text(
                    '${movement.quantity} ${movement.movementType}',
                  ),
                  trailing: Text(
                    '${movement.timestamp.hour}:${movement.timestamp.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMovementSuccess(MaterialMovement movement) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${movement.movementType} recorded: ${movement.quantity} units',
        ),
        backgroundColor:
            movement.movementType == AppConstants.movementTypeOutput
            ? Colors.orange
            : Colors.green,
      ),
    );
  }

  void _showBarcodeScanner() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode scanner not implemented yet')),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  const _MaterialCard({required this.material, required this.onMovement});

  final Material material;
  final Function(MaterialMovement) onMovement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ExpansionTile(
        title: Text(
          material.code,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(material.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Available: ${material.netAvailableQuantity} ${material.unit}',
                ),
                if (material.batchNumber != null) ...[
                  const SizedBox(width: 16),
                  Text('Batch: ${material.batchNumber}'),
                ],
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        'Available',
                        '${material.availableQuantity}',
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoCard(
                        'Reserved',
                        '${material.reservedQuantity}',
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoCard(
                        'Net Available',
                        '${material.netAvailableQuantity}',
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showMovementDialog(
                        context,
                        AppConstants.movementTypeOutput,
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Output'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showMovementDialog(
                        context,
                        AppConstants.movementTypeReturn,
                      ),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Return'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }

  void _showMovementDialog(BuildContext context, String movementType) {
    final quantityController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$movementType Material'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity (${material.unit})',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final quantity = double.tryParse(quantityController.text);
              if (quantity != null && quantity > 0) {
                final movement = MaterialMovement(
                  id: 'MOV${DateTime.now().millisecondsSinceEpoch}',
                  materialId: material.id,
                  operationId: 'CURRENT_OPERATION',
                  movementType: movementType,
                  quantity: quantity,
                  timestamp: DateTime.now(),
                  batchNumber: material.batchNumber,
                  notes: notesController.text.isEmpty
                      ? null
                      : notesController.text,
                );
                onMovement(movement);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
