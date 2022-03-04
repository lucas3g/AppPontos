import 'package:brasil_fields/brasil_fields.dart';

class CheckCPFService {
  bool validateCPF({required String cpf}) {
    return UtilBrasilFields.isCPFValido(cpf);
  }
}
