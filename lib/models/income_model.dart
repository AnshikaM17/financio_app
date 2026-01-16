enum IncomeRange {
  low,
  medium,
  high,
}

class IncomeModel {
  final IncomeRange range;
  final String translationKey;

  IncomeModel({
    required this.range,
    required this.translationKey,
  });

  static List<IncomeModel> getIncomeRanges() {
    return [
      IncomeModel(
        range: IncomeRange.low,
        translationKey: 'income_low',
      ),
      IncomeModel(
        range: IncomeRange.medium,
        translationKey: 'income_medium',
      ),
      IncomeModel(
        range: IncomeRange.high,
        translationKey: 'income_high',
      ),
    ];
  }
}
