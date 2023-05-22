import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String email;
  final String avatarUrl;

  const UserModel({
    required this.email,
    required this.avatarUrl,
  });

  const UserModel.empty()
      : this(
          email: 'duc@nimblehq.co',
          avatarUrl: '',
        );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  List<Object?> get props => [
        email,
        avatarUrl,
      ];
}
