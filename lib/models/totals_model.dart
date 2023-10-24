class Totals {
  final int totalPaied;
  final int totalPeceived;
  const Totals({
    required this.totalPaied,
    required this.totalPeceived,
  });

  factory Totals.fromJson(Map<String, dynamic> map) {
    return Totals(
      totalPaied: map['total_paied'].toInt(),
      totalPeceived: map['total_received'].toInt(),
    );
  }
}
