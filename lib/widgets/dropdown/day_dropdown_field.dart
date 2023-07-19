import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';

class DayDropDownField extends StatefulWidget {
  const DayDropDownField({
    super.key,
    required this.onChanged,
    this.value,
    required this.labelText,
  });

  final onChanged;
  final value;
  final String labelText;

  @override
  State<DayDropDownField> createState() =>
      _DayDropDownFieldState();
}

//dropdown
//todo make it dynamic
List<DropdownMenuItem> get dayDropdownItems {
  List<DropdownMenuItem> menuItems = [
    // const DropdownMenuItem(value: 'Everyday', child: Text('Everyday')),
    // const DropdownMenuItem(value: 'Weekdays', child: Text('Weekdays')),
    // const DropdownMenuItem(value: 'Weekends', child: Text('Weekends')),
  ];
  for (var i = 1; i < 32; i++) {
    menuItems.add(DropdownMenuItem(value: i.toString(), child: Text(i.toString())));
  }
  return menuItems;
}

class _DayDropDownFieldState extends State<DayDropDownField> {
  // gen() {
  //   for (var i = 1; i < 31; i++) {
  //     de const DropdownMenuItem(value: 'Everyday', child: Text('Everyday'));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String? validator(value) {
      if (value != null) {
        return null;
      } else {
        return l10n.pleaseSelectDay;
      }
    }

    return DropdownButtonFormField(
      value: widget.value,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      items: dayDropdownItems,
      onChanged: widget.onChanged,
      validator: validator,
    );
  }
}
