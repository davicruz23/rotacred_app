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
  bool _rotating = false;

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

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.logout_rounded, color: Colors.redAccent),
            SizedBox(width: 10),
            Text(
              'Sair da conta',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: const Text(
          'Tem certeza de que deseja sair?',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
            label: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
            label: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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
                Row(
                  children: [
                    const Icon(Icons.person_outline, color: Colors.white70),
                    const SizedBox(width: 8),
                    Text(
                      widget.user.name ?? 'Usuário',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTapDown: (_) => setState(() => _rotating = true),
                      onTapUp: (_) {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          setState(() => _rotating = false);
                          _logout();
                        });
                      },
                      child: AnimatedRotation(
                        turns: _rotating ? 0.25 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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
