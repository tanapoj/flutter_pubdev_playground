class NameRunner {
  String _next;

  NameRunner([String startAt = 'A']) : _next = startAt;

  String _run(String s) {
    if (s.isEmpty) return 'A';
    if ('Z'.codeUnitAt(0) == s.runes.last) {
      String ss = _run(s.substring(0, s.length - 1));
      s = '$ss${String.fromCharCode(65 - 1)}';
    }
    s = '${s.substring(0, s.length - 1)}${String.fromCharCode(s.runes.last + 1)}';
    return s;
  }

  String next() {
    String r = _next;
    _next = _run(_next);
    return r;
  }
}
