class SelectedFlight {
  final int id;
  int? companyId;
  final String from;
  final String fromCode;
  final String to;
  final String toCode;
  final String depTime;
  final String landingTime;
  final String depDate;
  final String numPpl;
  final String companyName;
  final String cClass;
  final int price;

  SelectedFlight({
    required this.id,
    required this.from,
    required this.fromCode,
    required this.to,
    required this.toCode,
    required this.depTime,
    required this.landingTime,
    required this.depDate,
    required this.numPpl,
    required this.companyName,
    required this.cClass,
    required this.price,
  });

  static SelectedFlight resetFlight() {
    return SelectedFlight(
        id: -1,
        from: "Null",
        fromCode: "Null",
        to: "Null",
        toCode: "Null",
        depTime: "00:00",
        landingTime: "00:01",
        depDate: "1970-01-01",
        numPpl: "3",
        companyName: "Null",
        cClass: "Null",
        price: 0);
  }
}
