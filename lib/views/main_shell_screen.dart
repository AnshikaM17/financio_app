import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/schemes_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import 'home_screen.dart';
import 'mitra_chat_screen.dart';
import 'schemes_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeVm = context.watch<HomeViewModel>();
    
    final pages = [
      const HomeScreen(),
      const MitraChatScreen(),
      ChangeNotifierProvider(
        create: (_) => SchemesViewModel()..changeLanguage(homeVm.language),
        child: const SchemesScreen(),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Mitra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Schemes',
          ),
        ],
      ),
    );
  }
}
