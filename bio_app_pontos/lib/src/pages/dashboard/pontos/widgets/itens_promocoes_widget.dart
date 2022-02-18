import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItensPromocoesWidget extends StatefulWidget {
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
  State<ItensPromocoesWidget> createState() => _ItensPromocoesWidgetState();
}

class _ItensPromocoesWidgetState extends State<ItensPromocoesWidget> {
  final controller = GlobalSettings().pontosPromocoesController;

  dynamic retornaTamanhoWidth() {
    if (context.screenWidth >= 392 && controller.promocoes.length > 1) {
      return 130.0;
    } else {
      return null;
    }
  }

  dynamic retornaTamanhoWidthImagemNaoEncontrada() {
    if (context.screenWidth >= 392 && controller.promocoes.length > 1) {
      return 95.0;
    } else {
      return null;
    }
  }

  dynamic retornaTamanhoHeight() {
    if (context.screenWidth >= 392 && controller.promocoes.length > 1) {
      return 140.0;
    } else {
      return null;
    }
  }

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
            imageUrl: widget.path_image,
            placeholder: (context, url) => Container(
              width: retornaTamanhoWidth(),
              height: retornaTamanhoHeight(),
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
                  width: retornaTamanhoWidthImagemNaoEncontrada(),
                  child: Text(
                    'Não foi possivel carregar a imagem...',
                    style: AppTheme.textStyles.titleImageNaoEncontrada,
                  ),
                ),
              ],
            ),
            width: retornaTamanhoWidth(),
            height: retornaTamanhoHeight(),
          ),
          Container(
            width: retornaTamanhoWidth(),
            child: Text(
              widget.nome_merc,
              style: AppTheme.textStyles.titleImages,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            widget.preco.reais(),
            style: AppTheme.textStyles.titleImages,
          ),
        ],
      ),
    );
  }
}
