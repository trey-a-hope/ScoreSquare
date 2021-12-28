import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';

class BetView extends StatelessWidget {
  final BetModel bet;

  const BetView({
    Key? key,
    required this.bet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GameModel>(
      future: bet.game(), // async work
      builder: (BuildContext context, AsyncSnapshot<GameModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              GameModel game = snapshot.data as GameModel;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CachedNetworkImage(
                            imageUrl: game.homeTeam().imgUrl,
                            imageBuilder: (context, imageProvider) => GFAvatar(
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
                            imageBuilder: (context, imageProvider) => GFAvatar(
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(game.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(bet.homeDigit.toString()),
                          Text(bet.awayDigit.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bet.createdString(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
