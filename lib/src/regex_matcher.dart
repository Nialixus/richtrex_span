export 'regex_matcher.dart' hide RegexMatcher;

extension RegexMatcher on String {
  String? matchWith(String pattern) => RegExp(pattern).stringMatch(this);
}
