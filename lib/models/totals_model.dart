class TotalsModel {
  final int totalPaied;
  final int totalPeceived;
  const TotalsModel({
    required this.totalPaied,
    required this.totalPeceived,
  });

  factory TotalsModel.fromJson(Map<String, dynamic> map) {
    return TotalsModel(
      totalPaied: map['total_paied'].toInt(),
      totalPeceived: map['total_received'].toInt(),
    );
  }
}
