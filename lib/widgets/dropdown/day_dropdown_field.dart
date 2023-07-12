import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';

class PaymentDayDropDownField extends StatefulWidget {
  const PaymentDayDropDownField({
    super.key,
    required this.onChanged,
    this.value,
  });

  final onChanged;
  final value;

  @override
  State<PaymentDayDropDownField> createState() =>
      _PaymentDayDropDownFieldState();
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

class _PaymentDayDropDownFieldState extends State<PaymentDayDropDownField> {
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
        labelText: l10n.selectPaymentDay,
      ),
      items: dayDropdownItems,
      onChanged: widget.onChanged,
      validator: validator,
    );
  }
}
