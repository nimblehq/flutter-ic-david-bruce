enum DisplayType {
  star,
  heart,
  smiley,
  choice,
  nps,
  textarea,
  textfield,
  intro,
  outro,
  dropdown,
  unknown;

  bool get inputRequired {
    switch (this) {
      case DisplayType.textfield:
      case DisplayType.textarea:
        return true;
      default:
        return false;
    }
  }

  static DisplayType fromString(String value) {
    switch (value) {
      case 'star':
        return DisplayType.star;
      case 'heart':
        return DisplayType.heart;
      case 'smiley':
        return DisplayType.smiley;
      case 'choice':
        return DisplayType.choice;
      case 'nps':
        return DisplayType.nps;
      case 'textarea':
        return DisplayType.textarea;
      case 'textfield':
        return DisplayType.textfield;
      case 'intro':
        return DisplayType.intro;
      case 'outro':
        return DisplayType.outro;
      case 'dropdown':
        return DisplayType.dropdown;
      default:
        return DisplayType.unknown;
    }
  }
}
