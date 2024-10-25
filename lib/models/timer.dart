import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class TimerModel with _$TimerModel {
  const factory TimerModel({
    required int secs,
    required int mins,
    @Default(false) bool isRunning,
  }) = _TimerModel;

  factory TimerModel.fromJson(Map<String, dynamic> json) =>
      _$TimerModelFromJson(json);
}
