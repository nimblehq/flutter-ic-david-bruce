enum EmoticonType {
  thumbsUp,
  smiley,
  heart,
  star;

  static const maximumRating = 5;

  List<String> get icons {
    switch (this) {
      case EmoticonType.thumbsUp:
        return List.generate(EmoticonType.maximumRating, (_) => '👍🏻');
      case EmoticonType.smiley:
        return ['😡', '😕', '😐', '🙂', '😄'];
      case EmoticonType.heart:
        return List.generate(EmoticonType.maximumRating, (_) => '❤️');
      case EmoticonType.star:
        return List.generate(EmoticonType.maximumRating, (_) => '⭐️');
    }
  }

  bool get isSingleHighlight {
    switch (this) {
      case EmoticonType.smiley:
        return true;
      default:
        return false;
    }
  }
}
