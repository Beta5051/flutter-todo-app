import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/convert.dart';

part 'todo.freezed.dart';

part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    int? id,
    required String content,
    required int timestamp,
    @JsonKey(fromJson: Convert.boolFromInt, toJson: Convert.boolToInt)
    @Default(false)
        bool isCheck,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
