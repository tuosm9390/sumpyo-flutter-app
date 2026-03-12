// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Prescription {
  String get id;
  String get title;
  String get content;
  String get quote;
  String get emotion;
  String get style;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrescriptionCopyWith<Prescription> get copyWith =>
      _$PrescriptionCopyWithImpl<Prescription>(
          this as Prescription, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Prescription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, quote, emotion, style);

  @override
  String toString() {
    return 'Prescription(id: $id, title: $title, content: $content, quote: $quote, emotion: $emotion, style: $style)';
  }
}

/// @nodoc
abstract mixin class $PrescriptionCopyWith<$Res> {
  factory $PrescriptionCopyWith(
          Prescription value, $Res Function(Prescription) _then) =
      _$PrescriptionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String quote,
      String emotion,
      String style});
}

/// @nodoc
class _$PrescriptionCopyWithImpl<$Res> implements $PrescriptionCopyWith<$Res> {
  _$PrescriptionCopyWithImpl(this._self, this._then);

  final Prescription _self;
  final $Res Function(Prescription) _then;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? quote = null,
    Object? emotion = null,
    Object? style = null,
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
      emotion: null == emotion
          ? _self.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Prescription implements Prescription {
  const _Prescription(
      {required this.id,
      required this.title,
      required this.content,
      required this.quote,
      required this.emotion,
      this.style = "F"});

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String quote;
  @override
  final String emotion;
  @override
  @JsonKey()
  final String style;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrescriptionCopyWith<_Prescription> get copyWith =>
      __$PrescriptionCopyWithImpl<_Prescription>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Prescription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, quote, emotion, style);

  @override
  String toString() {
    return 'Prescription(id: $id, title: $title, content: $content, quote: $quote, emotion: $emotion, style: $style)';
  }
}

/// @nodoc
abstract mixin class _$PrescriptionCopyWith<$Res>
    implements $PrescriptionCopyWith<$Res> {
  factory _$PrescriptionCopyWith(
          _Prescription value, $Res Function(_Prescription) _then) =
      __$PrescriptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      String quote,
      String emotion,
      String style});
}

/// @nodoc
class __$PrescriptionCopyWithImpl<$Res>
    implements _$PrescriptionCopyWith<$Res> {
  __$PrescriptionCopyWithImpl(this._self, this._then);

  final _Prescription _self;
  final $Res Function(_Prescription) _then;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? quote = null,
    Object? emotion = null,
    Object? style = null,
  }) {
    return _then(_Prescription(
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
      emotion: null == emotion
          ? _self.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
