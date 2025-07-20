import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/events/dashboard_bloc_events.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/logic/dashboard_bloc_logic.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/sessao_state.dart';
import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/filtro.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ListaComFiltroScreen extends StatefulWidget {
  final List<Filtro> filtros;
  final String title;

  const ListaComFiltroScreen({
    super.key,
    required this.filtros,
    required this.title,
  });

  @override
  State<ListaComFiltroScreen> createState() => _ListaComFiltroScreenState();
}

class _ListaComFiltroScreenState extends State<ListaComFiltroScreen> {
  @override
  void initState() {
    super.initState();

    if (!mounted) return;
    context.read<DashboardBlocLogic>().add(
      LoadListEvent(ListParams(filtros: widget.filtros), true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<DashboardBlocLogic, SessaoState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.carregando) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state.sessoes.isEmpty) {
            return const Center(child: Text('Nenhuma sessão encontrada.'));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.sessoes.length,
              itemBuilder: (_, index) {
                final sessao = state.sessoes[index];
                return Card(
                  elevation: 8,
                  borderOnForeground: true,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'teste',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (sessao.previsao != null) ...[
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: AppColors.primary,
                                  ),
                                  Text(
                                    DateFormat(
                                      'dd/mm/yyyy',
                                    ).format(sessao.previsao!),
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Wrap(
                              spacing: 10,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 2,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        color: AppColors.primary,
                                      ),
                                      Text(
                                        'Confirmar',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 2,
                                    children: <Widget>[
                                      Icon(Icons.edit, color: Colors.grey),
                                      Text(
                                        'Editar',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 2,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.delete, color: Colors.red),
                                      Text(
                                        'Excluir',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.visibility),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
