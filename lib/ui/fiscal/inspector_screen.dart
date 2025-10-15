import 'package:flutter/material.dart';
import 'package:rotacred_app/services/inspector_service.dart';
import '../../model/user.dart';
import '../fiscal/inspector_pending_sales_screen.dart';
import '../../model/dto/inspector_dto.dart';
import '../login_screen.dart';
import '../fiscal/inspector_history_pre_sales_screen.dart';

class InspectorScreen extends StatefulWidget {
  final User user;
  const InspectorScreen({super.key, required this.user});

  @override
  State<InspectorScreen> createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  InspectorDTO? _inspector;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _loadInspector();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadInspector() async {
    final inspector = await InspectorService().getInspectorByUserId(
      widget.user.id,
    );
    if (mounted) {
      setState(() => _inspector = inspector);
    }
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _logout() async {
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
    if (_inspector == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8F9FC),
        body: Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        ),
      );
    }

    final tabs = [
      InspectorPendingPreSalesScreen(inspectorId: _inspector!.idInspector),
      InspectorHistoryPreSalesScreen(inspectorId: _inspector!.idInspector),
    ];

    final tabTitles = ['Pendentes', 'Histórico'];
    final tabIcons = [Icons.assignment, Icons.history];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.black26,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            //const Icon(Icons.badge, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Fiscal",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                //const Icon(Icons.person, color: Colors.white70),
                const SizedBox(width: 4),
                Text(
                  widget.user.name ?? 'Usuário',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Sair',
                  onPressed: _logout,
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
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          onTap: _onTabSelected,
          items: List.generate(
            tabs.length,
            (i) => BottomNavigationBarItem(
              icon: Icon(tabIcons[i]),
              label: tabTitles[i],
            ),
          ),
        ),
      ),
    );
  }
}
