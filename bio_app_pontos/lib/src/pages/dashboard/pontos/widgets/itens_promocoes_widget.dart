import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      margin: EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: path_image,
            maxWidthDiskCache: 130,
            placeholder: (context, url) => Container(
              width: context.screenWidth >= 392 ? 130 : null,
              height: context.screenWidth >= 392 ? 140 : null,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.colors.primary,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, color: Colors.red, size: 20),
                SizedBox(width: 15),
                Container(
                  width: context.screenWidth >= 392 ? 95 : null,
                  child: Text(
                    'Não foi possivel carregar a imagem...',
                    style: AppTheme.textStyles.titleImageNaoEncontrada,
                  ),
                ),
              ],
            ),
            width: context.screenWidth >= 392 ? 130 : null,
            height: context.screenWidth >= 392 ? 140 : null,
          ),
          Container(
            width: 130,
            child: Text(
              nome_merc,
              style: AppTheme.textStyles.titleImages,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            preco.reais(),
            style: AppTheme.textStyles.titleImages,
          ),
        ],
      ),
    );
  }
}
