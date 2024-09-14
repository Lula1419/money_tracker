


import 'package:flutter/material.dart';

class FilterOptionsMenu extends StatelessWidget {
  const FilterOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Options',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFilterOption(context, 'Category', Icons.category),
          _buildFilterOption(context, 'Summary', Icons.summarize),
        ],
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (title == 'Summary') {
          _showSummaryOptions(context);
        } else {
          // Implement category filter logic here
          Navigator.pop(context);
        }
      },
    );
  }

  void _showSummaryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary Options',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSummaryOption(context, 'Daily'),
              _buildSummaryOption(context, 'Weekly'),
              _buildSummaryOption(context, 'Monthly'),
              _buildSummaryOption(context, 'Annual'),
              _buildSummaryOption(context, 'Dates'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryOption(BuildContext context, String option) {
    return ListTile(
      title: Text(option),
      onTap: () {
        // Implement summary filter logic here
        Navigator.pop(context); // Close summary options
        Navigator.pop(context); // Close filter options
      },
    );
  }
}

