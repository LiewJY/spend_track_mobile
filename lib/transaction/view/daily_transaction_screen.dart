import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:track_theme/track_theme.dart';

class DailyTransactionScreen extends StatefulWidget {
  const DailyTransactionScreen({super.key});

  @override
  State<DailyTransactionScreen> createState() => _DailyTransactionScreenState();
}

//todo make inot util
formatDate(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

class _DailyTransactionScreenState extends State<DailyTransactionScreen> {
  TextEditingController _dateInputController = TextEditingController();
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _dateInputController.text = formatDate(DateTime.now());

    return Padding(
      padding: AppStyle.paddingHorizontal,
      child: Column(
        children: [
          //todo make into component
          SizedBox(
            height: 8,
          ),
          TextFormField(
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.calendar_today_rounded)),
            controller: _dateInputController,
            readOnly: true,
            onTap: () async {
              DateTime? pick = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                  currentDate: DateTime.now());
              if (pick != null) {
                _dateInputController.text = formatDate(pick!);
                selectedDate = pick;
              }
            },
            onChanged: (value) {
              log(value + 'make query');
            },
          ),

          //todo view in cards
          

        ],
      ),
    );
  }
}
