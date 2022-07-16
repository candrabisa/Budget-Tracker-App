import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/widget/add_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../widget/transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TransactionItem> items = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTransactionDialog(
                itemToAdd: (transactionItem) {
                  final budgetViewModel = Provider.of<BudgetViewModel>(
                    context,
                    listen: false,
                  );
                  budgetViewModel.addItem(transactionItem);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<BudgetViewModel>(
                    builder: ((context, value, child) {
                      final balance = value.getBalace();
                      final budget = value.getBudget();
                      double percentage = balance / budget;

                      if (percentage < 0) {
                        percentage = 0;
                      }
                      if (percentage > 1) {
                        percentage = 1;
                      }

                      return CircularPercentIndicator(
                        radius: screenSize.width / 2.5,
                        lineWidth: 10.0,
                        percent: percentage,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$ ${balance.toString().split('.')[0]}',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Balance',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Budget: \$ ${budget.toString()}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // ...List.generate(
                //   items.length,
                //   (index) => TransactionCard(
                //     item: items[index],
                //   ),
                // ),
                Consumer<BudgetViewModel>(builder: (context, value, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.items.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TransactionCard(item: value.items[index]);
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
