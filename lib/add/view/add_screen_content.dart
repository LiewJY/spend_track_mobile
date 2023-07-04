import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class AddScreenContent extends StatelessWidget {
  const AddScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    //todo
    //return TestStepper();
    return Column(
      children: [Text("AddScreenContent")],
    );
  }
}

class TestStepper extends StatefulWidget {
  const TestStepper({super.key});

  @override
  State<TestStepper> createState() => _TestStepperState();
}

class _TestStepperState extends State<TestStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // colorScheme: ColorScheme.light(primary: Colors.pink)
      ),
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            title: const Text('Step 1 title'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1'),
            ),
            isActive: false,
          ),
          Step(
            title: Text('Step 2 title'),
            content: Text('Content for Step 2'),
          ),
                    Step(
            title: Text('Step 3 title'),
            content: Text('Content for Step 3'),
          ),
                    Step(
            title: Text('Step 4 title'),
            content: Text('Content for Step 4'),
          ),
        ],
      ),
    );
  }
}
