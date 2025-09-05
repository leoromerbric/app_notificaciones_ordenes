import 'package:json_annotation/json_annotation.dart';
import 'package:app_notificaciones_ordenes/domain/activity.dart';

part 'operation.g.dart';

@JsonSerializable()
class Operation {
  const Operation({
    required this.id,
    required this.workOrderId,
    required this.code,
    required this.shortText,
    required this.status,
    required this.plannedActivities,
    this.actualStartTime,
    this.actualEndTime,
    this.goodQuantity = 0,
    this.rejectQuantity = 0,
    this.reprocessQuantity = 0,
  });

  final String id;
  final String workOrderId;
  final String code;
  final String shortText;
  final String status;
  final List<Activity> plannedActivities;
  final DateTime? actualStartTime;
  final DateTime? actualEndTime;
  final int goodQuantity;
  final int rejectQuantity;
  final int reprocessQuantity;

  int get totalQuantity => goodQuantity + rejectQuantity + reprocessQuantity;

  factory Operation.fromJson(Map<String, dynamic> json) =>
      _$OperationFromJson(json);

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  Operation copyWith({
    String? id,
    String? workOrderId,
    String? code,
    String? shortText,
    String? status,
    List<Activity>? plannedActivities,
    DateTime? actualStartTime,
    DateTime? actualEndTime,
    int? goodQuantity,
    int? rejectQuantity,
    int? reprocessQuantity,
  }) {
    return Operation(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      code: code ?? this.code,
      shortText: shortText ?? this.shortText,
      status: status ?? this.status,
      plannedActivities: plannedActivities ?? this.plannedActivities,
      actualStartTime: actualStartTime ?? this.actualStartTime,
      actualEndTime: actualEndTime ?? this.actualEndTime,
      goodQuantity: goodQuantity ?? this.goodQuantity,
      rejectQuantity: rejectQuantity ?? this.rejectQuantity,
      reprocessQuantity: reprocessQuantity ?? this.reprocessQuantity,
    );
  }
}