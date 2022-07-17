String? regexMatcher(String text, String pattern) =>
    RegExp(pattern).stringMatch(text);

extension RegexMatcher on String {
  String? matchWith(String pattern) => regexMatcher(this, pattern);
}
