enum RoutePath {
  login('/login'),
  home('/home'),
  forgotPassword('/forgot-password'),
  surveyDetails('/survey-details'),
  surveyQuestion('/survey-question');

  final String path;
  const RoutePath(this.path);

  String get screen {
    switch (this) {
      case RoutePath.home:
      case RoutePath.login:
      case RoutePath.forgotPassword:
        return path;
      default:
        return path.replaceRange(0, 1, '');
    }
  }

  String get pathParam {
    switch (this) {
      case RoutePath.surveyDetails:
        return 'surveyId';
      case RoutePath.surveyQuestion:
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
      case RoutePath.surveyQuestion:
        return "SURVEY_QUESTION";
    }
  }

  List<String> get queryParams {
    switch (this) {
      case RoutePath.surveyQuestion:
        return ['questionNumber'];
      default:
        return [''];
    }
  }

  String get screenWithPathParams {
    return pathParam.isEmpty ? screen : '$screen/:$pathParam';
  }
}
