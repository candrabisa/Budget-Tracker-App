// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:flutter/material.dart';

import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItem item;

  const TransactionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Text('Delete Item'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          final budgetViewModel = Provider.of<BudgetViewModel>(
                              context,
                              listen: false);
                          budgetViewModel.deleteITem(item);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                offset: const Offset(0, 25),
                blurRadius: 50,
              ),
            ],
          ),
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text(
                item.itemTitle,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                '${!item.isExpense ? "+ " : "- "}\$${item.amount.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
