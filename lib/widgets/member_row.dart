import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

/// Horizontal row for a group member: avatar, name, and balance.
/// Uses Stack to overlay a "You" badge on the current user's avatar.
class MemberRow extends StatelessWidget {
  const MemberRow({super.key, required this.member});

  final MemberInfo member;

  static const double _avatarRadius = 22;

  Color _balanceColor(String balance) {
    if (balance.startsWith('You owe') || balance.startsWith('Owes')) {
      return const Color(0xFFE53935);
    }
    if (balance.startsWith('Is owed') || balance.startsWith('You are owed')) {
      return const Color(0xFF2E7D32);
    }
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final balanceColor = _balanceColor(member.balance);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Stack: avatar with optional "You" badge overlay
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: _avatarRadius,
                backgroundColor:
                    theme.colorScheme.primary.withValues(alpha: 0.12),
                child: Text(
                  member.initial,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (member.isCurrentUser)
                Positioned(
                  right: -4,
                  bottom: -2,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      'You',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              member.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            member.balance,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: balanceColor,
            ),
          ),
        ],
      ),
    );
  }
}
