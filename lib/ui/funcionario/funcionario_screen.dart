import 'package:flutter/material.dart';
import 'package:rotacred_app/model/user.dart';
import '../login_screen.dart';
import '../funcionario/add_charging_tab.dart';
import '../funcionario/list_chargings_tab.dart';
import '../funcionario/products_tab.dart';

class FuncionarioScreen extends StatefulWidget {
  final User user;
  const FuncionarioScreen({super.key, required this.user});

  @override
  State<FuncionarioScreen> createState() => _FuncionarioScreenState();
}

class _FuncionarioScreenState extends State<FuncionarioScreen> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sair da conta'),
        content: const Text('Tem certeza de que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      AddChargingTab(user: widget.user),
      ListChargingsTab(user: widget.user, onChargingSelected: (charging) {}),
      ProductsTab(user: widget.user),
    ];

    final tabTitles = ['Adicionar', 'Carregamentos', 'Produtos'];
    final icons = [Icons.add_circle, Icons.local_shipping, Icons.inventory_2];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        shadowColor: Colors.black26,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.badge, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              'Funcionário',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white70),
                const SizedBox(width: 4),
                Text(
                  widget.user.name ?? 'Usuário',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Sair',
                  onPressed: _confirmLogout,
                ),
              ],
            ),
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: tabs,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          elevation: 10,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          onTap: _onTabSelected,
          items: List.generate(
            tabs.length,
            (i) => BottomNavigationBarItem(
              icon: Icon(icons[i]),
              label: tabTitles[i],
            ),
          ),
        ),
      ),
    );
  }
}
