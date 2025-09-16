import 'package:flutter/material.dart';

class ProductModal extends StatelessWidget {
  const ProductModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // 🔹 Cabecera
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color:  Color.fromARGB(255, 247, 40, 25),
                  borderRadius:
                       BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(Icons.inventory_2_rounded,
                        color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      "Agregar Producto",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Sección Imagen + Datos principales
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(Icons.photo,
                                size: 45, color: Colors.grey),
                          ),
                          const SizedBox(width: 16),

                          // Inputs principales
                          Expanded(
                            child: Column(
                              children: [
                                _buildInput("Nombre", Icons.label_rounded),
                                const SizedBox(height: 12),
                                _buildInput("Código", Icons.qr_code_2_rounded),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Fila de precios
                      Row(
                        children: [
                          Expanded(
                            child: _buildInput("Precio venta",
                                Icons.attach_money_rounded,
                                small: true),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildInput(
                                "Costo proveedor", Icons.shopping_cart_rounded,
                                small: true),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 🔹 Fila Stock + Unidad
                      Row(
                        children: [
                          Expanded(
                            child: _buildInput("Stock", Icons.inventory_2_rounded,
                                small: true),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdown(
                                "Unidad", ["kg", "LT", "pz"],
                                small: true),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 🔹 Categoría ocupa todo el ancho
                      _buildDropdown("Categoría",
                          ["Categoría 1", "Categoría 2", "Categoría 3"]),
                    ],
                  ),
                ),
              ),

              // 🔹 Botones
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 247, 40, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 40, 25),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Input adaptable (más pequeño para campos cortos)
  static Widget _buildInput(String label, IconData icon, {bool small = false}) {
    return SizedBox(
      height: small ? 50 : 60,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 247, 40, 25), size: small ? 18 : 22),
          labelText: label,
          labelStyle: TextStyle(fontSize: small ? 13 : 14),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color.fromARGB(255, 247, 40, 25)),
          ),
        ),
      ),
    );
  }

  /// 🔹 Dropdown adaptable (más pequeño para combos cortos)
  static Widget _buildDropdown(String label, List<String> items,
      {bool small = false}) {
    return SizedBox(
      height: small ? 50 : 60,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: small ? 13 : 14),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }
}

/// 🔹 Función para mostrar modal
void showProductModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const ProductModal(),
  );
}
