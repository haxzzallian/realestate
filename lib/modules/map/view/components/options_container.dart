import 'package:flutter/material.dart';

class LayerOptions extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String> onOptionSelected;

  const LayerOptions({
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -40,
      bottom: 150,
      child: Container(
        height: 320,
        width: 350,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildOption(Icons.park, "Cosy Area"),
            _buildOption(Icons.price_check, "Price"),
            _buildOption(Icons.location_city, "Infrastructure"),
            _buildOption(Icons.layers_clear, "Without Any Layer"),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String text) {
    final isSelected = selectedOption == text;
    return GestureDetector(
      onTap: () => onOptionSelected(text),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
