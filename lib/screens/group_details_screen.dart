import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/expense_row.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/member_row.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_header.dart';

/// Group Details screen for "Goa Trip" — Experiment 3 Responsive UI.
///
/// Demonstrates:
/// - MediaQuery & Responsive breakpoint adaptivity
/// - LayoutBuilder for dynamic flex layouts
/// - Expanded and Flexible in multi-column displays
/// - Wrap for group member avatars and stats
/// - GridView for member/expense lists on large screen displays
class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  static final _goaTripGroup = groups.first;

  void _showAddExpenseMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Expense — UI only (Experiment 3)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(context),
      mobileLandscape: _buildLandscapeLayout(context),
      tablet: _buildTabletDesktopLayout(context, isDesktop: false),
      desktop: _buildTabletDesktopLayout(context, isDesktop: true),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Components
  // ---------------------------------------------------------------------------

  Widget _buildGroupHeader(ThemeData theme, GroupInfo group) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: group.iconColor.withValues(alpha: 0.12),
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
    );
  }

  /// Demonstrates Wrap widget for member avatar quick preview chips.
  Widget _buildMemberAvatarsWrap(ThemeData theme) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: goaTripMembers.map((member) {
        return Chip(
          avatar: CircleAvatar(
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            child: Text(
              member.initial,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          label: Text(member.name, style: theme.textTheme.bodySmall),
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(horizontal: 4),
        );
      }).toList(),
    );
  }

  Widget _buildMembersCard() {
    return Card(
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
    );
  }

  Widget _buildExpensesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Column(
          children: [
            for (int i = 0; i < goaTripExpenses.length; i++) ...[
              ExpenseRow(expense: goaTripExpenses[i]),
              if (i < goaTripExpenses.length - 1)
                const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddExpenseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showAddExpenseMessage(context),
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text('Add Expense'),
        style: ElevatedButton.styleFrom(
          animationDuration: Duration.zero,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Mobile Portrait Layout (width < 600)
  // ---------------------------------------------------------------------------
  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);
    final group = _goaTripGroup;

    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGroupHeader(theme, group),
                    const SizedBox(height: 16),
                    _buildMemberAvatarsWrap(theme),
                    const SizedBox(height: 20),
                    const ExpenseSummaryCard(summary: goaTripExpenseSummary),
                    const SizedBox(height: 24),
                    SectionHeader(
                      title: 'Members',
                      trailing: '${goaTripMembers.length} people',
                    ),
                    _buildMembersCard(),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Recent Expenses'),
                    _buildExpensesCard(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: _buildAddExpenseButton(context),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Mobile Landscape Layout (width < 600, Landscape)
  // ---------------------------------------------------------------------------
  Widget _buildLandscapeLayout(BuildContext context) {
    final theme = Theme.of(context);
    final group = _goaTripGroup;

    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Header, Summary, Add Expense Button
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGroupHeader(theme, group),
                      const SizedBox(height: 16),
                      const ExpenseSummaryCard(summary: goaTripExpenseSummary),
                      const SizedBox(height: 16),
                      _buildAddExpenseButton(context),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Right Column: Members and Expenses
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMemberAvatarsWrap(theme),
                      const SizedBox(height: 16),
                      SectionHeader(
                        title: 'Members',
                        trailing: '${goaTripMembers.length} people',
                      ),
                      _buildMembersCard(),
                      const SizedBox(height: 16),
                      const SectionHeader(title: 'Recent Expenses'),
                      _buildExpensesCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. Tablet / Desktop Layout (width >= 600)
  // ---------------------------------------------------------------------------
  Widget _buildTabletDesktopLayout(BuildContext context, {required bool isDesktop}) {
    final theme = Theme.of(context);
    final group = _goaTripGroup;

    return Scaffold(
      appBar: AppBar(
        title: Text('${group.name} Details'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1100 : 880),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side (5 flex): Header, Summary Card, Quick Avatars, Button
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGroupHeader(theme, group),
                            const SizedBox(height: 20),
                            const ExpenseSummaryCard(summary: goaTripExpenseSummary),
                            const SizedBox(height: 20),
                            Text(
                              'Group Members',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildMemberAvatarsWrap(theme),
                            const SizedBox(height: 24),
                            _buildAddExpenseButton(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),

                      // Right Side (6 flex): Detailed Members List & Recent Expenses
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(
                              title: 'Members (${goaTripMembers.length})',
                            ),
                            _buildMembersCard(),
                            const SizedBox(height: 28),
                            const SectionHeader(title: 'Recent Group Expenses'),
                            _buildExpensesCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
