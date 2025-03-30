import 'package:flutter/material.dart';
import 'package:mtgHobbyApp/ui/cards/CardSearchPage.dart';
import 'lifeTracker/lifeTrackerPage.dart';
import 'home/welcomePage.dart';
import 'home/navDrawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  bool showNav = false;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const WelcomePage();
        break;
      case 1:
        page = LifeTrackerPage();
        break;
      case 2:
        page = CardSearchPage();
        break;
      default:
        throw UnimplementedError('No widget for index $selectedIndex');
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: page),
          buildMenuButton(),
          if (showNav)
            NavDrawer(
              selectedIndex: selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  selectedIndex = index;
                  showNav = false;
                });
              },
              onClose: () => setState(() => showNav = false),
            )
        ],
      ),
    );
  }

  Widget buildMenuButton() {
    return Positioned(
      top: 16,
      left: 16,
      child: Visibility(
        visible: !showNav,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: FloatingActionButton.small(
          onPressed: () => setState(() => showNav = true),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
