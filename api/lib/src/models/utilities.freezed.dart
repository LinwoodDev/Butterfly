// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'utilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UtilitiesState {
  bool get lockCollection;
  bool get lockZoom;
  bool get lockHorizontal;
  bool get lockVertical;
  bool get fullSelection;

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UtilitiesStateCopyWith<UtilitiesState> get copyWith =>
      _$UtilitiesStateCopyWithImpl<UtilitiesState>(
          this as UtilitiesState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UtilitiesState &&
            (identical(other.lockCollection, lockCollection) ||
                other.lockCollection == lockCollection) &&
            (identical(other.lockZoom, lockZoom) ||
                other.lockZoom == lockZoom) &&
            (identical(other.lockHorizontal, lockHorizontal) ||
                other.lockHorizontal == lockHorizontal) &&
            (identical(other.lockVertical, lockVertical) ||
                other.lockVertical == lockVertical) &&
            (identical(other.fullSelection, fullSelection) ||
                other.fullSelection == fullSelection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lockCollection, lockZoom,
      lockHorizontal, lockVertical, fullSelection);

  @override
  String toString() {
    return 'UtilitiesState(lockCollection: $lockCollection, lockZoom: $lockZoom, lockHorizontal: $lockHorizontal, lockVertical: $lockVertical, fullSelection: $fullSelection)';
  }
}

/// @nodoc
abstract mixin class $UtilitiesStateCopyWith<$Res> {
  factory $UtilitiesStateCopyWith(
          UtilitiesState value, $Res Function(UtilitiesState) _then) =
      _$UtilitiesStateCopyWithImpl;
  @useResult
  $Res call(
      {bool lockCollection,
      bool lockZoom,
      bool lockHorizontal,
      bool lockVertical,
      bool fullSelection});
}

/// @nodoc
class _$UtilitiesStateCopyWithImpl<$Res>
    implements $UtilitiesStateCopyWith<$Res> {
  _$UtilitiesStateCopyWithImpl(this._self, this._then);

  final UtilitiesState _self;
  final $Res Function(UtilitiesState) _then;

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockCollection = null,
    Object? lockZoom = null,
    Object? lockHorizontal = null,
    Object? lockVertical = null,
    Object? fullSelection = null,
  }) {
    return _then(UtilitiesState(
      lockCollection: null == lockCollection
          ? _self.lockCollection
          : lockCollection // ignore: cast_nullable_to_non_nullable
              as bool,
      lockZoom: null == lockZoom
          ? _self.lockZoom
          : lockZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      lockHorizontal: null == lockHorizontal
          ? _self.lockHorizontal
          : lockHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
      lockVertical: null == lockVertical
          ? _self.lockVertical
          : lockVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      fullSelection: null == fullSelection
          ? _self.fullSelection
          : fullSelection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
