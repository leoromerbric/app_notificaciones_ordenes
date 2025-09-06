import 'package:json_annotation/json_annotation.dart';

part 'work_order.g.dart';

@JsonSerializable()
class WorkOrder {

  factory WorkOrder.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderFromJson(json);
  const WorkOrder({
    required this.id,
    required this.customerOrder,
    required this.customerItem,
    required this.plant,
    required this.workCenter,
    required this.status,
    required this.scheduledStart,
    required this.scheduledEnd,
    this.actualStart,
    this.actualEnd,
    this.description,
  });

  final String id;
  final String customerOrder;
  final String customerItem;
  final String plant;
  final String workCenter;
  final String status;
  final DateTime scheduledStart;
  final DateTime scheduledEnd;
  final DateTime? actualStart;
  final DateTime? actualEnd;
  final String? description;

  Map<String, dynamic> toJson() => _$WorkOrderToJson(this);

  WorkOrder copyWith({
    String? id,
    String? customerOrder,
    String? customerItem,
    String? plant,
    String? workCenter,
    String? status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? actualStart,
    DateTime? actualEnd,
    String? description,
  }) {
    return WorkOrder(
      id: id ?? this.id,
      customerOrder: customerOrder ?? this.customerOrder,
      customerItem: customerItem ?? this.customerItem,
      plant: plant ?? this.plant,
      workCenter: workCenter ?? this.workCenter,
      status: status ?? this.status,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      actualStart: actualStart ?? this.actualStart,
      actualEnd: actualEnd ?? this.actualEnd,
      description: description ?? this.description,
    );
  }
}