import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  Source copyWith({
    String? id,
    String? name,
  }) =>
      Source(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
  
  @override
  List<Object?> get props => [id, name];
}
