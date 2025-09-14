import 'package:flutter/material.dart';
import 'package:seyave/Home/Login.dart';

class SideMenu extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;
  final bool isOpen;
  final VoidCallback onToggle;

  const SideMenu({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isOpen ? 220 : 70,
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón para abrir/cerrar
          IconButton(
            icon: Icon(
              widget.isOpen ? Icons.arrow_back_ios : Icons.menu,
              color: Colors.white,
            ),
            onPressed: widget.onToggle,
          ),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.point_of_sale, "Cajero", 0),
          _buildMenuItem(Icons.shopping_cart, "Ventas", 1),
          _buildMenuItem(Icons.inventory, "Inventario", 2),
          _buildMenuItem(Icons.settings, "Configuración", 3),
          _buildMenuItem(Icons.exit_to_app, "Salir", -1), // 🔹 No depende de index
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    bool selected = widget.selectedIndex == index;

    return InkWell(
      onTap: () {
        if (title == "Salir") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          widget.onItemSelected(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: selected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.black : Colors.white),
            if (widget.isOpen) const SizedBox(width: 10),
            if (widget.isOpen)
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
