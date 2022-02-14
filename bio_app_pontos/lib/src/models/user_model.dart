import 'dart:convert';

class UserModel {
  final String? nome;
  final String? email;
  final String? senha;
  final String? cpf;
  final String? celular;
  final String? placa;
  final String? uf;
  final String? municipio;
  final String? rua;
  final String? numero;
  final String? bairro;
  final String? complemento;
  final String? cep;

  UserModel({
    this.nome,
    this.email,
    this.senha,
    this.cpf,
    this.celular,
    this.placa,
    this.uf,
    this.municipio,
    this.rua,
    this.numero,
    this.bairro,
    this.complemento,
    this.cep,
  });

  UserModel copyWith({
    String? nome,
    String? email,
    String? senha,
    String? cpf,
    String? celular,
    String? placa,
    String? uf,
    String? municipio,
    String? rua,
    String? numero,
    String? bairro,
    String? complemento,
    String? cep,
  }) {
    return UserModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      cpf: cpf ?? this.cpf,
      celular: celular ?? this.celular,
      placa: placa ?? this.placa,
      uf: uf ?? this.uf,
      municipio: municipio ?? this.municipio,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      complemento: complemento ?? this.complemento,
      cep: cep ?? this.cep,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'cpf': cpf,
      'celular': celular,
      'placa': placa,
      'uf': uf,
      'municipio': municipio,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'cep': cep,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      cpf: map['cpf'],
      celular: map['celular'],
      placa: map['placa'],
      uf: map['uf'],
      municipio: map['municipio'],
      rua: map['rua'],
      numero: map['numero'],
      bairro: map['bairro'],
      complemento: map['complemento'],
      cep: map['cep'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, senha: $senha, cpf: $cpf, celular: $celular, placa: $placa, uf: $uf, municipio: $municipio, rua: $rua, numero: $numero, bairro: $bairro, complemento: $complemento, cep: $cep)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.nome == nome &&
        other.email == email &&
        other.senha == senha &&
        other.cpf == cpf &&
        other.celular == celular &&
        other.placa == placa &&
        other.uf == uf &&
        other.municipio == municipio &&
        other.rua == rua &&
        other.numero == numero &&
        other.bairro == bairro &&
        other.complemento == complemento &&
        other.cep == cep;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        email.hashCode ^
        senha.hashCode ^
        cpf.hashCode ^
        celular.hashCode ^
        placa.hashCode ^
        uf.hashCode ^
        municipio.hashCode ^
        rua.hashCode ^
        numero.hashCode ^
        bairro.hashCode ^
        complemento.hashCode ^
        cep.hashCode;
  }
}
