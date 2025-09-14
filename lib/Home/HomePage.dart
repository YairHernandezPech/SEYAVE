import 'package:flutter/material.dart';
import 'package:seyave/Components/side_menu.dart';
import 'package:seyave/Pages/Cajero.dart';
import 'package:seyave/Pages/Inventory.dart';
// importa también tus otras páginas CajeroPage, VentasPage, ConfiguracionPage

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex;
  bool isMenuOpen = true;

  final List<Widget> pages = const [
    Cajero(),
    InventarioPage(),
    InventarioPage(),
    InventarioPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

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
