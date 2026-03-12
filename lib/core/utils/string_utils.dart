class StringUtils {
  static String keepAll(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word.split('').join('\u200D');
    }).join(' ');
  }
}
