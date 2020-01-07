import 'package:json_annotation/json_annotation.dart';

part 'activity_request.g.dart';

@JsonSerializable()
class ActivityRequest {
  @JsonKey(required: true)
  final String name;

  ActivityRequest(this.name);

  factory ActivityRequest.fromJson(Map<String, dynamic> json) => _$ActivityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRequestToJson(this);
}