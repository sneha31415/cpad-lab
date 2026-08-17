import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

/// Horizontal row for a group expense: icon, description, and amount.
class ExpenseRow extends StatelessWidget {
  const ExpenseRow({super.key, required this.expense});

  final GroupExpenseInfo expense;

  static const double _avatarRadius = 22;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: _avatarRadius,
            backgroundColor:
                theme.colorScheme.primary.withValues(alpha: 0.1),
            child: Icon(
              expense.icon,
              color: theme.colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Paid by ${expense.paidBy}  ·  ${expense.date}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            expense.amount,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
