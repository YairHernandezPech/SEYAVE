import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Cajero extends StatefulWidget {
  const Cajero({super.key});

  @override
  State<Cajero> createState() => _CajeroState();
}

class _CajeroState extends State<Cajero> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null);
  }
  
  final List<Map<String, dynamic>> ventaProductos = [
    {"nombre": "producto 1", "cantidad": 2, "precio": 2.0},
    {"nombre": "producto 1", "cantidad": 3, "precio": 2.0},
    {"nombre": "Sabrita 45g", "cantidad": 1, "precio": 2.0},
    {"nombre": "Coca Cola 1 lt", "cantidad": 2, "precio": 2.0},
    {"nombre": "Coca Cola 45ml", "cantidad": 2, "precio": 2.0},
    {"nombre": "Frijol", "cantidad": 6, "precio": 2.0},
    {"nombre": "producto 1", "cantidad": 6, "precio": 2.0},
    {"nombre": "producto 1", "cantidad": 6, "precio": 2.0},
  ];

  int? _selectedRow;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();// Fecha actual
    String fechaFormateada = DateFormat('EEEE d \'de\' MMMM \'de\' y', 'es_ES').format(now);// Formato en español
    fechaFormateada = fechaFormateada[0].toUpperCase() + fechaFormateada.substring(1);// Capitalizar la primera letra
    
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // Línea roja superior
          Container(
            height: 40,
            color: const Color(0xFFF72819),
          ),
          Expanded(
            child: Row(
              children: [
                // Panel izquierdo
                Container(
                  width: screenWidth * 0.25,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cajero",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      const SizedBox(height: 8),
                       Text(fechaFormateada,
                          style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 20),
                      // indicadores
                      Row(
                        children: [
                          Expanded(
                              child: _buildInfoCard(
                                  "9", "Agotados", Colors.red)),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _buildInfoCard(
                                  "30", "Vendidos", Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Text("Agotados",
                              style: TextStyle(color: Colors.red)),
                          Spacer(),
                          Text("En venta: ",
                              style: TextStyle(color: Colors.grey)),
                          Text("30",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // grid productos
                      Expanded(
                        child: GridView.builder(
                          itemCount: 9,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.7),
                          itemBuilder: (context, index) {
                            if (index % 3 == 0) {
                              return _buildProductCard("Agotado", Colors.red);
                            } else if (index % 3 == 1) {
                              return _buildProductCard(
                                  "Stock bajo", Colors.orange);
                            } else {
                              return _buildProductCard("producto 1", Colors.blue,
                                  precio: "\$1.00");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Panel central
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // 🔍 buscador más pequeño
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 150),
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey[300],
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "Buscar",
                              suffixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 📋 tabla más larga
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing: 30,
                              headingRowHeight: 40,
                              // ignore: deprecated_member_use
                              dataRowHeight: 55,
                              headingRowColor:
                                  WidgetStateProperty.all(Colors.grey[200]),
                              columns: const [
                                DataColumn(label: Text("Nombre")),
                                DataColumn(label: Text("Cantidad")),
                                DataColumn(label: Text("Precio")),
                                DataColumn(
                                    label: Text("Total del producto")),
                              ],
                              rows: List.generate(ventaProductos.length,
                                  (index) {
                                final p = ventaProductos[index];
                                final total = p["cantidad"] * p["precio"];
                                final isSelected = _selectedRow == index;
                                return DataRow(
                                  color: WidgetStateProperty.all(
                                      isSelected
                                          ? Colors.red
                                          : Colors.white),
                                  onSelectChanged: (_) {
                                    setState(() {
                                      _selectedRow =
                                          isSelected ? null : index;
                                    });
                                  },
                                  cells: [
                                    _buildTableCell(
                                        p["nombre"], isSelected),
                                    _buildTableCell(
                                        p["cantidad"].toString(),
                                        isSelected),
                                    _buildTableCell(
                                        "\$${p["precio"].toStringAsFixed(2)}",
                                        isSelected),
                                    _buildTableCell(
                                        "\$${total.toStringAsFixed(2)}",
                                        isSelected),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton("cancelar venta", Colors.blue),
                            const SizedBox(width: 15),
                            _buildButton("Eliminar productos", Colors.red),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Panel derecho
                Container(
                  width: screenWidth * 0.2,
                  color: const Color(0xFFF72819),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRightCard(Icons.point_of_sale),
                      _buildRightCard(Icons.qr_code_scanner),
                      _buildAmount("\$100.50"), // este se queda contenedor
                      _buildPayButton(), // botón más grande con ícono de tarjeta
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(number,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildProductCard(String label, Color color, {String precio = ""}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const Spacer(),
          const Text("producto 1",
              style:  TextStyle(fontWeight: FontWeight.bold)),
          Text(precio, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  DataCell _buildTableCell(String text, bool selected) {
    return DataCell(Text(text,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black, fontSize: 14)));
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  // 🔴 AHORA SON BOTONES
  Widget _buildRightCard(IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        // acción de ejemplo
      },
      child: SizedBox(
        width: 120,
        height: 100,
        child: Icon(icon, color: const Color(0xFFF72819), size: 60),
      ),
    );
  }

  Widget _buildAmount(String value) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(value,
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF72819))),
      ),
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        // acción de pagar
      },
      child: const SizedBox(
        width: 160,
        height: 100,
        child: Icon(Icons.credit_card,
            color: Color(0xFFF72819), size: 70),
      ),
    );
  }
}
