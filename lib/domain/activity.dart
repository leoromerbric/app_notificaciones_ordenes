import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  const Activity({
    required this.id,
    required this.name,
    required this.plannedDuration,
    this.actualDuration,
    this.startTime,
    this.endTime,
    this.status = 'PENDING',
  });

  final String id;
  final String name;
  final Duration plannedDuration;
  final Duration? actualDuration;
  final DateTime? startTime;
  final DateTime? endTime;
  final String status;

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity copyWith({
    String? id,
    String? name,
    Duration? plannedDuration,
    Duration? actualDuration,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      plannedDuration: plannedDuration ?? this.plannedDuration,
      actualDuration: actualDuration ?? this.actualDuration,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }
}