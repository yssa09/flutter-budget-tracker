import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

import '../cubit/list_cubit.dart';
import '../../widgets/widgets.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class TrackerView extends StatelessWidget {
  /// {@macro counter_view}

  TrackerView({super.key});

  int id = 0;
  num? _value;
  String? _label;

  final _labelController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Tracker')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<TrackerCubit, List>(
          builder: (context, state) {
            double _balance = TrackerCubit().doubleBalance(state);
            Color? color = _balance < 0 ? Colors.red : null;
            String stringAmount = _balance == 0
                ? '-       '
                : '₱' + _balance.abs().toStringAsFixed(2);

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                balance(color, stringAmount),
                SizedBox(height: 10),
                totals(
                  TrackerCubit().totalDebit(state),
                  TrackerCubit().totalCredit(state),
                ),
                SizedBox(height: 10),
                entries(state),
                SizedBox(height: 10),
                textFields(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [debitButton(context), creditButton(context)],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget balance(Color? color, String string) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('BALANCE', style: TextStyle(fontSize: 18)),
          Text(
            string,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget totals(String amount, String amount2) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color.fromRGBO(199, 217, 231, 1),
      ),
      width: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTotalWidget(text: 'Total Debit', amount: amount),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 30,
              width: 2,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(149, 167, 181, 1),
              ),
            ),
            CustomTotalWidget(
              text: 'Total Credit',
              amount: amount2,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget entryWidget(Map<String, dynamic> entry, TextStyle? style) {
    return BlocBuilder<TrackerCubit, List>(builder: (context, state) {
      return Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromRGBO(199, 217, 231, 1),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 20,
                onPressed: () {
                  context.read<TrackerCubit>().remove(entry);
                },
              ),
              Expanded(child: Text('${entry['label']}')),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    '₱${entry['amount'].toStringAsFixed(2)}',
                    textAlign: TextAlign.end,
                    style: style,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: state.indexOf(entry) == state.length - 1 ? 0 : 5,
        )
      ]);
    });
  }

  Widget entries(List state) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (Map<String, dynamic> entry in state)
                  entry['bool']
                      ? entryWidget(entry, null)
                      : entryWidget(entry, TextStyle(color: Colors.red)),
              ],
            ),
          ),
          Center(
            child: Text(
              'History',
              style: TextStyle(
                fontSize: 50,
                color: Color.fromRGBO(100, 100, 100, .2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFields() {
    return Column(
      children: [
        CustomTextField(
          hint: 'Enter Transaction',
          label: 'Transaction',
          controller: _labelController,
        ),
        SizedBox(height: 10),
        CustomTextField(
          hint: 'Enter Amount',
          label: 'Amount',
          controller: _amountController,
          keyboard: TextInputType.number,
        )
      ],
    );
  }

  Widget debitButton(BuildContext context) {
    return BlocBuilder<TrackerCubit, List>(builder: (context, state) {
      return Container(
        width: 120,
        child: ElevatedButton(
          child: Text(' Debit'),
          onPressed: () {
            _label = _labelController.text;
            _value = double.tryParse(_amountController.text);

            context.read<TrackerCubit>().increment(id, _value, _label!, true);

            id += 1;
            _labelController.text = '';
            _amountController.text = '';
          },
        ),
      );
    });
  }

  Widget creditButton(BuildContext context) {
    return BlocBuilder<TrackerCubit, List>(builder: (context, state) {
      return Container(
        width: 120,
        child: ElevatedButton(
          child: Text(' Credit'),
          onPressed: () {
            _label = _labelController.text;
            _value = double.tryParse(_amountController.text);

            context.read<TrackerCubit>().decrement(id, _value, _label!, false);

            id += 1;
            _labelController.text = '';
            _amountController.text = '';
          },
        ),
      );
    });
  }

  Widget rowButtons(BuildContext context) {
    return BlocBuilder<TrackerCubit, List>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [debitButton(context), creditButton(context)],
      );
    });
  }
}
