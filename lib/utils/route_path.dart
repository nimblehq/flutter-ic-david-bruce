enum RoutePath {
  login('/'),
  home('home'),
  forgotPassword('forgot-password');

  final String path;

  const RoutePath(this.path);
}
