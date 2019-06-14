import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';
import 'package:jobber/src/ui/screens/position.dart';

import 'package:provider/provider.dart';
import 'package:morpheus/morpheus.dart';

class PositionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final positions = Provider.of<Positions>(context);
    return LoadingTransition(
      child: Builder(builder: (context) {
        if (positions.positions.isEmpty) {
          positions.getPositions();
        }
        if (positions.isLoading) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final position = positions.positions[index];
              final parentKey = GlobalKey();
              return ListTile(
                key: parentKey,
                title: Text(position['title']),
                subtitle: Text(position['type']),
                onTap: () => Navigator.of(context).push(MorpheusPageRoute(
                  builder: (context) => Position(
                    title: position['title'],
                    id: position['id'],
                  ),
                  parentKey: parentKey,
                )),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(height: 1.0),
            itemCount: positions.positions.length,
          );
        }
      }),
    );
  }
}
