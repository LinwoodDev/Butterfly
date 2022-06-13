// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DavRemoteStorage _$$DavRemoteStorageFromJson(Map json) => _$DavRemoteStorage(
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      url: json['url'] as String,
      path: json['path'] as String,
      documentsPath: json['documentsPath'] as String,
      templatesPath: json['templatesPath'] as String,
      icon: const Uint8ListJsonConverter().fromJson(json['icon'] as String),
    );

Map<String, dynamic> _$$DavRemoteStorageToJson(_$DavRemoteStorage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'url': instance.url,
      'path': instance.path,
      'documentsPath': instance.documentsPath,
      'templatesPath': instance.templatesPath,
      'icon': const Uint8ListJsonConverter().toJson(instance.icon),
    };
