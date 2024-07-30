import 'package:flutter/material.dart';

class GroupWidgets extends StatelessWidget {
  final String name;
  const GroupWidgets({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          child: ChoiceChip(
            label: Text(
              'همه $name',
              style: const TextStyle(color: Colors.black),
            ),
            selected: false,
          ),
        ));
  }
}
