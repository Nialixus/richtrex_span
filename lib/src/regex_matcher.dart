extension RegexMatcher on String {
  String? matchWith(String pattern) => RegExp(pattern).stringMatch(this);
}
