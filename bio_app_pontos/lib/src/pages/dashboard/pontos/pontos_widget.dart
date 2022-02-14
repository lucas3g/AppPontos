import 'package:bio_app_pontos/src/pages/dashboard/pontos/widgets/itens_promocoes_widget.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';

class PontosWidget extends StatelessWidget {
  const PontosWidget({Key? key}) : super(key: key);

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
                  Container(
                    padding: EdgeInsets.all(10),
                    height: context.screenHeight * 0.15,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppTheme.colors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: AppTheme.colors.primary,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Meus Pontos',
                          style: AppTheme.textStyles.titleLogin.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '2.750',
                          style: AppTheme.textStyles.titleLogin,
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Promoções do dia',
                    style: AppTheme.textStyles.titleLogin.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppTheme.colors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: AppTheme.colors.primary,
                          )
                        ],
                      ),
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          ItensPromocoesWidget(
                            path_image: 'assets/images/coca.jpg',
                            nome_merc: 'Coca-Cola',
                            preco: 4.75,
                          ),
                          ItensPromocoesWidget(
                            path_image: 'assets/images/mm.png',
                            nome_merc: 'Chocolate',
                            preco: 2.50,
                          ),
                          ItensPromocoesWidget(
                            path_image: 'assets/images/coca.jpg',
                            nome_merc: 'Coca-Cola',
                            preco: 4.75,
                          ),
                          ItensPromocoesWidget(
                            path_image: 'assets/images/mm.png',
                            nome_merc: 'Chocolate',
                            preco: 2.50,
                          ),
                          ItensPromocoesWidget(
                            path_image: 'assets/images/coca.jpg',
                            nome_merc: 'Coca-Cola',
                            preco: 4.75,
                          ),
                          ItensPromocoesWidget(
                            path_image: 'assets/images/mm.png',
                            nome_merc: 'Chocolate',
                            preco: 2.50,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
