import 'package:json_annotation/json_annotation.dart';

part 'material_movement.g.dart';

@JsonSerializable()
class MaterialMovement {
  const MaterialMovement({
    required this.id,
    required this.materialId,
    required this.operationId,
    required this.movementType,
    required this.quantity,
    required this.timestamp,
    this.batchNumber,
    this.notes,
  });

  final String id;
  final String materialId;
  final String operationId;
  final String movementType; // OUTPUT, RETURN
  final double quantity;
  final DateTime timestamp;
  final String? batchNumber;
  final String? notes;

  factory MaterialMovement.fromJson(Map<String, dynamic> json) =>
      _$MaterialMovementFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialMovementToJson(this);

  MaterialMovement copyWith({
    String? id,
    String? materialId,
    String? operationId,
    String? movementType,
    double? quantity,
    DateTime? timestamp,
    String? batchNumber,
    String? notes,
  }) {
    return MaterialMovement(
      id: id ?? this.id,
      materialId: materialId ?? this.materialId,
      operationId: operationId ?? this.operationId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
      batchNumber: batchNumber ?? this.batchNumber,
      notes: notes ?? this.notes,
    );
  }
}