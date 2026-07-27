// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'renderer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TableHitTarget {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableHitTarget);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TableHitTarget()';
}


}

/// @nodoc
class $TableHitTargetCopyWith<$Res>  {
$TableHitTargetCopyWith(TableHitTarget _, $Res Function(TableHitTarget) __);
}



/// @nodoc


class TableCellTarget implements TableHitTarget {
  const TableCellTarget(this.row, this.column);
  

 final  int row;
 final  int column;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableCellTargetCopyWith<TableCellTarget> get copyWith => _$TableCellTargetCopyWithImpl<TableCellTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableCellTarget&&(identical(other.row, row) || other.row == row)&&(identical(other.column, column) || other.column == column));
}


@override
int get hashCode => Object.hash(runtimeType,row,column);

@override
String toString() {
  return 'TableHitTarget.cell(row: $row, column: $column)';
}


}

/// @nodoc
abstract mixin class $TableCellTargetCopyWith<$Res> implements $TableHitTargetCopyWith<$Res> {
  factory $TableCellTargetCopyWith(TableCellTarget value, $Res Function(TableCellTarget) _then) = _$TableCellTargetCopyWithImpl;
@useResult
$Res call({
 int row, int column
});




}
/// @nodoc
class _$TableCellTargetCopyWithImpl<$Res>
    implements $TableCellTargetCopyWith<$Res> {
  _$TableCellTargetCopyWithImpl(this._self, this._then);

  final TableCellTarget _self;
  final $Res Function(TableCellTarget) _then;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? row = null,Object? column = null,}) {
  return _then(TableCellTarget(
null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TableLineTarget implements TableHitTarget {
  const TableLineTarget(this.axis, this.line);
  

 final  TableAxis axis;
 final  int line;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableLineTargetCopyWith<TableLineTarget> get copyWith => _$TableLineTargetCopyWithImpl<TableLineTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableLineTarget&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.line, line) || other.line == line));
}


@override
int get hashCode => Object.hash(runtimeType,axis,line);

@override
String toString() {
  return 'TableHitTarget.line(axis: $axis, line: $line)';
}


}

/// @nodoc
abstract mixin class $TableLineTargetCopyWith<$Res> implements $TableHitTargetCopyWith<$Res> {
  factory $TableLineTargetCopyWith(TableLineTarget value, $Res Function(TableLineTarget) _then) = _$TableLineTargetCopyWithImpl;
@useResult
$Res call({
 TableAxis axis, int line
});




}
/// @nodoc
class _$TableLineTargetCopyWithImpl<$Res>
    implements $TableLineTargetCopyWith<$Res> {
  _$TableLineTargetCopyWithImpl(this._self, this._then);

  final TableLineTarget _self;
  final $Res Function(TableLineTarget) _then;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? axis = null,Object? line = null,}) {
  return _then(TableLineTarget(
null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as TableAxis,null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TableBorderTarget implements TableHitTarget {
  const TableBorderTarget(this.axis, this.line, this.segment);
  

 final  TableAxis axis;
 final  int line;
 final  int segment;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableBorderTargetCopyWith<TableBorderTarget> get copyWith => _$TableBorderTargetCopyWithImpl<TableBorderTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableBorderTarget&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.line, line) || other.line == line)&&(identical(other.segment, segment) || other.segment == segment));
}


@override
int get hashCode => Object.hash(runtimeType,axis,line,segment);

@override
String toString() {
  return 'TableHitTarget.border(axis: $axis, line: $line, segment: $segment)';
}


}

/// @nodoc
abstract mixin class $TableBorderTargetCopyWith<$Res> implements $TableHitTargetCopyWith<$Res> {
  factory $TableBorderTargetCopyWith(TableBorderTarget value, $Res Function(TableBorderTarget) _then) = _$TableBorderTargetCopyWithImpl;
@useResult
$Res call({
 TableAxis axis, int line, int segment
});




}
/// @nodoc
class _$TableBorderTargetCopyWithImpl<$Res>
    implements $TableBorderTargetCopyWith<$Res> {
  _$TableBorderTargetCopyWithImpl(this._self, this._then);

  final TableBorderTarget _self;
  final $Res Function(TableBorderTarget) _then;

/// Create a copy of TableHitTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? axis = null,Object? line = null,Object? segment = null,}) {
  return _then(TableBorderTarget(
null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as TableAxis,null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
