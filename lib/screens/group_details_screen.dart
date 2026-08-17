import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/expense_row.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/member_row.dart';
import '../widgets/section_header.dart';

/// Group Details screen for "Goa Trip" — Experiment 2 layout demonstration.
///
/// Uses Column for major vertical sections, Row inside reusable widgets,
/// and Stack for avatar badge and expense card decoration.
class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  static final _goaTripGroup = groups.first;

  void _showAddExpenseMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Expense — UI only (Experiment 2)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final group = _goaTripGroup;

    return Scaffold(
      appBar: AppBar(title: const Text('Goa Trip')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group header — Row for icon and text side by side
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: group.iconColor.withValues(
                            alpha: 0.12,
                          ),
                          child: Icon(
                            group.icon,
                            color: group.iconColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${group.members} members  ·  ${group.balance}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Total expense summary — Stack inside ExpenseSummaryCard
                    const ExpenseSummaryCard(summary: goaTripExpenseSummary),
                    const SizedBox(height: 28),

                    // Members section
                    SectionHeader(
                      title: 'Members',
                      trailing: '${goaTripMembers.length} people',
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          children: [
                            for (int i = 0; i < goaTripMembers.length; i++) ...[
                              MemberRow(member: goaTripMembers[i]),
                              if (i < goaTripMembers.length - 1)
                                const Divider(height: 1),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Recent expenses section
                    const SectionHeader(title: 'Recent Expenses'),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          children: [
                            for (
                              int i = 0;
                              i < goaTripExpenses.length;
                              i++
                            ) ...[
                              ExpenseRow(expense: goaTripExpenses[i]),
                              if (i < goaTripExpenses.length - 1)
                                const Divider(height: 1),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add Expense button pinned at the bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddExpenseMessage(context),
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text('Add Expense'),
                  style: ElevatedButton.styleFrom(
                    animationDuration: Duration.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
