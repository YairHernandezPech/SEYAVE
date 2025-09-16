import 'package:flutter/material.dart';
import 'package:seyave/Components/Modal.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  int? selectedRow;
  String _viewMode = "Tabla";

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          // Header superior con fondo gris
          Container(
            color: const Color.fromARGB(255, 238, 238, 238),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Inventario",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    // Buscador
                    SizedBox(
                      width: 300,
                      height: 48,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Buscar",
                          prefixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black45),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Dropdown
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: DropdownButton<String>(
                        value: _viewMode,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: const [
                          DropdownMenuItem(value: "Tabla", child: Text("Ver como")),
                          DropdownMenuItem(value: "Lista", child: Text("Lista")),
                          DropdownMenuItem(value: "Detalle", child: Text("Detalles")),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _viewMode = v);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Botón Agregar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 40, 25),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showProductModal(context);
                      },
                      child: const Text(
                        "Agregar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(

                  constraints: BoxConstraints(minWidth: screenWidth * 0.8),
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(Colors.grey.shade100),
                    dataRowHeight: 70,
                    headingRowHeight: 60,
                    columnSpacing: 50,
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
                        selected: isSelected,
                        // Permite seleccionar la fila tocando cualquier parte de la fila
                        onSelectChanged: (selected) {
                          setState(() {
                            selectedRow = (selected == true) ? index : null;
                          });
                        },
                        color: MaterialStateProperty.resolveWith<Color?>(
                            (states) {
                          return isSelected ? const Color.fromARGB(255, 247, 40, 25) : Colors.white;
                        }),
                        cells: [
                          DataCell(Text(
                            p["nombre"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(Text(
                            p["codigo"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(Text(
                            "${p["precio"].toStringAsFixed(2)} \$",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(Text(
                            "${p["costo"].toStringAsFixed(2)} \$",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(Text(
                            "${p["stock"]}",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Text(p["unidad"],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          )),
                          DataCell(Text(
                            p["categoria"],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRow = isSelected ? null : index;
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white : const Color.fromARGB(255, 247, 40, 25),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
