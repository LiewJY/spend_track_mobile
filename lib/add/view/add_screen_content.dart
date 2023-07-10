import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class AddScreenContent extends StatelessWidget {
  const AddScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    formatDate(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    // final TextEditingController _dateInputController;
    TextEditingController _dateInputController = TextEditingController();
    _dateInputController.text = formatDate(DateTime.now());

    return Column(
      children: [
        Text("AddScreenContent"),
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
            _dateInputController.text = formatDate(pick!);
          },
        ),
        //         TextFormField(
        //   decoration:
        //       InputDecoration(prefixIcon: Icon(Icons.av_timer_outlined)),
        //   controller: _dateInputController,
        //   readOnly: true,
        //   onTap: () {
        //     showTimePicker(
        //       context: context,
        //       initialTime: TimeOfDay.now()

        //     );
        //   },
        // ),
      ],
    );
  }
}
