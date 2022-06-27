// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DavRemoteStorage _$$DavRemoteStorageFromJson(Map json) => _$DavRemoteStorage(
      username: json['username'] as String,
      url: json['url'] as String,
      path: json['path'] as String,
      documentsPath: json['documentsPath'] as String,
      templatesPath: json['templatesPath'] as String,
      cachedDocuments: (json['cachedDocuments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      icon: const Uint8ListJsonConverter().fromJson(json['icon'] as String),
    );

Map<String, dynamic> _$$DavRemoteStorageToJson(_$DavRemoteStorage instance) =>
    <String, dynamic>{
      'username': instance.username,
      'url': instance.url,
      'path': instance.path,
      'documentsPath': instance.documentsPath,
      'templatesPath': instance.templatesPath,
      'cachedDocuments': instance.cachedDocuments,
      'icon': const Uint8ListJsonConverter().toJson(instance.icon),
    };
