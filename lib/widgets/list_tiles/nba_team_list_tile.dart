import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/constants/app_themes.dart';

class NBATeamListTile extends StatelessWidget {
  final NBATeamModel team;
  final VoidCallback? onTap;
  final SlidableAction? slidableAction;

  const NBATeamListTile({
    Key? key,
    required this.team,
    this.onTap,
    this.slidableAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: slidableAction != null,
      key: ValueKey(team.hashCode),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (slidableAction != null) ...[
            slidableAction!,
          ]
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(team.imgUrl),
        ),
        title: Text(
          '${team.city} ${team.name}',
          style: AppThemes.textTheme.headline4,
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          '${team.conference} Conference',
          textAlign: TextAlign.start,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
