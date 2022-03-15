extension StringExtension on String {
  bool validateUrl() => Uri.parse(this).isAbsolute;

  //* replace https://// by https://
}
