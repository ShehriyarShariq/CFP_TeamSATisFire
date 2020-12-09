class Utils {
  static String getFirstLetterOfWordsCapped(String str) {
    return str
        .split(" ")
        .map((element) =>
            element.toLowerCase().replaceRange(0, 1, element[0].toUpperCase()))
        .join(" ");
  }
}
