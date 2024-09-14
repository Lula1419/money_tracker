import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
        backgroundColor: Colors.teal,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildToolItem(context, 'Categories', Icons.category, () {
            // Implementa la navegación a la pantalla de categorías
          }),
          _buildToolItem(context, 'Reports', Icons.bar_chart, () {
            // Implementa la navegación a la pantalla de reportes
          }),
          _buildToolItem(context, 'Settings', Icons.settings, () {
            // Implementa la navegación a la pantalla de configuración
          }),
          _buildToolItem(context, 'Export', Icons.file_download, () {
            // Implementa la funcionalidad de exportación
          }),
          // Agrega más herramientas según sea necesario
        ],
      ),
    );
  }

  Widget _buildToolItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.teal),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}