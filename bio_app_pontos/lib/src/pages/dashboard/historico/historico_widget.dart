import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:flutter/material.dart';

class Itens {
  final String merc;
  final double vlrUni;
  final double qtd;

  Itens({required this.merc, required this.vlrUni, required this.qtd});
}

class HistorioWidget extends StatefulWidget {
  const HistorioWidget({Key? key}) : super(key: key);

  @override
  State<HistorioWidget> createState() => _HistorioWidgetState();
}

class _HistorioWidgetState extends State<HistorioWidget> {
  late List<Itens> itens_venda = [];

  @override
  void initState() {
    super.initState();
    itens_venda.addAll(
      List.generate(
        10,
        (index) => Itens(
            merc: 'Gasolina Comum aaaaaaaaaaaaaaaaaa', vlrUni: 8, qtd: 10000),
      ),
    );
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
            style: AppTheme.textStyles.titleLogin.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
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
                            style: AppTheme.textStyles.titleLogin.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text('14/02/2022'),
                        ],
                      ),
                      Text(
                        'R\$ 150,00',
                        style: AppTheme.textStyles.titleLogin.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  children: [
                    Container(
                      height: 200,
                      child: ListView.separated(
                        itemBuilder: (_, int index) {
                          return GridView.count(
                            crossAxisCount: 3,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mercadoria',
                                    style:
                                        AppTheme.textStyles.titleLogin.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(itens_venda[index].merc),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Vlr Unitário',
                                    style:
                                        AppTheme.textStyles.titleLogin.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(itens_venda[index].vlrUni.reais()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Quantidade',
                                    style:
                                        AppTheme.textStyles.titleLogin.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                      itens_venda[index].qtd.toString() + ' L'),
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemCount: itens_venda.length,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 15),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
