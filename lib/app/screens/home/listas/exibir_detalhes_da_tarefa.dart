import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/events/dashboard_bloc_events.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/logic/dashboard_bloc_logic.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/sessao_state.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';
import 'package:mochila_de_viagem/app/shared/controllers/date_pick_controller.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_button.dart';
import 'package:mochila_de_viagem/app/shared/widgets/date_picker_input.dart';
import 'package:mochila_de_viagem/app/shared/widgets/text_area_input.dart';
import 'package:mochila_de_viagem/app/shared/widgets/text_input.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ExibirDetalhesDaTarefa extends StatefulWidget {
  final Sessao? sessao;
  final bool? somenteVisualizacao;
  final String segmento;
  final DashboardBlocLogic bloc;
  final VoidCallback aoAtualizarDados;
  const ExibirDetalhesDaTarefa({
    super.key,
    this.sessao,
    this.somenteVisualizacao = false,
    required this.segmento,
    required this.bloc,
    required this.aoAtualizarDados,
  });

  @override
  State<ExibirDetalhesDaTarefa> createState() => _ExibirDetalhesDaTarefaState();
}

class _ExibirDetalhesDaTarefaState extends State<ExibirDetalhesDaTarefa> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _statusController = TextEditingController();
  final _previsaoController = TextEditingController();
  final _segmentoController = TextEditingController();
  final _datePickerController = DatePickController();
  Sessao? get _sessao => widget.sessao;

  DashboardBlocLogic get _bloc => widget.bloc;

  @override
  void initState() {
    _gerarDadosDaSessao();
    _manipularDadosDaPrevisao();
    super.initState();
  }

  void _gerarDadosDaSessao() {
    if (_sessao != null) {
      _tituloController.text = _sessao!.titulo;
      _descricaoController.text = _sessao!.descricao ?? '';
      _statusController.text = _sessao!.status.titulo;
      _previsaoController.text =
          _sessao!.previsao != null ? _sessao!.previsao!.toIso8601String() : '';
    }
    _segmentoController.text = widget.segmento;
  }

  void _manipularDadosDaPrevisao() {
    if (_previsaoController.text.isNotEmpty) {
      _datePickerController.dataSelecionada = DateTime.parse(
        _previsaoController.text,
      );
    }
    _datePickerController.addListener(() {
      if (_datePickerController.dataSelecionada != null) {
        _previsaoController.text =
            _datePickerController.dataSelecionada!.toIso8601String();
      }
    });
  }

  Map<String, dynamic> _gerarDados() {
    return {
      if (_sessao?.id != null) 'id': _sessao!.id,
      'titulo': _tituloController.text,
      'descricao': _descricaoController.text,
      'status': _statusController.text,
      'previsao': _previsaoController.text,
      'segmento': widget.segmento,
    };
  }

  Future<void> _enviarValores() async {
    if (_formKey.currentState!.validate()) {
      final sessao = Sessao.fromJson(_gerarDados());
      if (_sessao != null) {
        _bloc.add(AtualizarTaskEvent(sessao));
      } else {
        _bloc.add(CadastrarTaskEvent(sessao));
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _statusController.dispose();
    _segmentoController.dispose();
    _previsaoController.dispose();
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<DashboardBlocLogic, SessaoState>(
        listener: (context, state) {
          if (state is SessaoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.previsaoAlert,
              ),
            );
          }
          if (state is SessaoFinalizada) {
            widget.aoAtualizarDados();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Nova sessão salva')));
          }
        },
        child: BlocBuilder<DashboardBlocLogic, SessaoState>(
          builder: (context, state) {
            final botaoSubmitHabilitado =
                widget.somenteVisualizacao == false ||
                state is! SessaoCarregando;
            return Form(
              key: _formKey,
              child: Column(
                spacing: 8,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Wrap(
                        spacing: 2,
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Text(
                            'Situação:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _statusController.text,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      DatePickerInput(
                        label: 'Previsão:',
                        controller: _datePickerController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    controller: _tituloController,
                    label: 'Titulo',
                    readOnly: widget.somenteVisualizacao == true,
                  ),
                  const SizedBox(height: 8),
                  TextAreaInput(
                    label: 'Descrição:',
                    controller: _descricaoController,
                    readOnly: widget.somenteVisualizacao == true,
                  ),
                  const SizedBox(height: 8),
                  ConfigButton.primaryButton(
                    title: 'Confirmar',
                    isLoading: state is SessaoCarregando,
                    onTap: !botaoSubmitHabilitado ? null : _enviarValores,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
