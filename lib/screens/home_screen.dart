import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/activity_list_item.dart';
import '../widgets/balance_summary_card.dart';
import '../widgets/group_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_header.dart';
import 'group_details_screen.dart';

/// Main dashboard screen for SplitEase — Experiment 3 Responsive & Adaptive UI.
///
/// Demonstrates:
/// - MediaQuery (screen dimension & orientation detection)
/// - LayoutBuilder (parent constraint based layout decisions)
/// - OrientationBuilder / Orientation (Mobile landscape layout optimization)
/// - Expanded & Flexible (multi-column flex allocation and overflow prevention)
/// - Wrap (auto-reflowing quick stat & action chips)
/// - GridView (responsive group card grid layout on Tablet & Desktop)
/// - NavigationRail (desktop side navigation replacing bottom navigation)
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
        content: Text('Add Expense — UI only (Experiment 3)'),
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
    return Responsive(
      mobile: _buildMobileLayout(context),
      mobileLandscape: _buildMobileLandscapeLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Components
  // ---------------------------------------------------------------------------

  Widget _buildHeaderGreeting(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  /// Demonstrates Wrap widget for quick stats/filters that reflow gracefully.
  Widget _buildQuickStatsWrap(ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          avatar: Icon(Icons.group_outlined, size: 16, color: theme.colorScheme.primary),
          label: Text('${groups.length} Active Groups', style: theme.textTheme.bodySmall),
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.06),
          side: BorderSide.none,
        ),
        Chip(
          avatar: const Icon(Icons.receipt_long_outlined, size: 16, color: Color(0xFFE53935)),
          label: Text('${recentActivities.length} Pending Expenses', style: theme.textTheme.bodySmall),
          backgroundColor: const Color(0xFFE53935).withValues(alpha: 0.06),
          side: BorderSide.none,
        ),
        Chip(
          avatar: const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF2E7D32)),
          label: Text('1 Settled', style: theme.textTheme.bodySmall),
          backgroundColor: const Color(0xFF2E7D32).withValues(alpha: 0.06),
          side: BorderSide.none,
        ),
      ],
    );
  }

  Widget _buildAddExpenseButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showAddExpenseMessage,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text('Add Expense'),
        style: ElevatedButton.styleFrom(
          animationDuration: Duration.zero,
        ),
      ),
    );
  }

  /// Groups Section — Uses GridView when columns > 1, or single column cards.
  Widget _buildGroupsSection({int crossAxisCount = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Your Groups',
          trailing: '${groups.length} groups',
        ),
        if (crossAxisCount > 1)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: 96,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GroupCard(
                group: group,
                margin: EdgeInsets.zero,
                onTap: group.name == 'Goa Trip' ? _openGoaTripDetails : null,
              );
            },
          )
        else
          ...groups.map(
            (group) => GroupCard(
              group: group,
              onTap: group.name == 'Goa Trip' ? _openGoaTripDetails : null,
            ),
          ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
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
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Mobile Portrait Layout (width < 600)
  // ---------------------------------------------------------------------------
  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          children: [
            _buildHeaderGreeting(theme),
            const SizedBox(height: 12),
            _buildQuickStatsWrap(theme),
            const SizedBox(height: 20),
            const BalanceSummaryCard(summary: balanceSummary),
            const SizedBox(height: 20),
            _buildAddExpenseButton(),
            const SizedBox(height: 24),
            _buildGroupsSection(crossAxisCount: 1),
            const SizedBox(height: 20),
            _buildRecentActivitySection(),
            const SizedBox(height: 88),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseMessage,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Mobile Landscape Layout (width < 600, Landscape)
  // ---------------------------------------------------------------------------
  /// Uses Row + Expanded to display sections side-by-side and reduce vertical scrolling.
  Widget _buildMobileLandscapeLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Greeting, Balance, Add Button
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderGreeting(theme),
                      const SizedBox(height: 12),
                      const BalanceSummaryCard(summary: balanceSummary),
                      const SizedBox(height: 16),
                      _buildAddExpenseButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Right Column: Groups & Recent Activity
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickStatsWrap(theme),
                      const SizedBox(height: 12),
                      _buildGroupsSection(crossAxisCount: 1),
                      const SizedBox(height: 16),
                      _buildRecentActivitySection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. Tablet Layout (600 <= width < 900)
  // ---------------------------------------------------------------------------
  /// Multi-column layout with GridView for groups and bounded max-width container.
  Widget _buildTabletLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderGreeting(theme),
                          const SizedBox(height: 16),
                          const BalanceSummaryCard(summary: balanceSummary),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQuickStatsWrap(theme),
                          const SizedBox(height: 20),
                          _buildAddExpenseButton(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildGroupsSection(crossAxisCount: 1),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: _buildRecentActivitySection(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. Desktop / Web Layout (width >= 900)
  // ---------------------------------------------------------------------------
  /// Replaces BottomNavigationBar with NavigationRail sidebar + responsive multi-column grid.
  Widget _buildDesktopLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation using NavigationRail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onNavItemTapped,
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: [
                const SizedBox(height: 12),
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(height: 16),
              ],
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FloatingActionButton.small(
                    onPressed: _showAddExpenseMessage,
                    tooltip: 'Add Expense',
                    child: const Icon(Icons.add_rounded),
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group_rounded),
                label: Text('Groups'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history_rounded),
                label: Text('Activity'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: Text('Profile'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),

          // Main Dashboard Content Area
          Expanded(
            child: SafeArea(
              child: Column(
                children: [
                  // Desktop Top Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SplitEase Dashboard',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_none_rounded),
                              onPressed: () {},
                              tooltip: 'Notifications',
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Dashboard Body with LayoutBuilder
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideDesktop = constraints.maxWidth > 1100;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Main Column (Greeting, Balance Summary, Groups Grid)
                                      Expanded(
                                        flex: isWideDesktop ? 7 : 6,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildHeaderGreeting(theme),
                                            const SizedBox(height: 20),
                                            const BalanceSummaryCard(summary: balanceSummary),
                                            const SizedBox(height: 28),
                                            _buildGroupsSection(
                                              crossAxisCount: isWideDesktop ? 2 : 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 32),

                                      // Side Column (Quick Stats, Add Button, Recent Activity)
                                      Expanded(
                                        flex: isWideDesktop ? 5 : 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildQuickStatsWrap(theme),
                                            const SizedBox(height: 20),
                                            _buildAddExpenseButton(),
                                            const SizedBox(height: 28),
                                            _buildRecentActivitySection(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}
