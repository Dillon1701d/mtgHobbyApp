import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;
  final VoidCallback onClose;

  const NavDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      width: 72,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
            ),
            Expanded(
              child: NavigationRail(
                extended: false,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.casino),
                    label: Text('Life'),
                  ),
                  NavigationRailDestination(
                  icon: Icon(Icons.search),
                  label: Text('Search'),
            ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: onItemSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}