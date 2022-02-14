import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:flutter/material.dart';

class ItensPromocoesWidget extends StatelessWidget {
  final String path_image;
  final String nome_merc;
  final double preco;
  const ItensPromocoesWidget(
      {Key? key,
      required this.path_image,
      required this.nome_merc,
      required this.preco})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Image.asset(
              path_image,
            ),
          ),
          Text(
            nome_merc,
            style: AppTheme.textStyles.dropdownText,
          ),
          Text(
            preco.reais(),
            style: AppTheme.textStyles.dropdownText,
          ),
        ],
      ),
    );
  }
}
