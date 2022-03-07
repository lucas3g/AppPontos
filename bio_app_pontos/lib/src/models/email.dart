import 'dart:convert';

class EmailJson {
  String? r_nome;
  EmailJson({
    this.r_nome,
  });

  EmailJson copyWith({
    String? r_nome,
  }) {
    return EmailJson(
      r_nome: r_nome ?? this.r_nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'r_nome': r_nome,
    };
  }

  factory EmailJson.fromMap(Map<String, dynamic> map) {
    return EmailJson(
      r_nome: map['r_nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailJson.fromJson(String source) =>
      EmailJson.fromMap(json.decode(source));

  @override
  String toString() => 'EmailJson(r_nome: $r_nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailJson && other.r_nome == r_nome;
  }

  @override
  int get hashCode => r_nome.hashCode;
}
