extension DoubleExtensions on double {
  String fixPoints(int decimals) {
    if (this == 0) return '0';
    final fixed = toStringAsFixed(decimals);
    final points = fixed.split('.').last;
    for (var i = 0; i < points.length; i++) {
      var p = points[(points.length - 1) - i];
      if (p != '0') {
        var digits = decimals - i;
        return toStringAsFixed(digits);
      }
    }

    return toStringAsFixed(0);
  }

  String get fix2Points {
    return fixPoints(2);
  }

  String get fix4Points {
    return fixPoints(4);
  }

  String get fix6Points {
    return fixPoints(6);
  }

  String get fix8Points {
    return fixPoints(8);
  }

  String get fix10Points {
    return fixPoints(10);
  }

  String get fix4PointsZeroEmpty {
    if (fix4Points == '0') return '';
    return fix4Points;
  }

  String get fix2PointsZeroEmpty {
    if (fix2Points == '0') return '';
    return fix2Points;
  }

  String get stringEmpty => this == 0 ? '' : toString();

  double get toNegative {
    if (isNegative) {
      return this;
    }

    return double.parse('-${this}');
  }

  double get inverse {
    if (isNegative) {
      return abs();
    }

    return toNegative;
  }

  bool get isOk {
    return !isNaN && !isInfinite;
  }
}
