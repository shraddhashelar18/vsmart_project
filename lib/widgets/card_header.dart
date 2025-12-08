// lib/src/widgets/card_tile.dart
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const CardTile({required this.title, required this.subtitle, this.trailing});
  @override
  Widget build(BuildContext ctx) {
    return Card(
      child: ListTile(
        title: Text(title, style: Theme.of(ctx).textTheme.headline6),
        subtitle: Text(subtitle, style: Theme.of(ctx).textTheme.subtitle1),
        trailing: trailing,
      ),
    );
  }
}
