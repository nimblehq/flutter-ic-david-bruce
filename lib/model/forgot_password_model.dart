import 'package:equatable/equatable.dart';

class ForgotPasswordModel extends Equatable {
  final String message;

  const ForgotPasswordModel({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
