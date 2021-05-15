class User {
  final name;
  final phone_no;

  final referral_code;
  final download_counts;

  User({this.name, this.phone_no, this.download_counts, this.referral_code});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone_no = json['phone_no'],
        download_counts = json['download_counts'],
        referral_code = json['referral_code'];
}

class Authenticate {
  final String token;
  final User user;

  Authenticate(this.token, this.user);

  Authenticate.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']);
}

class AuthResponse {
  final Authenticate results;
  final String error;

  AuthResponse(this.results, this.error);

  AuthResponse.fromJson(Map<String, dynamic> json)
      : results = new Authenticate.fromJson(json),
        error = "";

  AuthResponse.withError(String errorValue)
      : results = null,
        error = errorValue;
}
