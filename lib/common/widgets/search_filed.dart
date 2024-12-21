import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';

class SearchFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchFiled({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Recipes...',
          hintStyle: const TextStyle(color: AppColors.grey),
          prefixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.search, color: AppColors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
