import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/logic/dashboard_bloc_logic.dart';
import 'package:mochila_de_viagem/app/enums/segmento_enum.dart';
import 'package:mochila_de_viagem/app/models/filtro.dart';
import 'package:mochila_de_viagem/app/models/ordem.dart';
import 'package:mochila_de_viagem/app/screens/home/listas/lista_com_filtro_screen.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_button.dart';
import 'package:mochila_de_viagem/app/shared/widgets/main_card.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _segmentos = SegmentoEnum.values;
  /* final _clienteToken = TokenStorage().recuperarToken('cliente-auth');
  late final Cliente _cliente; */
  late final DashboardBlocLogic _bloc;

  @override
  void initState() {
    /* _clienteToken.then(
      (clienteValue) => _cliente = Cliente.fromJson(jsonDecode(clienteValue)),
    ); */
    _bloc = context.read<DashboardBlocLogic>();
    super.initState();
  }

  int getCrossAxisCount(double width) {
    if (width < 380) return 2;
    if (width < 550) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final smallDevice = widthSize < 250;
    return ListView(
      children: [
        Align(
          child: Text(
            'Próxima viagem',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Wrap(
          children: <Widget>[
            ListTile(
              title: Text(
                'Destino',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text('Morro da Dinamarca'),
            ),
            ListTile(
              title: Text(
                'Data/Horário',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text('19/07 - 22:00'),
            ),
          ],
        ),
        ConfigButton.primaryButton(
          icon: Icons.calendar_month,
          title: 'Agendar nova viagem',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: getCrossAxisCount(widthSize),
          childAspectRatio: smallDevice ? 1.5 : 1,
          mainAxisSpacing: 20,
          padding: EdgeInsets.all(12),
          children:
              _segmentos
                  .map(
                    (segmento) => InkWell(
                      onTap: () {
                        final filtros = [Filtro('segmento', segmento.titulo)];
                        final ordens = [Ordem('id', 'desc')];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider.value(
                                  value: _bloc,
                                  child: ListaComFiltroScreen(
                                    filtros: filtros,
                                    ordens: ordens,
                                    title: segmento.tituloAmigavel,
                                  ),
                                ),
                          ),
                        );
                      },
                      child: MainCard(
                        titulo: segmento.tituloAmigavel,
                        icone: segmento.icone,
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
