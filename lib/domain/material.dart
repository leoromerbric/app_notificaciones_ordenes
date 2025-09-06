import 'package:json_annotation/json_annotation.dart';

part 'material.g.dart';

@JsonSerializable()
class Material {

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);
  const Material({
    required this.id,
    required this.code,
    required this.description,
    required this.unit,
    required this.availableQuantity,
    this.reservedQuantity = 0,
    this.batchNumber,
    this.expirationDate,
  });

  final String id;
  final String code;
  final String description;
  final String unit;
  final double availableQuantity;
  final double reservedQuantity;
  final String? batchNumber;
  final DateTime? expirationDate;

  double get netAvailableQuantity => availableQuantity - reservedQuantity;

  Map<String, dynamic> toJson() => _$MaterialToJson(this);

  Material copyWith({
    String? id,
    String? code,
    String? description,
    String? unit,
    double? availableQuantity,
    double? reservedQuantity,
    String? batchNumber,
    DateTime? expirationDate,
  }) {
    return Material(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      reservedQuantity: reservedQuantity ?? this.reservedQuantity,
      batchNumber: batchNumber ?? this.batchNumber,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }
}