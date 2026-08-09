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
