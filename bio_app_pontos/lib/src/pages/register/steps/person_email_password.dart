import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/my_input_widget.dart';
import '../../../controllers/register/register_controller.dart';

class PersonEmailPasswordWidget extends StatefulWidget {
  final RegisterController controller;
  const PersonEmailPasswordWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PersonEmailPasswordWidget> createState() =>
      _PersonEmailPasswordWidgetState();
}

class _PersonEmailPasswordWidgetState extends State<PersonEmailPasswordWidget> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  late RegisterController controller;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  late bool visiblePassword = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controllerEmail.text = controller.user.email ?? '';
    controllerPassword.text = controller.user.senha ?? '';
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  openModalSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Termos e condição de uso',
                  style: AppTheme.textStyles.titleContainers,
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                text:
                                    "Bem-vindo ao aplicativo BioWahl: Cashback. Certifique-se de ter lido e entendido os “Termos e Condições de Uso” e a “Política de Privacidade”, em conjunto, denominados “Termos”, que constituem o contrato firmado entre a BIO ABASTECEDORA WAHL EIRELI - EPP ('BIOWAHL ABASTECEDORA'), inscrita no CNPJ/MF sob o no 20.754.224/0001-04, sediada na Cidade de Sarandi no Rio Grande do Sul, RUA JOAO TESSER, no 130, Bairro LOT FACCENDA, e o Usuário, conforme definido abaixo, após a manifestação do “Aceite”. O Aceite dos Termos é indispensável para a utilização do Aplicativo, o qual se encontra disponível para download gratuito na Apple App Store e no Google Play. Por meio do cadastramento gratuito como Usuário e/ou por meio da utilização do Aplicativo ou dos serviços disponibilizados no Aplicativo, o Usuário, independentemente da utilização ou não do Aplicativo e dos serviços disponibilizados, concorda e se compromete a cumprir todas as disposições e condições estabelecidas nestes Termos (“Aceite”).",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "A BIOWAHL ABASTECEDORA poderá realizar alterações e atualizações aos Termos, assim como alterar as funcionalidades do Aplicativo e os serviços prestados a qualquer momento. Se a BIOWAHL ABASTECEDORA fizer qualquer alteração substancial nestes Termos, publicará essas alterações e fará o possível para notificá-lo sobre tais alterações. Recomendamos que o Usuário reveja os Termos com frequência e salientamos que a utilização do Aplicativo e dos serviços, após quaisquer alterações dos Termos, importa em plena ciência e concordância do Usuário com todas as alterações.Caso o Usuário não concorde com as alterações, ou, se por qualquer motivo, o Usuário não desejar mais utilizar o Aplicativo, o Usuário deverá suspender a utilização dos serviços disponibilizados e desinstalar o Aplicativo de seu telefone celular do tipo smartphone."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Objeto',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "• Caso o Usuário não concorde com as alterações, ou, se por qualquer motivo, o Usuário não desejar mais utilizar o Aplicativo, o Usuário deverá suspender a utilização dos serviços disponibilizados e desinstalar o Aplicativo de seu telefone celular do tipo smartphone."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por meio dessa plataforma, a BIOWAHL ABASTECEDORA também permite que Usuários localizem Postos. Também permite a identificação do posto como meio de gerar desconto na aquisição de combustível e produtos pelo aplicativo."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  É indispensável a utilização e funcionamento do Aplicativo que o Usuário possua um telefone celular do tipo smartphone, com sistema operacional compatível com a solução é dotado de acesso a Internet, com tecnologia 3G ou 4G."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Cadastro do Usuário',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Os Usuários que desejam utilizar o Aplicativo devem preencher todos os campos das “telas” de cadastro do Aplicativo com informações válidas e corretas. Para o cadastro como “Usuário” é necessário ser residente no Brasil, possuir cadastro ativo junto à Receita Federal do Brasil (Cadastro de Pessoa Física – CPF)."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  As informações fornecidas durante o cadastro são de exclusiva responsabilidade de quem as inseriu, de modo que a BIOWAHL ABASTECEDORA não se responsabiliza por quaisquer erros do Usuário eventualmente cometidos em seu cadastramento. O Usuário isenta a BIOWAHL ABASTECEDORA de quaisquer responsabilidades decorrentes de erro, imprecisão ou não veracidade dos dados pessoais e demais informações fornecidas durante a realização de seu cadastro e uso do Aplicativo, bem como por qualquer violação a direitos de terceiros a que der causa por meio do uso do Aplicativo."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Quando da participação do Usuário em promoções comerciais realizadas no posto, além do cadastro de seus dados pessoais, também será indispensável o fornecimento e/ou envio de outras informações solicitadas pelas telas do Aplicativo."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Limitações de Responsabilidade',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Em decorrência de previsões legais, a BIOWAHL ABASTECEDORA não realiza a venda de combustíveis ao Usuário, estando sua atividade limitada à disponibilização do Aplicativo, que serve como ferramenta facilitadora para gerar descontos para produtos adquiridos pelo Usuário junto ao posto, assim como a interação com o Usuário em programas de relacionamento e benefícios, além de viabilizar a participação do Usuário em promoções."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Adicionalmente, a BIOWAHL ABASTECEDORA não se responsabiliza:"),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por eventuais indisponibilidades e instabilidades do sistema e funcionamento dos equipamentos instalados nos Postos;"),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por erros ou inconsistências no fornecimento de informações relativas a geoposicionamento (GPS) e mapas, que são produzidos por terceiros e integrados ao Aplicativo apenas para oferecer maior comodidade ao Usuário;"),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por quaisquer danos e prejuízos de qualquer natureza que possam ser devidos em razão do acesso, interceptação, eliminação, alteração, modificação ou manipulação, por terceiros não autorizados, dos arquivos e comunicações transmitidos por meio do Aplicativo;"),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por quaisquer custos incidentes sobre a utilização de funcionalidades do dispositivo móvel do Usuário eventualmente cobrados por sua operadora de telefonia móvel;"),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Por quaisquer problemas decorrentes da instalação do Aplicativo no aparelho celular do Usuário, assim como por seu funcionamento, existência e integridade de todos e quaisquer dados e arquivos existentes no referido aparelho."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Propriedade Intelectual',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  As marcas, nomes, logotipos, nomes de domínio e demais sinais distintivos, bem como todo e qualquer conteúdo, desenho, arte ou layout publicado no Aplicativo são de propriedade exclusiva da BIOWAHL ABASTECEDORA ou a ela licenciados, sendo vedadas cópias, imitações ou seu uso sem o prévio consentimento por escrito da BIOWAHL ABASTECEDORA."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Ainda, são vedados quaisquer atos ou contribuições tendentes à descompilação do Aplicativo, engenharia reversa, modificação das características, ampliação, alteração, mescla ou sua incorporação em quaisquer outros programas ou sistemas. Enfim, toda e qualquer forma de reprodução, total ou parcial, permanente, temporária ou provisória, de forma gratuita ou onerosa, sob quaisquer modalidades, formas ou títulos do Aplicativo, é expressamente vedada."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Sanções',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  A BIOWAHL ABASTECEDORA se reserva ainda o direito de cancelar e/ou bloquear o acesso do Usuário, a qualquer momento, segundo seu exclusivo critério e sem prévio aviso, caso seja constatado que o Usuário, por meio do Aplicativo, praticou algum ato ou conduta que (i) viole as leis e regulamentos federais, estaduais e/ou municipais em vigor; (ii) viole direito de terceiros; (iii) contrarie estes Termos; e (iv) seja incompatível com a utilização, realização e/ou desenvolvimento do Aplicativo."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  O Usuário concorda em indenizar a BIOWAHL ABASTECEDORA, suas filiais, empresas controladas ou controladoras, diretores, administradores, colaboradores, representantes, empregados e parceiras, por qualquer perda, responsabilização, reclamação ou demanda em decorrência de prejuízos resultantes da utilização indevida do Aplicativo."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Política de Privacidade',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Aplicam-se também aos presentes Termos e Condições a Política de Privacidade Qualquer informação pessoal do Usuário obtida por meio do Aplicativo será utilizada de acordo com a referida Política e em conformidade com o previsto nestes Termos."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  O Usuário declara ter lido, estar ciente e de pleno acordo com o conteúdo da Política de Privacidade, e permite à BIOWAHL ABASTECEDORA, desde já, a utilização de seus dados cadastrais para envio de comunicados diversos e material publicitário, adesão automática a campanhas promocionais e a programas de relacionamento, fidelização e benefícios, ofertas de produtos selecionados e serviços personalizados por quaisquer meios, inclusive telefônico, e-mail, SMS, pop ups, correspondência física, bem como o fornecimento dessas informações a suas empresas afiliadas e parceiras comerciais credenciadas, assim como às autoridades públicas quando, neste caso, solicitado ou exigido legalmente."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  A BIOWAHL ABASTECEDORA somente utilizará informações pessoais do Usuário para os fins indicados nesses Termos e conforme Política de Privacidade do Aplicativo."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Caso o Usuário opte, a qualquer momento, nos termos acima, por não participar de forma automática das promoções através do Aplicativo, fica ressalvado que o Usuário será imediatamente excluído da promoção. Não serão, entretanto, excluídos automaticamente os cupons fiscais do Usuário que já estiverem em período de validação pela BIOWAHL ABASTECEDORA para fins de concessão do prêmio da promoção vigente."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Fica sob o livre critério do Usuário o não fornecimento de seus dados pessoais (nome completo, no do CPF, data de nascimento, endereço físico completo, endereço eletrônico, número de telefone, geolocalização); entretanto, o Usuário declara estar plenamente ciente de que não será possível usufruir de todas as funcionalidades e benefícios oferecidos pelo Aplicativo, receber certas informações que vier a solicitar, bem como receber ofertas de produtos e serviços, participar de campanhas promocionais e/ou de programas de relacionamento, fidelidade e benefícios."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  A BIOWAHL ABASTECEDORA poderá alterar o formato e o conteúdo do Aplicativo a qualquer momento, assim como poderá suspender a operação do Aplicativo para a realização de trabalhos de manutenção ou de suporte, a fim de atualizar o seu conteúdo ou por quaisquer outros motivos, sem a necessidade de qualquer aviso prévio ao Usuário, não gerando a BIOWAHL ABASTECEDORA qualquer tipo de responsabilidade ou ônus."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Os Termos vinculam legalmente o Usuário com relação aos atuais serviços oferecidos pelo Aplicativo, bem como em relação a novos serviços que eventualmente venham a ser oferecidos no âmbito do Aplicativo."),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Em caso de dúvidas ou reclamações sobre o Aplicativo e suas funcionalidades, entre em contato com a Central de Atendimento BIOWAHL ABASTECEDORA por meio do número."),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Jurisdição',
                              style: AppTheme.textStyles.textoTermo.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTheme.textStyles.textoTermo,
                            children: [
                              TextSpan(
                                  text:
                                      "•  Estes Termos são regidos e deverão ser interpretados de acordo com a legislação da República Federativa do Brasil, e, em caso de qualquer controvérsia decorrente destes Termos ou em relação ao Aplicativo, os Tribunais brasileiros terão jurisdição exclusiva sobre tal controvérsia, conforme legislação vigente."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyInputWidget(
          inputFormaters: [
            FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
          ],
          textCapitalization: TextCapitalization.none,
          autovalidateMode: AutovalidateMode.always,
          formKey: widget.controller.keyEmail,
          textEditingController: controllerEmail,
          focusNode: email,
          hintText: 'E-Mail',
          campoVazio: 'Digite seu E-Mail',
          onFieldSubmitted: (value) {
            password.requestFocus();
            controllerEmail.text = value!.trim().removeAcentos();
          },
          onChanged: (String? email) {
            widget.controller.copyWith(email: email!.trim().removeAcentos());
          },
        ),
        SizedBox(height: 10),
        MyInputWidget(
          textCapitalization: TextCapitalization.none,
          formKey: widget.controller.keySenha,
          textEditingController: controllerPassword,
          focusNode: password,
          obscureText: !visiblePassword,
          hintText: 'Senha',
          campoVazio: 'Digite sua Senha',
          suffixIcon: GestureDetector(
            child: Icon(
              visiblePassword ? Icons.visibility : Icons.visibility_off,
              size: 25,
              color:
                  visiblePassword ? AppTheme.colors.primary : Color(0xFF666666),
            ),
            onTap: () {
              visiblePassword = !visiblePassword;
              setState(() {});
            },
          ),
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
            controllerPassword.text = value!.trim().removeAcentos();
          },
          onChanged: (String? senha) {
            widget.controller.copyWith(senha: senha!.trim().removeAcentos());
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                await openModalSheet();
              },
              child: Text(
                'Ler termos e condições de uso',
                style: AppTheme.textStyles.titleNome,
              ),
            ),
          ],
        ),
        Observer(builder: (context) {
          return Row(
            children: [
              CupertinoSwitch(
                value: controller.aceitouTermos,
                onChanged: (value) {
                  controller.aceitouTermos = !controller.aceitouTermos;
                },
                activeColor: AppTheme.colors.primary,
                trackColor: Colors.grey,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.aceitouTermos = !controller.aceitouTermos;
                  },
                  child: Text(
                    'Confirmo que li e aceito os termos de uso descrito acima.',
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
