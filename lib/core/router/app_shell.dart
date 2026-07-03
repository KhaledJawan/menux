import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../session/current_staff_provider.dart';

/// Bottom-navigation shell. Preserves each tab's navigation state.
/// See PRD.md §5 Navigation and DesignGD.md → Navigation (max 5 tabs, no hamburger menus).
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.space_dashboard_outlined),
      selectedIcon: Icon(Icons.space_dashboard_rounded),
      label: 'Dashboard',
    ),
    NavigationDestination(
      icon: Icon(Icons.receipt_long_outlined),
      selectedIcon: Icon(Icons.receipt_long_rounded),
      label: 'Orders',
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_today_outlined),
      selectedIcon: Icon(Icons.calendar_today_rounded),
      label: 'Reservations',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline_rounded),
      selectedIcon: Icon(Icons.chat_bubble_rounded),
      label: 'Messages',
    ),
    NavigationDestination(
      icon: Icon(Icons.more_horiz_rounded),
      selectedIcon: Icon(Icons.more_horiz_rounded),
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Side-effecting on purpose: backfills the Owner link for restaurants
    // created before staff switching existed, so existing accounts don't
    // lose edit access. See ownerLinkGuardProvider's doc comment.
    ref.watch(ownerLinkGuardProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: _destinations,
      ),
    );
  }
}
