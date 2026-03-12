// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrescriptionModel {
  String get id;
  String get title;
  String get content;
  String get quote;

  /// Create a copy of PrescriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrescriptionModelCopyWith<PrescriptionModel> get copyWith =>
      _$PrescriptionModelCopyWithImpl<PrescriptionModel>(
          this as PrescriptionModel, _$identity);

  /// Serializes this PrescriptionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrescriptionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.quote, quote) || other.quote == quote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, quote);

  @override
  String toString() {
    return 'PrescriptionModel(id: $id, title: $title, content: $content, quote: $quote)';
  }
}

/// @nodoc
abstract mixin class $PrescriptionModelCopyWith<$Res> {
  factory $PrescriptionModelCopyWith(
          PrescriptionModel value, $Res Function(PrescriptionModel) _then) =
      _$PrescriptionModelCopyWithImpl;
  @useResult
  $Res call({String id, String title, String content, String quote});
}

/// @nodoc
class _$PrescriptionModelCopyWithImpl<$Res>
    implements $PrescriptionModelCopyWith<$Res> {
  _$PrescriptionModelCopyWithImpl(this._self, this._then);

  final PrescriptionModel _self;
  final $Res Function(PrescriptionModel) _then;

  /// Create a copy of PrescriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? quote = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      quote: null == quote
          ? _self.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PrescriptionModel extends PrescriptionModel {
  const _PrescriptionModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.quote})
      : super._();
  factory _PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String quote;

  /// Create a copy of PrescriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrescriptionModelCopyWith<_PrescriptionModel> get copyWith =>
      __$PrescriptionModelCopyWithImpl<_PrescriptionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PrescriptionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrescriptionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.quote, quote) || other.quote == quote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, quote);

  @override
  String toString() {
    return 'PrescriptionModel(id: $id, title: $title, content: $content, quote: $quote)';
  }
}

/// @nodoc
abstract mixin class _$PrescriptionModelCopyWith<$Res>
    implements $PrescriptionModelCopyWith<$Res> {
  factory _$PrescriptionModelCopyWith(
          _PrescriptionModel value, $Res Function(_PrescriptionModel) _then) =
      __$PrescriptionModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, String content, String quote});
}

/// @nodoc
class __$PrescriptionModelCopyWithImpl<$Res>
    implements _$PrescriptionModelCopyWith<$Res> {
  __$PrescriptionModelCopyWithImpl(this._self, this._then);

  final _PrescriptionModel _self;
  final $Res Function(_PrescriptionModel) _then;

  /// Create a copy of PrescriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? quote = null,
  }) {
    return _then(_PrescriptionModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      quote: null == quote
          ? _self.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
