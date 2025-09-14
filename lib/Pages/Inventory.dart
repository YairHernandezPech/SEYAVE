import 'package:flutter/material.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  int? selectedRow;

  final List<Map<String, dynamic>> productos = [
    {
      "nombre": "producto 1",
      "codigo": "wthjshw",
      "precio": 2.0,
      "costo": 2.0,
      "stock": 5,
      "unidad": "kg",
      "categoria": "categoria 1"
    },
    {
      "nombre": "Sabrita 45g",
      "codigo": "wthjshw",
      "precio": 2.0,
      "costo": 2.0,
      "stock": 5,
      "unidad": "kg",
      "categoria": "categoria 1"
    },
    {
      "nombre": "Coca Cola 1 lt",
      "codigo": "wthjshw",
      "precio": 2.0,
      "costo": 2.0,
      "stock": 5,
      "unidad": "kg",
      "categoria": "categoria 1"
    },
    {
      "nombre": "Frijol",
      "codigo": "wthjshw",
      "precio": 2.0,
      "costo": 2.0,
      "stock": 5,
      "unidad": "LT",
      "categoria": "categoria 1"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Inventario",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    // Buscador
                    SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Buscar",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: "Tabla",
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: "Tabla", child: Text("Ver como")),
                          DropdownMenuItem(value: "Lista", child: Text("Lista")),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Botón Agregar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Agregar",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Tabla
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text("Nombre")),
                    DataColumn(label: Text("Codigo")),
                    DataColumn(label: Text("Precio venta")),
                    DataColumn(label: Text("Costo Proveedor")),
                    DataColumn(label: Text("Stock")),
                    DataColumn(label: Text("Unidad")),
                    DataColumn(label: Text("Categoría")),
                    DataColumn(label: Text("Opciones")),
                  ],
                  rows: List.generate(productos.length, (index) {
                    final p = productos[index];
                    final isSelected = selectedRow == index;

                    return DataRow(
                      color: WidgetStateProperty.all(
                          isSelected ? Colors.red : Colors.transparent),
                      cells: [
                        DataCell(Text(p["nombre"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(Text(p["codigo"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(Text("${p["precio"].toStringAsFixed(2)} \$",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(Text("${p["costo"].toStringAsFixed(2)} \$",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(Text("${p["stock"]}",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: Text(p["unidad"],
                              style: const TextStyle(fontSize: 12)),
                        )),
                        DataCell(Text(p["categoria"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black))),
                        DataCell(
                          IconButton(
                            icon: Icon(
                              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                              color: isSelected ? Colors.white : Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedRow =
                                    isSelected ? null : index; // selecciona fila
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
