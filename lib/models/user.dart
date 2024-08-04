class User {
  late String id;
  late String name;
  late String username;
  late String email;
  late String token;
  late String image;
  late int tokenExpiresAt;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
    image = json['image'];
    tokenExpiresAt = json['token_expires_at'];
  }
}
