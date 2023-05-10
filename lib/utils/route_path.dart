enum RoutePath {
  login('/login'),
  home('/home'),
  forgotPassword('/forgot-password'),
  surveyDetails('/survey-details');

  final String path;
  const RoutePath(this.path);

  String get screen {
    switch (this) {
      case RoutePath.home:
      case RoutePath.login:
      case RoutePath.forgotPassword:
      case RoutePath.surveyDetails:
        return path;
    }
  }

  String get pathParam {
    switch (this) {
      case RoutePath.surveyDetails:
        return 'surveyId';
      default:
        return '';
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
      case RoutePath.surveyDetails:
        return "SURVEY_DETAILS";
    }
  }

  String get screenWithPathParams {
    return pathParam.isEmpty ? screen : '$screen/:$pathParam';
  }
}
