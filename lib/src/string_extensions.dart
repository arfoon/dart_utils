import 'package:dart_utils/src/utils.dart';
import 'package:path/path.dart' as path;

extension StringExtension on String {
  String get cleanupWhitespace => this.replaceAll(RegExp(r"\s+"), " ");
  bool get isHttps => startsWith('https://');
  bool get isHttp => startsWith('http://');
  bool get qSearchedBalance {
    if (isEmpty) return false;
    var sd = SearchData(q: this);
    if (sd.showBalance) return true;
    return false;
  }

  bool get canShowSearchBalance {
    if (isEmpty) return true;
    var sd = SearchData(q: this);
    if (sd.showBalance) return true;

    return false;
  }

  bool get isEnglishWord {
    var s = this;
    s = s.replaceAll(' ', '');
    s = s.replaceAll('-', '');
    if (s.isEmpty) return true;

    var paFaWords = '''ض
    ۱
    ۲
    ۳
    ۴
    ۵
    ۶
    ۷
    ۸
    ۹
    ۰
    ص
    ث
    ق
    ف
    غ
    ع
    ه
    خ
    ح
    ج
    چ
    ي
    ګ
    ک
    م
    ن
    ت
    ا
    ل
    ب
    ی
    س
    ش
    ې
    ط
    ز
    ر
    أ
    د
    ړ
    و
    ږ
    ځ
    څ
    ى
    گ
    ك
    ة
    ڼ
    ټ
    آ
    إ
    پ
    ۍ
    ے
    ښ
    ؟
    ؤ
    ډ
    ذ
    ٱ
    ء
    ژ
    ظ
    ئ'''
        .replaceAll(' ', '')
        .replaceAll('\n', '_');

    // paFaWords = paFaWords.replaceAll(" ", "").replaceAll("\n", "_");

    // print(paFaWords);

    var rgx = '[$paFaWords]'; // "[a-zA-Z_0-9_._?_!_,_:_'_-___\"]+\$";
    var regExp = RegExp(rgx);
    return !regExp.hasMatch(s);
  }

  String get lessZero {
    return length > 1 ? this : '0${toString()}';
  }

  int? get toInt {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  double? get toDouble {
    try {
      return double.parse(removeComma);
    } catch (e) {
      return null;
    }
  }

  double? get toDoubleZeroNull {
    try {
      final d = double.parse(removeComma);
      if (d == 0) {
        return null;
      }
      return d;
    } catch (e) {
      return null;
    }
  }

  double? get toDouble01Null {
    try {
      final d = double.parse(removeComma);
      if (d == 0 || d == 1) {
        return null;
      }
      return d;
    } catch (e) {
      return null;
    }
  }

  double get toDoubleOrZero {
    try {
      return double.parse(removeComma);
    } catch (e) {
      return 0;
    }
  }

  bool isSame(value) {
    return toLowerCase() == value.toString().toLowerCase();
  }

  bool isIn(List<dynamic> list) {
    for (var i in list) {
      if (i.toString().isSame(this)) return true;
    }
    return false;
  }

  bool get isNumber {
    return isIn([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
  }

  bool get isInt {
    try {
      final _ = int.parse(trim());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isDouble {
    try {
      final _ = double.parse(trim());
      return true;
    } catch (e) {
      return false;
    }
  }

  String get searchParam => replaceAll('%20', ' ').trim();

  DateTime? get dayMonthYearDateTime {
    if (isEmpty || !contains('/')) return null;
    final split = this.split('/');
    return DateTime(split[2].toInt!, split[1].toInt!, split[0].toInt!);
  }

  String writeOver({
    required int length,
    String t = '.',
  }) {
    var s = this;
    if (s.length > length) return s + t + t + t;

    while (s.length < length) {
      s = s + t;
    }
    return s;
  }

  String get enumName {
    var n = split('.').last;
    return n.replaceFirst(n[0], n[0].toUpperCase());
  }

  String get enumWord {
    final pascalWords = RegExp(r'(?:[A-Z]|[0-9]+|^)[a-z]*');
    return pascalWords
        .allMatches(enumName)
        .map((m) => m[0])
        .toList()
        .fold('', (previousValue, element) => '$previousValue $element')
        .toString()
        .trim();
  }

  List<String> get splitPath => path.split(this);
  String joinPathWith(String part2) => path.join(this, part2);

  bool get isUrl => startsWith('https://');
  String get englishToArabicNumbers {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var input = this;
    for (var i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  String get arabicEnglishToNumbers {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var input = this;
    for (var i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    return input;
  }

  String get removeStorage => replaceAll('/storage/emulated/0/', '');

  String get removeComma => replaceAll(',', '');
  bool get hasDot => contains('.');
  bool get isLastDot => isNotEmpty && this[length - 1] == '.';

  String get commaAmount {
    if (this == 'null') return '';

    if (isLastDot) return toString();

    final fmt = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: contains('.') ? split('.').last.length : 0,
    );

    try {
      final s = removeComma;
      final v = s.hasDot ? double.parse(s) : int.tryParse(s);
      final res = fmt.format(v);
      return res;
    } catch (e) {
      return this;
    }
  }

  int get noOfDots => split('').where((e) => e == '.').length;
  int get noOfCommas => split('').where((e) => e == ',').length;
  int noOfChar(String char) => split('').where((e) => e == char).length;

  bool get hasExt => ext.isIn([
        'db',
        'sqlite',
        'pdf',
        'png',
        'jpg',
        'jpeg',
        'xlsx',
        'xlx',
        'json',
        'txt',
      ]);

  String get ext => split('.').last;
  String get dotExt => '.' + split('.').last;
  String get removeExt => replaceAll('.' + ext, '');
  String get getFileFolder {
    var ns = hasExt ? removeExt.replaceAll(removeExt.splitPath.last, '') : this;
    return ns;
  }

  String get firstAndLastChar {
    if (trim().isEmpty) return '';

    var s = this[0];

    if (trim().contains(' ')) {
      final list = trim().split(' ');
      s += list.last[0];
    }

    s = s.toUpperCase();

    if (!s.isEnglishWord) {
      return s.length > 1 ? '${s[0]} ${s[1]}' : s;
    }

    return s;
  }

  String get enterToSpace {
    return trim().replaceAll('\n', ' ').trim();
  }

  bool get isErrorUnique {
    return contains('UNIQUE constraint failed:');
  }

  List<int> listIntegers() {
    var s = this;
    if (s.isEmpty) return [];

    if (s.contains(']') || s.contains('[')) {
      s = s.substring(1, s.length - 1);
    }
    var list = s.split(',').map((e) => e.toInt).toList();
    list.removeWhere((element) => element == null);
    return list.map((e) => e!).toList();
  }
}

extension StringListExt on List<String?> {
  String joinWith(String between) {
    var res = '';
    var list = where((element) => element != null).map((e) => e!).toList();

    for (var i = 0; i < list.length; i++) {
      if (i == 0 || i == list.length) {
        res += list[i];
      } else {
        res += between;
        res += list[i];
      }
    }
    return res;
  }
}
