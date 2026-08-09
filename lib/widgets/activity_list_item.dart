import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

/// Reusable list item for the recent activity section.
class ActivityListItem extends StatelessWidget {
  const ActivityListItem({super.key, required this.activity});

  final ActivityInfo activity;

  static const double _avatarRadius = 22;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amountColor = activity.isPaid
        ? const Color(0xFF2E7D32)
        : const Color(0xFFE53935);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: activity.isPaid
                ? const Color(0xFFE8F5E9)
                : theme.colorScheme.primary.withValues(alpha: 0.1),
            child: Icon(
              activity.isPaid
                  ? Icons.check_circle_outline
                  : Icons.receipt_long_outlined,
              color: activity.isPaid
                  ? const Color(0xFF2E7D32)
                  : theme.colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${activity.group}  ·  ${activity.date}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                activity.amount,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                activity.isPaid ? 'Settled' : 'Pending',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
