import 'dart:io';

import 'package:bio_app_pontos/src/utils/constants.dart';

class CheckInternetService {
  Future<bool> haveInternet() async {
    try {
      final result = await InternetAddress.lookup(Constants.baseUrlGoogle);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
