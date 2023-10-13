// import 'package:flutter/material.dart';
// import 'package:track/l10n/l10n.dart';

// class Caa extends StatefulWidget {
//    Caa({super.key, this.val});
//   var val;

//   @override
//   State<Caa> createState() => _CaaState();
// }

// //enum FundSource { wallet, card }

// class _CaaState extends State<Caa> {
//   // List<bool> _isSelected = [true, false];

//   //FundSource fundSource = FundSource.wallet;
//   // String fundSource = 'wallet';
//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     return Container(
//       width: double.infinity,
//       child: SegmentedButton(
//         selected: {widget.val},
//         onSelectionChanged: (newSelection) {
//           setState(() {
//             widget.val = newSelection.first;
//           });
//         },
//         segments: [
//           ButtonSegment(
//             value: 'wallet',
//             label: Text(l10n.wallet),
//             icon: Icon(Icons.wallet),
//           ),
//           ButtonSegment(
//             value: 'card',
//             label: Text(l10n.card),
//             icon: Icon(Icons.credit_card),
//           ),
//         ],
//       ),
//     );
//   }
// }
