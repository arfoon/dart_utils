
import 'utils.dart';

class SearchData {
  final String q;
  const SearchData({required this.q});

  bool get showBalance {
    if (hasBiggerThenValue) return true;
    if (hasBiggerThenEqualToValue) return true;
    if (hasSmallerThenValue) return true;
    if (hasSmallerThenEqualToValue) return true;
    return false;
  }

  //Getters
  bool get hasHyphenBetween => q.contains('-') && q.length > 3;

  bool get greaterThen => q.startsWith('>') && q.length > 1;
  double? get biggerThenValue => q.replaceAll('>', '').toDouble;
  bool get hasBiggerThenValue => greaterThen && biggerThenValue != null;

  bool get greaterThenEqualTo => q.startsWith('>=') && q.length > 2;
  double? get biggerThenEqualToValue => q.replaceAll('>=', '').toDouble;
  bool get hasBiggerThenEqualToValue =>
      greaterThenEqualTo && biggerThenEqualToValue != null;

  bool get lessThen => q.startsWith('<') && q.length > 1;
  double? get smallerThenValue => q.replaceAll('<', '').toDouble;
  bool get hasSmallerThenValue => lessThen && smallerThenValue != null;

  bool get lessThenEqualTo => q.startsWith('<=') && q.length > 2;
  double? get smallerThenEqualToValue => q.replaceAll('<=', '').toDouble;
  bool get hasSmallerThenEqualToValue =>
      lessThenEqualTo && smallerThenEqualToValue != null;

  bool get hasHash => q.startsWith('#') && q.length > 1;
  int? get hashValue => q.replaceAll('#', '').toInt;
  bool get hasHashAndValue => hasHash && hashValue != null;

  bool get hasPlus => q.startsWith('+') && q.length > 1;
  double? get plusValue => q.replaceAll('+', '').toDouble;
  bool get hasPlusAndValue => hasPlus && plusValue != null;

  bool get hasMinus => q.startsWith('-') && q.length > 1;
  double? get minusValue => q.replaceAll('-', '').toDouble;
  bool get hasMinusAndValue => hasMinus && minusValue != null;

  bool get startWithEqual => q.startsWith('=') && q.length > 1;
  int? get equalValueInt => q.replaceAll('=', '').toInt;
  String get equalValueString => q.replaceAll('=', '').trim();
  bool get hasEqualAndValue => startWithEqual && equalValueInt != null;

  bool get isCommaSaperatedNumbers =>
      q.contains(',') && commaSaperatedNumbers.isNotEmpty;
  List<int> get commaSaperatedNumbers => q
      .split(',')
      .map((e) => e.toInt)
      .where((element) => element != null)
      .map((e) => e!)
      .toList();

  int? get hyphenStartInt {
    if (!hasHyphenBetween) return null;
    return q.split('-').first.replaceAll('#', '').toInt;
  }

  int? get hyphenEndInt {
    if (!hasHyphenBetween) return null;
    return q.split('-').last.replaceAll('#', '').toInt;
  }

  bool get isSearchStartEnd {
    return hasHyphenBetween && hyphenStartInt != null && hyphenEndInt != null;
  }

  SearchData copyWith({String? q}) {
    return SearchData(q: q ?? this.q);
  }

  Map<String, dynamic> toMap() {
    return {'q': q};
  }

  factory SearchData.fromMap(Map<String, dynamic> map) {
    return SearchData(q: map['q']);
  }

  String toJson() => json.encode(toMap());

  factory SearchData.fromJson(String source) =>
      SearchData.fromMap(json.decode(source));

  @override
  String toString() => 'SearchData(q: $q)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchData && other.q == q;
  }

  @override
  int get hashCode => q.hashCode;
}
