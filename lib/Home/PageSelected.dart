import 'package:flutter/material.dart';

class PageSelected extends StatefulWidget {
  const PageSelected({super.key});

  @override
  State<PageSelected> createState() => _PageSelectedState();
}

class _PageSelectedState extends State<PageSelected> {
final List<Map<String, dynamic>> menuItems = [
  {
    "index": 0,
    "title": "Cajero",
    "icon": Icons.point_of_sale,
    "iconBg": Colors.grey,
    "iconColor": Colors.black54,
    "indicator": null,
  },
  {
    "index": 1,
    "title": "Ventas",
    "icon": Icons.bar_chart,
    "iconBg": Colors.grey,
    "iconColor": Colors.black54,
    "indicator": null,
  },
  {
    "index": 2,
    "title": "Inventario",
    "icon": Icons.inventory_2,
    "iconBg": Colors.grey,
    "iconColor": Colors.black54,
    "indicator": Colors.blue,
  },
  {
    "index": 3,
    "title": "Configuración",
    "icon": Icons.settings,
    "iconBg": Colors.grey,
    "iconColor": Colors.black54,
    "indicator": Colors.green,
  },
];


  @override
  Widget build(BuildContext context) {
    final double boxWidth = 520;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fondo1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color.fromARGB(255, 247, 40, 25).withOpacity(0.1),
                  const Color.fromARGB(255, 247, 40, 25).withOpacity(0.5),
                  const Color.fromARGB(255, 247, 40, 25),
                  const Color.fromARGB(255, 247, 40, 25),
                ],
                stops: const [0.1, 0.4, 0.5, 1.0],
              ),
            ),
          ),

          // contenido centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bienvenido {username}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                // contenedor blanco centrado
                Container(
                  width: boxWidth,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                    childAspectRatio: 1,
                    children: menuItems.map((item) {
                      return _MenuCard(
                        title: item["title"],
                        icon: item["icon"],
                        iconBg: item["iconBg"],
                        iconColor: item["iconColor"],
                        indicatorColor: item["indicator"],
                        onTap: () {
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color? indicatorColor;
  final VoidCallback? onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.indicatorColor,
    this.onTap,
  });

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor = const Color(0xFFF72819);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _hover ? hoverColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onTap,
            child: Stack(
              children: [
                // indicador en esquina
                if (widget.indicatorColor != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: widget.indicatorColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          )
                        ],
                      ),
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.icon,
                        size: 50, // 👈 icono más grande
                        color: _hover ? Colors.white : Colors.black, // negro normal, blanco hover
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16, // un poco más grande
                          fontWeight: FontWeight.w600,
                          color: _hover ? Colors.white : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
