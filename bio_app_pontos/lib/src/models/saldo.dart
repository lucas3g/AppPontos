import 'dart:convert';

class SaldoModel {
  late double? saldo;
  SaldoModel({
    this.saldo,
  });

  SaldoModel copyWith({
    double? saldo,
  }) {
    return SaldoModel(
      saldo: saldo ?? this.saldo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saldo': saldo,
    };
  }

  factory SaldoModel.fromMap(Map<String, dynamic> map) {
    return SaldoModel(
      saldo: map['saldo']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaldoModel.fromJson(String source) =>
      SaldoModel.fromMap(json.decode(source));

  @override
  String toString() => 'SaldoModel(saldo: $saldo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaldoModel && other.saldo == saldo;
  }

  @override
  int get hashCode => saldo.hashCode;
}
