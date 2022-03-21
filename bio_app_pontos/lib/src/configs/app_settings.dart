import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:bio_app_pontos/src/utils/limpa_dados.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;

  Map<String, String> logado = {'conectado': 'N'};
  late String? ultimaSinc;
  UserModel user = UserModel();

  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLogado();
    await setUltimaSincronizacao();
    if (_prefs.getString('conectado') == 'S') await _readUser();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLogado() {
    final logadoApp = _prefs.getString('conectado') ?? 'N';

    logado = {'conectado': logadoApp};

    notifyListeners();
  }

  _readUser() {
    final userApp = _prefs.getString('user') ?? '';

    user = UserModel.fromJson(userApp);

    notifyListeners();
  }

  setLogado({required String conectado}) async {
    await _prefs.setString('conectado', conectado);

    await _readLogado();
  }

  setUser({required UserModel user}) async {
    await _prefs.setString('user', user.toJson());

    await _readUser();

    notifyListeners();
  }

  setUltimaSincronizacao() async {
    await _prefs.setString('sinc', DateTime.now().DiaMesAnoHora());

    readUltimaSincronizacao();

    notifyListeners();
  }

  readUltimaSincronizacao() {
    ultimaSinc = _prefs.getString('sinc')!;

    notifyListeners();
  }

  removeLogado() async {
    final controller = LimpaDados();
    await _prefs.remove('conectado');
    await _prefs.remove('user');
    await _prefs.remove('impressora');
    setLogado(conectado: 'N');
    controller.limpaDados();
    await _readLogado();
  }

  removeImpressora() async {
    await _prefs.remove('impressora');
  }
}
