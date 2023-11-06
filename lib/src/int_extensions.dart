extension IntExtensions on int {
  String withZeros({bool withZeros = true, int zeros = 5}) {
    var id = this;
    if (!withZeros) return '$id';

    var zt = id.toString();
    while ((zt.length) < zeros) {
      zt = '0' + zt;
    }
    return '$zt';
  }

  String get with5Zero {
    return withZeros(zeros: 5);
  }

  String get with1Zero {
    if (this < 10 && this > -1) {
      return '0${toString()}';
    }
    return toString();
  }

  bool equalsBeteen(int value, int between) {
    var b = value == this;
    if (!b) {
      b = value >= this && value <= (this + between);
    }
    if (!b) {
      b = this >= value && this <= (value + between);
    }

    return b;
  }

  int? get last2CharWhenMorethen100 {
    if (this < 100) return this;
    var s = this.toString();
    var id = int.tryParse(s.substring(s.length - 2, s.length)) ?? 0;
    return id;
  }
}
