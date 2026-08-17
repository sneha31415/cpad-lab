import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

/// Reusable card for displaying a group in the groups section.
class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group,
    this.onTap,
    this.margin = const EdgeInsets.only(bottom: 10),
  });

  final GroupInfo group;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;

  static const double _avatarRadius = 22;

  Color _balanceColor(String balance) {
    if (balance.startsWith('You owe')) {
      return const Color(0xFFE53935);
    }
    if (balance.startsWith('You are owed')) {
      return const Color(0xFF2E7D32);
    }
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final balanceColor = _balanceColor(group.balance);

    return Card(
      margin: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: _avatarRadius,
                backgroundColor: group.iconColor.withValues(alpha: 0.12),
                child: Icon(group.icon, color: group.iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      group.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${group.members} members',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 96,
                child: Text(
                  group.balance,
                  textAlign: TextAlign.right,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: balanceColor,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

