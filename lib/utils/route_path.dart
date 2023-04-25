enum RoutePath {
  login('/login'),
  home('/home'),
  forgotPassword('/forgot-password');

  final String path;
  const RoutePath(this.path);

  String get screen {
    switch (this) {
      case RoutePath.home:
      case RoutePath.login:
      case RoutePath.forgotPassword:
        return path;
    }
  }

  String get name {
    switch (this) {
      case RoutePath.login:
        return "LOGIN";
      case RoutePath.home:
        return "HOME";
      case RoutePath.forgotPassword:
        return "FORGOT_PASSWORD";
    }
  }
}
