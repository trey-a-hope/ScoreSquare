import 'package:score_square/extensions/hex_color.dart';
import 'package:score_square/models/nba_team_model.dart';

const String dummyProfileImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/hidden-gems-e481d.appspot.com/o/Images%2FUsers%2FDummy%2FProfile.jpg?alt=media&token=99cd4cbd-7df9-4005-adef-b27b3996a6cc';

//These are set in main().
String? version;
String? buildNumber;

final HexColor colorNavy = HexColor('#09487e');

//Hive Boxes Names
const String hiveBoxUserCredentials = 'HIVE_BOX_USER_CREDENTIALS';

//Admin uids.
const List<String> adminUids = ['mDI2IjC0dkVcjvvgm6zTLPiEUMM2'];

//Squares
List<String> squares = [];

//Coins
int initialCoinStart = 30;

//Bets
int maxBetsPerGame = 30;

//Assets: Images
const String appIcon = 'assets/images/app_icon.png';

//NBA Teams
List<NBATeamModel> nbaTeams = [
  NBATeamModel(
    id: 1,
    name: "Hawks",
    city: "Atlanta",
    conference: "Southeast",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FHawks.png?alt=media&token=db513f9a-6f96-4d47-8a64-8de603aa89b5",
    color: HexColor("E03A3E"),
  ),
  NBATeamModel(
    id: 2,
    name: "Celtics",
    city: "Boston",
    conference: "Atlantic",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FCeltics.png?alt=media&token=ea2a87e2-c461-41ff-9f36-0325701f5ce0",
    color: HexColor("008348"),
  ),
  NBATeamModel(
    id: 3,
    name: "Nets",
    city: "Brooklyn",
    conference: "Atlantic",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FNets.png?alt=media&token=982862cc-14bf-4a21-b81f-27cb1edef075",
    color: HexColor("000000"),
  ),
  NBATeamModel(
    id: 4,
    name: "Hornets",
    city: "Charlotte",
    conference: "Southeast",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FHornets.png?alt=media&token=b74f21c1-13e3-44f0-94fb-ebd094072e62",
    color: HexColor("1D1160"),
  ),
  NBATeamModel(
    id: 5,
    name: "Bulls",
    city: "Chicago",
    conference: "East",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FBulls.png?alt=media&token=f9f395ad-f1be-400e-8897-12e9f7490bc4",
    color: HexColor("FF0000"),
  ),
  NBATeamModel(
    id: 6,
    name: "Cavaliers",
    city: "Cleveland",
    conference: "Central",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FCavaliers.jpg?alt=media&token=f235146c-7a26-4a0b-8c62-6ea4000a5890",
    color: HexColor("860038"),
  ),
  NBATeamModel(
    id: 7,
    name: "Mavericks",
    city: "Dallas",
    conference: "Southwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FMavericks.png?alt=media&token=be9f6fcd-66b0-4239-892c-551c72ec2b02",
    color: HexColor("007DC5"),
  ),
  NBATeamModel(
    id: 8,
    name: "Nuggets",
    city: "Denver",
    conference: "Northwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FNuggets.png?alt=media&token=06b13205-08d2-4ffa-8a5e-0069a6d484a0",
    color: HexColor("4FA8FF"),
  ),
  NBATeamModel(
    id: 9,
    name: "Pistons",
    city: "Detroit",
    conference: "Central",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FPistons.png?alt=media&token=d05dcb48-47b1-4c21-9c52-8ca741fe472f",
    color: HexColor("001F70"),
  ),
  NBATeamModel(
    id: 10,
    name: "Warriors",
    city: "Golden State",
    conference: "Pacific",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FWarriors.jpg?alt=media&token=699e5980-5b16-46e5-8f72-ffa5863be69a",
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 11,
    name: "Rockets",
    city: "Houston",
    conference: "Southwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FRockets.jpg?alt=media&token=3b570b2e-868a-42c3-a36b-bff5e529bfcc",
    color: HexColor("CE1141"),
  ),
  NBATeamModel(
    id: 12,
    name: "Pacers",
    city: "Indiana",
    conference: "Central",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FPacers.png?alt=media&token=9f73d077-8995-4f91-892c-98194d2714af",
    color: HexColor("00275D"),
  ),
  NBATeamModel(
    id: 13,
    name: "Clippers",
    city: "Los Angeles",
    conference: "Pacific",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FClippers.jpg?alt=media&token=c42e3463-d0a7-4ce9-8343-0307f6673cd5",
    color: HexColor("ED174C"),
  ),
  NBATeamModel(
    id: 14,
    name: "Lakers",
    city: "Los Angeles",
    conference: "Pacific",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FLakers.jpg?alt=media&token=a86899ff-078f-4fdf-9f59-7e0a9e1eb82f",
    color: HexColor("552582"),
  ),
  NBATeamModel(
    id: 15,
    name: "Grizzlies",
    city: "Memphis",
    conference: "Southwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FGrizzlies.jpg?alt=media&token=4fb12dd8-7a8a-413e-8826-1b21d8f0cdf6",
    color: HexColor("23375B"),
  ),
  NBATeamModel(
    id: 16,
    name: "Heat",
    city: "Miami",
    conference: "Southeast",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FHeat.jpg?alt=media&token=b96720ec-bcb5-4a31-b865-cb2a440df6c3",
    color: HexColor("98002E"),
  ),
  NBATeamModel(
    id: 17,
    name: "Bucks",
    city: "Milwaukee",
    conference: "Central",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FBucks.jpg?alt=media&token=ddb0fe88-37ff-4c4b-aa29-b8b0e5c26b8f",
    color: HexColor("00471B"),
  ),
  NBATeamModel(
    id: 18,
    name: "Timberwolves",
    city: "Minnesota",
    conference: "Northwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FTimberwolves.png?alt=media&token=c4fb2d27-a8e8-4146-9e8f-b9702cf084fc",
    color: HexColor("002B5C"),
  ),
  NBATeamModel(
    id: 19,
    name: "Pelicans",
    city: "New Orleans",
    conference: "Southwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FPelicans.jpg?alt=media&token=452d7aff-2683-474e-91d3-43b875fe599d",
    color: HexColor("002B5C"),
  ),
  NBATeamModel(
    id: 20,
    name: "Knicks",
    city: "New York",
    conference: "Atlantic",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FKnicks.jpg?alt=media&token=e0b48f07-b288-4a7e-a552-008872733375",
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 21,
    name: "Thunder",
    city: "Oklahoma City",
    conference: "Northwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FThunder.png?alt=media&token=519bcc5b-63a7-4b50-bc83-fe763a7f48c1",
    color: HexColor("002D62"),
  ),
  NBATeamModel(
    id: 22,
    name: "Magic",
    city: "Orlando",
    conference: "Southeast",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FMagic.jpeg?alt=media&token=d7325828-43ac-4227-ac82-78b9c0965c6a",
    color: HexColor("007DC5"),
  ),
  NBATeamModel(
    id: 23,
    name: "76ers",
    city: "Philadelphia",
    conference: "Atlantic",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2F76ers.png?alt=media&token=3130f767-a63d-450e-8e4e-862b139850fc",
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 24,
    name: "Suns",
    city: "Phoenix",
    conference: "Pacific",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FSuns.png?alt=media&token=33a5fc75-5c05-4f3f-b31a-14717d1ec81a",
    color: HexColor("E56020"),
  ),
  NBATeamModel(
    id: 25,
    name: "Trail Blazers",
    city: "Portland",
    conference: "Northwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FTrailBlazers.jpg?alt=media&token=83cc1654-aa94-4fc4-b24c-ce7546c967a9",
    color: HexColor("F0163A"),
  ),
  NBATeamModel(
    id: 26,
    name: "Kings",
    city: "Sacramento",
    conference: "Pacific",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FKings.png?alt=media&token=7ec05bbc-b596-4ad5-b58d-f195d31cf9d8",
    color: HexColor("724C9F"),
  ),
  NBATeamModel(
    id: 27,
    name: "Spurs",
    city: "San Antonio",
    conference: "Southwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FSpurs.png?alt=media&token=a32a1c18-9db2-431f-9c67-44cd3aff9e4a",
    color: HexColor("B6BFBF"),
  ),
  NBATeamModel(
    id: 28,
    name: "Raptors",
    city: "Toronto",
    conference: "Atlantic",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FRaptors.png?alt=media&token=b8db4dd0-90b6-4545-813b-59800abc5286",
    color: HexColor("CE1141"),
  ),
  NBATeamModel(
    id: 29,
    name: "Jazz",
    city: "Utah",
    conference: "Northwest",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FJazz.jpg?alt=media&token=510bb7b7-3cf2-4747-af7e-203fbbeddf5f",
    color: HexColor("00471B"),
  ),
  NBATeamModel(
    id: 30,
    name: "Wizards",
    city: "Washington",
    conference: "Southeast",
    imgUrl:
        "https://firebasestorage.googleapis.com/v0/b/project-4262310415987696317.appspot.com/o/Images%2FNBATeams%2FWizards.png?alt=media&token=b0068f69-01ae-46de-ac39-cd01ea202cfb",
    color: HexColor("002566"),
  )
];

//FCM
const String cloudMessagingServerKey =
    'AAAA58Xkfzw:APA91bHmASsPD8AjaS3WEB6dKiUa6SXwinnUrpFRGJrjEnf2G-2jL666O5IqzDmYEVCGU2gZsRdBwRX-oFLOH4FHw6essi_pjdnYwDY5DKhPEWcbPJrDNQVrrN1pvkzxlwmgPdS7Ga66';
