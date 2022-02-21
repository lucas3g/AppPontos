import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Sair do App'),
        ),
      ),
    );
  }
}
