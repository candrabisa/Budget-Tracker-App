// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const AddBudgetDialog({
    Key? key,
    required this.budgetToAdd,
  }) : super(key: key);

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Add a budget',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(hintText: 'Budget in \$'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    widget.budgetToAdd(double.parse(amountController.text));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
