import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_status.dart';
import 'package:bio_app_pontos/src/pages/dashboard/pontos/widgets/itens_promocoes_widget.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/animated_pontos.dart';
import 'package:bio_app_pontos/src/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PontosWidget extends StatefulWidget {
  PontosWidget({Key? key}) : super(key: key);

  @override
  State<PontosWidget> createState() => _PontosWidgetState();
}

class _PontosWidgetState extends State<PontosWidget> {
  final controller = GlobalSettings().pontosPromocoesController;

  Future<void> inicializar() async {
    await controller.carregaDados();
  }

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text('Meus Pontos',
                      style: AppTheme.textStyles.titleContainers),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppTheme.colors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: AppTheme.colors.primary,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Observer(builder: (context) {
                          return controller.status ==
                                  PontosPromocoesStatus.success
                              ? AnimatedCountText(
                                  begin: 0,
                                  end: 7520,
                                  style: AppTheme.textStyles.titlePontos,
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.decelerate,
                                )
                              : LoadingWidget(size: Size(200, 50), radius: 10);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Promoções do dia',
                      style: AppTheme.textStyles.titleContainers),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppTheme.colors.backgroundPrimary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: AppTheme.colors.primary,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                ...controller.promocoes.map(
                                  (e) => ItensPromocoesWidget(
                                    path_image: e.path_image,
                                    nome_merc: e.descricao,
                                    preco: e.preco,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
