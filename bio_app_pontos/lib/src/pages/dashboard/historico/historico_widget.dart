import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/historico/historico_status.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:bio_app_pontos/src/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HistorioWidget extends StatefulWidget {
  const HistorioWidget({Key? key}) : super(key: key);

  @override
  State<HistorioWidget> createState() => _HistorioWidgetState();
}

class _HistorioWidgetState extends State<HistorioWidget> {
  final controller = GlobalSettings().historicoController;

  Future<void> inicializar() async {
    await controller.carregaHistorico();
  }

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Text(
            'Histórico de Compra',
            style: AppTheme.textStyles.title.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Observer(builder: (_) {
            return controller.status == HistoricoStatus.success
                ? Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, int index) {
                        return ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Data',
                                    style: AppTheme.textStyles.title.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('14/02/2022'),
                                ],
                              ),
                              Text(
                                'R\$ 150,00',
                                style: AppTheme.textStyles.title.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Mercadoria',
                                    style: AppTheme.textStyles.title.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Vlr Unitário',
                                    textAlign: TextAlign.end,
                                    style: AppTheme.textStyles.title.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Quantidade',
                                    textAlign: TextAlign.end,
                                    style: AppTheme.textStyles.title.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...controller.itens_venda.map((e) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                        controller.itens_venda[index].merc),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.itens_venda[index].vlrUni
                                          .reais(),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.itens_venda[index].qtd
                                              .toString() +
                                          ' L',
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 15),
                      itemCount: 10,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                        itemBuilder: (_, __) =>
                            LoadingWidget(size: Size(0, 50), radius: 10),
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemCount: 10),
                  );
          })
        ],
      ),
    );
  }
}
