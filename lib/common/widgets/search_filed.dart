import 'package:flutter/material.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/widgets/custom_textfelid.dart';


class SearchFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchFiled({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChange: onChanged,
      preIcon: Image.asset(AppImages.search,scale: 4,),
      hintText: 'Search Collage',
      borderRadius: 30,
    );
  }
}
