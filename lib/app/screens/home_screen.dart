import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_logic.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/logic/dashboard_bloc_logic.dart';
import 'package:mochila_de_viagem/app/blocs/viagem/viagem_bloc_logic.dart';
import 'package:mochila_de_viagem/app/screens/home/configuracoes_screen.dart';
import 'package:mochila_de_viagem/app/screens/home/dashboard_screen.dart';
import 'package:mochila_de_viagem/app/screens/home/viagens_screen.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(create: (_) => DashboardBlocLogic(), child: DashboardScreen()),
    BlocProvider(create: (_) => ViagemBlocLogic(), child: ViagensScreen()),
    BlocProvider(create: (_) => LoginLogic(), child: ConfiguracoesScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text('Smart Bag', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 2,
        backgroundColor: AppColors.primary,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              applyTextScaling: true,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFAF0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Listas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Viagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracoes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        constraints: BoxConstraints(maxWidth: 700),
        padding: const EdgeInsets.all(8.0),
        child: _widgetOptions[_selectedIndex],
      ),
    );
  }
}
