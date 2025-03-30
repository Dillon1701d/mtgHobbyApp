// lifeTrackerPage.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LifeTrackerPage extends StatefulWidget {
  const LifeTrackerPage({super.key});

  @override
  State<LifeTrackerPage> createState() => _LifeTrackerPageState();
}

class _LifeTrackerPageState extends State<LifeTrackerPage> {
  final List<int> playerLifeTotals = List.filled(4, 40);

  void incrementLife(int index) {
    setState(() {
      playerLifeTotals[index]++;
    });
  }

  void decrementLife(int index) {
    setState(() {
      playerLifeTotals[index]--;
    });
  }

  void resetLife() {
    setState(() {
      for (int i = 0; i < playerLifeTotals.length; i++) {
        playerLifeTotals[i] = 40;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Table(
              children: [
                TableRow(children: [
                  _buildPlayerPanel(0, rotateUp: false),
                  _buildPlayerPanel(1, rotateUp: false),
                ]),
                TableRow(children: [
                  _buildPlayerPanel(2, rotateUp: true),
                  _buildPlayerPanel(3, rotateUp: true),
                ]),
              ],
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  key: const Key('resetButton'),
                  icon: const Icon(Icons.refresh),
                  onPressed: resetLife,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerPanel(int index, {required bool rotateUp}) {
    return Container(
      key: Key('playerPanel_$index'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(color: Colors.black12),
      ),
      child: Transform.rotate(
        angle: rotateUp ? math.pi : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Player ${index + 1}',
                key: Key('playerLabel_$index'),
                style: Theme.of(context).textTheme.titleMedium),
            Text('${playerLifeTotals[index]}',
                key: Key('lifeTotal_$index'),
                style: Theme.of(context).textTheme.displayLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  key: Key('decrement_$index'),
                  icon: const Icon(Icons.remove),
                  iconSize: 36,
                  onPressed: () => decrementLife(index),
                ),
                IconButton(
                  key: Key('increment_$index'),
                  icon: const Icon(Icons.add),
                  iconSize: 36,
                  onPressed: () => incrementLife(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}