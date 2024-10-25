// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerModelImpl _$$TimerModelImplFromJson(Map<String, dynamic> json) =>
    _$TimerModelImpl(
      secs: (json['secs'] as num).toInt(),
      mins: (json['mins'] as num).toInt(),
      isRunning: json['isRunning'] as bool? ?? false,
    );

Map<String, dynamic> _$$TimerModelImplToJson(_$TimerModelImpl instance) =>
    <String, dynamic>{
      'secs': instance.secs,
      'mins': instance.mins,
      'isRunning': instance.isRunning,
    };
