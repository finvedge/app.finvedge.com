import '../models/user.dart';

class UserResponse {
  late User user;
  late String? token;

  UserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJson(json['user']);
  }
}
