import 'package:flutter/material.dart';

/// Static dummy data for Experiment 1 — no backend or calculations.

class BalanceSummary {
  const BalanceSummary({
    required this.totalBalance,
    required this.youOwe,
    required this.youAreOwed,
  });

  final String totalBalance;
  final String youOwe;
  final String youAreOwed;
}

class GroupInfo {
  const GroupInfo({
    required this.name,
    required this.members,
    required this.balance,
    required this.icon,
    required this.iconColor,
  });

  final String name;
  final int members;
  final String balance;
  final IconData icon;
  final Color iconColor;
}

class ActivityInfo {
  const ActivityInfo({
    required this.title,
    required this.group,
    required this.amount,
    required this.date,
    required this.isPaid,
  });

  final String title;
  final String group;
  final String amount;
  final String date;
  final bool isPaid;
}

const balanceSummary = BalanceSummary(
  totalBalance: '₹1,250.00',
  youOwe: '₹450.00',
  youAreOwed: '₹1,700.00',
);

const groups = [
  GroupInfo(
    name: 'Goa Trip',
    members: 6,
    balance: 'You owe ₹320',
    icon: Icons.beach_access,
    iconColor: Color(0xFF00897B),
  ),
  GroupInfo(
    name: 'College Friends',
    members: 8,
    balance: 'You are owed ₹850',
    icon: Icons.school,
    iconColor: Color(0xFF5C6BC0),
  ),
  GroupInfo(
    name: 'Roommates',
    members: 3,
    balance: 'Settled up',
    icon: Icons.home,
    iconColor: Color(0xFF43A047),
  ),
];

/// Member in a group — static data for Experiment 2 Group Details screen.
class MemberInfo {
  const MemberInfo({
    required this.name,
    required this.initial,
    required this.balance,
    required this.isCurrentUser,
  });

  final String name;
  final String initial;
  final String balance;
  final bool isCurrentUser;
}

/// Expense entry within a group — static data for Experiment 2.
class GroupExpenseInfo {
  const GroupExpenseInfo({
    required this.description,
    required this.amount,
    required this.date,
    required this.paidBy,
    required this.icon,
  });

  final String description;
  final String amount;
  final String date;
  final String paidBy;
  final IconData icon;
}

/// Summary of total group expenses — static data for Experiment 2.
class GroupExpenseSummary {
  const GroupExpenseSummary({
    required this.totalExpenses,
    required this.yourShare,
    required this.memberCount,
  });

  final String totalExpenses;
  final String yourShare;
  final int memberCount;
}

const goaTripExpenseSummary = GroupExpenseSummary(
  totalExpenses: '₹12,450.00',
  yourShare: '₹320.00 owed',
  memberCount: 6,
);

const goaTripMembers = [
  MemberInfo(
    name: 'Sneha',
    initial: 'S',
    balance: 'You owe ₹320',
    isCurrentUser: true,
  ),
  MemberInfo(
    name: 'Rahul',
    initial: 'R',
    balance: 'Owes ₹150',
    isCurrentUser: false,
  ),
  MemberInfo(
    name: 'Priya',
    initial: 'P',
    balance: 'Owes ₹200',
    isCurrentUser: false,
  ),
  MemberInfo(
    name: 'Amit',
    initial: 'A',
    balance: 'Settled up',
    isCurrentUser: false,
  ),
  MemberInfo(
    name: 'Neha',
    initial: 'N',
    balance: 'Is owed ₹470',
    isCurrentUser: false,
  ),
  MemberInfo(
    name: 'Karan',
    initial: 'K',
    balance: 'Settled up',
    isCurrentUser: false,
  ),
];

const goaTripExpenses = [
  GroupExpenseInfo(
    description: 'Dinner at Spice Garden',
    amount: '₹1,800.00',
    date: 'Today',
    paidBy: 'Neha',
    icon: Icons.restaurant_rounded,
  ),
  GroupExpenseInfo(
    description: 'Cab to airport',
    amount: '₹600.00',
    date: 'Yesterday',
    paidBy: 'Rahul',
    icon: Icons.local_taxi_rounded,
  ),
  GroupExpenseInfo(
    description: 'Beach resort booking',
    amount: '₹8,500.00',
    date: 'Mon, 4 Aug',
    paidBy: 'Priya',
    icon: Icons.beach_access_rounded,
  ),
  GroupExpenseInfo(
    description: 'Snacks & drinks',
    amount: '₹550.00',
    date: 'Sun, 3 Aug',
    paidBy: 'Sneha',
    icon: Icons.local_cafe_rounded,
  ),
];

const recentActivities = [
  ActivityInfo(
    title: 'Dinner at Spice Garden',
    group: 'Goa Trip',
    amount: '₹1,800.00',
    date: 'Today',
    isPaid: false,
  ),
  ActivityInfo(
    title: 'Cab to airport',
    group: 'Goa Trip',
    amount: '₹600.00',
    date: 'Yesterday',
    isPaid: true,
  ),
  ActivityInfo(
    title: 'Project supplies',
    group: 'College Friends',
    amount: '₹450.00',
    date: 'Mon, 4 Aug',
    isPaid: false,
  ),
  ActivityInfo(
    title: 'Electricity bill',
    group: 'Roommates',
    amount: '₹1,200.00',
    date: 'Sun, 3 Aug',
    isPaid: true,
  ),
];
