export 'regex_matcher.dart' hide RegexMatcher;

/// A shortcut to get [String] through [RegExp].
extension RegexMatcher on String {
  String? matchWith(String pattern) => RegExp(pattern).stringMatch(this);
}
