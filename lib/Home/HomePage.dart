import 'package:flutter/material.dart';
import 'package:seyave/Components/side_menu.dart';
import 'package:seyave/Pages/Inventory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isMenuOpen = true;

  final List<Widget> pages = const [
    //CajeroPage(),
    //VentasPage(),
    InventarioPage(),
    //ConfiguracionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            selectedIndex: selectedIndex,
            isOpen: isMenuOpen,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            onToggle: () {
              setState(() {
                isMenuOpen = !isMenuOpen;
              });
            },
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
