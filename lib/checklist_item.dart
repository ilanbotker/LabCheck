import 'package:flutter/material.dart';

class ChecklistItem extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  ChecklistItem({
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _ChecklistItemState createState() => _ChecklistItemState();
}

class _ChecklistItemState extends State<ChecklistItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
              widget.onChanged(value);
            });
          },
        ),
        Text(widget.label),
      ],
    );
  }
}