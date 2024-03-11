// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Respo _$RespoFromJson(Map<String, dynamic> json) => Respo(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$RespoToJson(Respo instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
