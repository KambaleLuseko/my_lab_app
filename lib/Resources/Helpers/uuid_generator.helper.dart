class UUidHelper {
  static uuidGenerator({String? prefix}) {
    return "${prefix != null && prefix.isNotEmpty ? prefix : ''}${DateTime.now().microsecondsSinceEpoch.toRadixString(16).toUpperCase()}";
    // return utf8
    //     .encode(
    //         "${DateTime.now().toString().replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "").replaceAll(".", "")}-${navKey.currentContext!.read<UserProvider>().userLogged?.user.id}")
    //     .map((e) => e.toRadixString(16))
    //     .join('');
  }

  static String charHider({
    required int displayedChar,
    required String text,
    int? padLeft,
  }) {
    if (displayedChar >= text.length) return text;
    String result = "";
    if (padLeft != null && padLeft > 0) {
      result += ('*' * padLeft).toString();
    }
    for (var i = 0; i < text.length; i++) {
      if (i < text.length - displayedChar) {
        result += '*';
      } else {
        result += text[i];
      }
    }

    return result.padLeft(padLeft ?? 0, '*');
  }
}
