class UserInfo {
  final String email;

  const UserInfo({this.email = ""});

  bool get isLoggedIn {
    return email != "";
  }

  @override
  String toString() {
    return "$email -> isLoggedIn: $isLoggedIn";
  }
}
