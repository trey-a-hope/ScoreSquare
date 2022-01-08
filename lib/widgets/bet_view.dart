import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/theme.dart';

import '../constants.dart';

class BetView extends StatelessWidget {
  final BetModel bet;
  final Widget? openBuilder;

  const BetView({
    Key? key,
    required this.bet,
    this.openBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GameModel>(
      future: bet.game(), // async work
      builder: (BuildContext context, AsyncSnapshot<GameModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              GameModel game = snapshot.data as GameModel;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OpenContainer(
                  closedElevation: 5,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: game.homeTeam().color,
                      width: 2,
                    ),
                  ),
                  transitionType: ContainerTransitionType.fade,
                  transitionDuration: const Duration(
                    milliseconds: transitionDuration,
                  ),
                  openBuilder: (context, action) {
                    if (openBuilder != null) {
                      return openBuilder!;
                    } else {
                      return Container();
                    }
                  },
                  closedBuilder: (context, action) => Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CachedNetworkImage(
                              imageUrl: game.homeTeam().imgUrl,
                              imageBuilder: (context, imageProvider) =>
                                  GFAvatar(
                                radius: 40,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              imageUrl: game.awayTeam().imgUrl,
                              imageBuilder: (context, imageProvider) =>
                                  GFAvatar(
                                radius: 40,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              game.toString(),
                              style: textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              bet.homeDigit.toString(),
                              style: textTheme.headline6,
                            ),
                            Text(
                              bet.awayDigit.toString(),
                              style: textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          bet.placedTimeAgo(),
                          textAlign: TextAlign.center,
                          style: textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
