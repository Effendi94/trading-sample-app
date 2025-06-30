class PortfolioModel {
  String? name;
  String? base;
  double? amount;
  String? logo;

  PortfolioModel({this.name, this.base, this.amount, this.logo});

  PortfolioModel copyWith({String? name, String? base, double? amount, String? logo}) {
    return PortfolioModel(
      name: name ?? this.name,
      base: base ?? this.base,
      amount: amount ?? this.amount,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'base': base, 'amount': amount, 'logo': logo};
  }
}
