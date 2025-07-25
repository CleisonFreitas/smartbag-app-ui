import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/events/dashboard_bloc_events.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/logic/dashboard_bloc_logic.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/sessao_state.dart';
import 'package:mochila_de_viagem/app/enums/segmento_enum.dart';
import 'package:mochila_de_viagem/app/enums/sessao_status_enum.dart';
import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/filtro.dart';
import 'package:mochila_de_viagem/app/models/ordem.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';
import 'package:mochila_de_viagem/app/screens/home/listas/exibir_detalhes_da_tarefa.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_dialog.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_text_button.dart';
import 'package:mochila_de_viagem/app/shared/widgets/exibir_detalhes.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ListaComFiltroScreen extends StatefulWidget {
  final List<Filtro> filtros;
  final List<Ordem> ordens;
  final SegmentoEnum segmentoEnum;
  final DashboardBlocLogic bloc;

  const ListaComFiltroScreen({
    super.key,
    required this.filtros,
    required this.ordens,
    required this.segmentoEnum,
    required this.bloc,
  });

  @override
  State<ListaComFiltroScreen> createState() => _ListaComFiltroScreenState();
}

class _ListaComFiltroScreenState extends State<ListaComFiltroScreen> {
  @override
  void initState() {
    super.initState();

    _aoAtualizarListagem();
  }

  void _aoAtualizarListagem() {
    widget.bloc.add(
      LoadListEvent(
        ListParams(filtros: widget.filtros, ordens: widget.ordens),
        true,
      ),
    );
  }

  Widget _gerarBotaoAlterarStatus(
    SessaoStatusEnum status,
    bool isLoading,
    Sessao sessao,
    VoidCallback action,
  ) {
    IconData icon;
    String titulo;
    Color? cor;

    if (status == SessaoStatusEnum.pendente) {
      titulo = 'Confirmar';
      icon = Icons.check;

      cor = Colors.green;
    } else {
      titulo = 'Retomar';
      icon = Icons.arrow_circle_left_outlined;
      cor = AppColors.primary;
    }

    return ConfigTextButton(
      titulo: titulo,
      icone: icon,
      cor: cor,
      isLoading: isLoading,
      onTap: action,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ExibirDetalhes.exibirModal(
            context,
            ExibirDetalhesDaTarefa(
              segmento: widget.segmentoEnum.titulo,
              bloc: widget.bloc,
              aoAtualizarDados: _aoAtualizarListagem,
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.segmentoEnum.tituloAmigavel),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<DashboardBlocLogic, SessaoState>(
        builder: (context, state) {
          if (state is SessaoCarregando) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is SessaoError) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }
          if (state is SessaoConcluida) {
            if (state.sessoes.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma sessão encontrada.',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.sessoes.length,
                itemBuilder: (_, index) {
                  Sessao sessao = state.sessoes[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              sessao.status.tituloAmigavel,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    sessao.status == SessaoStatusEnum.pendente
                                        ? Colors.orangeAccent
                                        : Colors.lightGreen,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  sessao.titulo,
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
                                        'dd/MM/yyyy',
                                      ).format(sessao.previsao!),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
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
                                  _gerarBotaoAlterarStatus(
                                    sessao.status,
                                    state is SessaoItemCarregando,
                                    sessao,
                                    () {
                                      // Esse método não funcionará
                                      //caso o enum receba mais status
                                      final status =
                                          SessaoStatusEnum.values
                                              .firstWhere(
                                                (statusSessao) =>
                                                    statusSessao.titulo !=
                                                    sessao.status.titulo,
                                              )
                                              .titulo;

                                      widget.bloc.add(
                                        AlterarStatusTaskEvent(
                                          sessao.id!,
                                          status,
                                        ),
                                      );
                                      _aoAtualizarListagem();
                                    },
                                  ),
                                  InkWell(
                                    onTap:
                                        () => ExibirDetalhes.exibirModal(
                                          context,
                                          ExibirDetalhesDaTarefa(
                                            sessao: sessao,
                                            segmento:
                                                widget.segmentoEnum.titulo,
                                            bloc: widget.bloc,
                                            aoAtualizarDados:
                                                _aoAtualizarListagem,
                                          ),
                                        ),
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
                                  ConfigTextButton(
                                    titulo: 'Excluir',
                                    icone: Icons.check,
                                    cor: AppColors.previsaoAlert,
                                    onTap:
                                        () => ConfigDialog.showDialogDanger(
                                          context,
                                          'Esse item será excluído permanentemente. Deseja prosseguir?',
                                          () {
                                            widget.bloc.add(
                                              RemoverTaskEvent(sessao.id!),
                                            );
                                            Navigator.of(context).pop();
                                            _aoAtualizarListagem();
                                          },
                                          state is SessaoCarregando,
                                        ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed:
                                    () => ExibirDetalhes.exibirModal(
                                      context,
                                      ExibirDetalhesDaTarefa(
                                        sessao: sessao,
                                        somenteVisualizacao: true,
                                        segmento: widget.segmentoEnum.titulo,
                                        bloc: widget.bloc,
                                        aoAtualizarDados: _aoAtualizarListagem,
                                      ),
                                    ),
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
          }

          /// Caso nada seja encontrado
          return SizedBox.shrink();
        },
      ),
    );
  }
}
