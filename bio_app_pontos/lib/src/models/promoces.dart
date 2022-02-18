import 'dart:convert';

class PromocoesModel {
  final String descricao;
  final String path_image;
  final double quantidade;
  final double preco;
  PromocoesModel({
    required this.descricao,
    required this.path_image,
    required this.quantidade,
    required this.preco,
  });

  PromocoesModel copyWith({
    String? descricao,
    String? path_image,
    double? quantidade,
    double? preco,
  }) {
    return PromocoesModel(
      descricao: descricao ?? this.descricao,
      path_image: path_image ?? this.path_image,
      quantidade: quantidade ?? this.quantidade,
      preco: preco ?? this.preco,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'path_image': path_image,
      'quantidade': quantidade,
      'preco': preco,
    };
  }

  factory PromocoesModel.fromMap(Map<String, dynamic> map) {
    return PromocoesModel(
      descricao: map['descricao'] ?? '',
      path_image: map['path_image'] ?? '',
      quantidade: map['quantidade']?.toDouble() ?? 0.0,
      preco: map['preco']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromocoesModel.fromJson(String source) =>
      PromocoesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromocoesModel(descricao: $descricao, path_image: $path_image, quantidade: $quantidade, preco: $preco)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromocoesModel &&
        other.descricao == descricao &&
        other.path_image == path_image &&
        other.quantidade == quantidade &&
        other.preco == preco;
  }

  @override
  int get hashCode {
    return descricao.hashCode ^
        path_image.hashCode ^
        quantidade.hashCode ^
        preco.hashCode;
  }
}
