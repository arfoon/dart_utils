extension ListExtensions on List<dynamic> {
  // Response get okResponse => json.ok(data: this);
  bool get moreThenOne => length > 1;

  List filterOf<T>(List<int> options) =>
      where((e) => options.contains(e.index)).toList();

  vlaue(int i) {
    if (i > (length - 1)) return null;
    return this[i];
  }

  bool equals(List list, {int? length}) {
    if ((length ?? list.length) != this.length) return false;

    var b = false;
    if (list.isNotEmpty) {
      b = true;
    }
    for (int i = 0; i < list.length; i++) {
      if (this.vlaue(i) != list.vlaue(i)) {
        b = false;
      }
    }
    return b;
  }
}
