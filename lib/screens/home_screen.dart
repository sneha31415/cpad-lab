import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/activity_list_item.dart';
import '../widgets/balance_summary_card.dart';
import '../widgets/group_card.dart';
import '../widgets/section_header.dart';
import 'group_details_screen.dart';

/// Main dashboard screen for SplitEase — Experiment 1 static UI.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddExpenseMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Expense — UI only (Experiment 1)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openGoaTripDetails() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const GroupDetailsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              color: theme.colorScheme.primary,
              size: 26,
            ),
            const SizedBox(width: 10),
            Text(
              'SplitEase',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              child: Text(
                'S',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          children: [
            // Greeting section
            Text(
              'Good afternoon, Sneha!',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Here is a quick look at your shared expenses.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            // Balance summary
            const BalanceSummaryCard(summary: balanceSummary),
            const SizedBox(height: 28),

            // Add Expense button (UI only) — placed early for easy thumb reach
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showAddExpenseMessage,
                icon: const Icon(Icons.add_rounded, size: 20),
                label: const Text('Add Expense'),
                style: ElevatedButton.styleFrom(
                  animationDuration: Duration.zero,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Groups section
            SectionHeader(
              title: 'Your Groups',
              trailing: '${groups.length} groups',
            ),
            ...groups.map(
              (group) => GroupCard(
                group: group,
                onTap: group.name == 'Goa Trip' ? _openGoaTripDetails : null,
              ),
            ),
            const SizedBox(height: 20),

            // Recent activity section
            const SectionHeader(title: 'Recent Activity'),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < recentActivities.length; i++) ...[
                      ActivityListItem(activity: recentActivities[i]),
                      if (i < recentActivities.length - 1)
                        const Divider(height: 1),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 88),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseMessage,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group_rounded),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history_rounded),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
