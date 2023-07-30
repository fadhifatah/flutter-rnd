extension CreateTitleCase on String {
  String get asTitleCase => split(' ').map((e) => e.capitalize).join(' ');
}

extension CreateCapitalize on String {
  String get capitalize =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
