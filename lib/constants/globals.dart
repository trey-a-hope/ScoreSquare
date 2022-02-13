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

//Squares
List<String> squares = [
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
  '49',
  '50',
  '51',
  '52',
  '53',
  '54',
  '55',
  '56',
  '57',
  '58',
  '59',
  '60',
  '61',
  '62',
  '63',
  '64',
  '65',
  '66',
  '67',
  '68',
  '69',
  '70',
  '71',
  '72',
  '73',
  '74',
  '75',
  '76',
  '77',
  '78',
  '79',
  '80',
  '81',
  '82',
  '83',
  '84',
  '85',
  '86',
  '87',
  '88',
  '89',
  '90',
  '91',
  '92',
  '93',
  '94',
  '95',
  '96',
  '97',
  '98',
  '99',
];

//Coins
int initialCoinStart = 30;

//Bets
int maxBetsPerGame = 30;

//Assets: Images
const String appIcon = 'assets/images/app_icon.png';
const String sportsBettingBackground =
    'assets/images/sports_betting_background.png';

//NBA Teams
List<NBATeamModel> nbaTeams = [
  NBATeamModel(
    id: 1,
    name: "Hawks",
    city: "Atlanta",
    conference: "Southeast",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fatlanta-hawks.png?alt=media&token=b21318d5-107a-4a91-80fc-db4866b0a169',
    color: HexColor("E03A3E"),
  ),
  NBATeamModel(
    id: 2,
    name: "Celtics",
    city: "Boston",
    conference: "Atlantic",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fboston-celtics.png?alt=media&token=e7fc1df5-378c-43f7-aa55-b0be8751bec6',
    color: HexColor("008348"),
  ),
  NBATeamModel(
    id: 3,
    name: "Nets",
    city: "Brooklyn",
    conference: "Atlantic",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fbrooklyn-nets.png?alt=media&token=7470999a-b989-4f1a-b9c9-a2ddbcf6c9aa',
    color: HexColor("000000"),
  ),
  NBATeamModel(
    id: 4,
    name: "Hornets",
    city: "Charlotte",
    conference: "Southeast",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fcharlotte-hornets.png?alt=media&token=d183676f-1023-48ec-adef-9cfce88e89a3',
    color: HexColor("1D1160"),
  ),
  NBATeamModel(
    id: 5,
    name: "Bulls",
    city: "Chicago",
    conference: "East",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fchicago-bulls.png?alt=media&token=fc1e1f63-a6e0-454b-b7e6-4855785963e0',
    color: HexColor("FF0000"),
  ),
  NBATeamModel(
    id: 6,
    name: "Cavaliers",
    city: "Cleveland",
    conference: "Central",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fcleveland-cavaliers.png?alt=media&token=dd1762f8-754e-4103-a0ee-0e2db81c91dd',
    color: HexColor("860038"),
  ),
  NBATeamModel(
    id: 7,
    name: "Mavericks",
    city: "Dallas",
    conference: "Southwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fdallas-mavericks.png?alt=media&token=bb655bf9-c239-4e2d-b68a-1cb7014364cd',
    color: HexColor("007DC5"),
  ),
  NBATeamModel(
    id: 8,
    name: "Nuggets",
    city: "Denver",
    conference: "Northwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fdenver-nuggets.png?alt=media&token=ec33321e-8fed-4840-8874-8671a402053f',
    color: HexColor("4FA8FF"),
  ),
  NBATeamModel(
    id: 9,
    name: "Pistons",
    city: "Detroit",
    conference: "Central",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fdetroit-pistons.png?alt=media&token=9fd9eea8-9540-4451-8030-819eac1f6111',
    color: HexColor("001F70"),
  ),
  NBATeamModel(
    id: 10,
    name: "Warriors",
    city: "Golden State",
    conference: "Pacific",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fgolden-state-warriors.png?alt=media&token=feed5a11-b4a2-4705-a708-c60f2930718e',
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 11,
    name: "Rockets",
    city: "Houston",
    conference: "Southwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fhouston-rockets.png?alt=media&token=71799059-8fac-4e50-a3a8-f787bd5db7c5',
    color: HexColor("CE1141"),
  ),
  NBATeamModel(
    id: 12,
    name: "Pacers",
    city: "Indiana",
    conference: "Central",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Findiana-pacers.png?alt=media&token=e3844ce4-c2ba-4dd3-821f-73bf68fa1694',
    color: HexColor("00275D"),
  ),
  NBATeamModel(
    id: 13,
    name: "Clippers",
    city: "Los Angeles",
    conference: "Pacific",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Flos-angeles-clippers.png?alt=media&token=53987a3a-4f3a-4693-a267-29ed8ade3d7b',
    color: HexColor("ED174C"),
  ),
  NBATeamModel(
    id: 14,
    name: "Lakers",
    city: "Los Angeles",
    conference: "Pacific",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Flos-angeles-lakers.png?alt=media&token=1ede2511-dcfc-4e41-b13a-fbf281343a44',
    color: HexColor("552582"),
  ),
  NBATeamModel(
    id: 15,
    name: "Grizzlies",
    city: "Memphis",
    conference: "Southwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fmemphis-grizzlies.png?alt=media&token=45b54cad-ccf6-409a-b30e-ee4d5a238da0',
    color: HexColor("23375B"),
  ),
  NBATeamModel(
    id: 16,
    name: "Heat",
    city: "Miami",
    conference: "Southeast",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fmiami-heat.png?alt=media&token=a37fb85f-e023-44fd-8608-eb5b4cb82d41',
    color: HexColor("98002E"),
  ),
  NBATeamModel(
    id: 17,
    name: "Bucks",
    city: "Milwaukee",
    conference: "Central",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fmilwaukee-bucks.png?alt=media&token=49e7095d-553f-4c7b-88fb-8c466af6ca36',
    color: HexColor("00471B"),
  ),
  NBATeamModel(
    id: 18,
    name: "Timberwolves",
    city: "Minnesota",
    conference: "Northwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fminnesota-timberwolves.png?alt=media&token=c27e03fd-010d-4d78-a03d-f1b148cae03d',
    color: HexColor("002B5C"),
  ),
  NBATeamModel(
    id: 19,
    name: "Pelicans",
    city: "New Orleans",
    conference: "Southwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fnew-orleans-pelicans.png?alt=media&token=658cd21b-ed78-432e-bb76-fb4175ec3ba9',
    color: HexColor("002B5C"),
  ),
  NBATeamModel(
    id: 20,
    name: "Knicks",
    city: "New York",
    conference: "Atlantic",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fnew-york-knicks.png?alt=media&token=d43bfec0-09a0-41c0-87dd-8770d8b8b0e6',
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 21,
    name: "Thunder",
    city: "Oklahoma City",
    conference: "Northwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Foklahoma-city-thunder.png?alt=media&token=4d127188-6d60-440e-b14a-11ae1d083e2e',
    color: HexColor("002D62"),
  ),
  NBATeamModel(
    id: 22,
    name: "Magic",
    city: "Orlando",
    conference: "Southeast",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Forlando-magic.png?alt=media&token=9fbbd53a-c4d2-4596-b9b6-549958551f0f',
    color: HexColor("007DC5"),
  ),
  NBATeamModel(
    id: 23,
    name: "76ers",
    city: "Philadelphia",
    conference: "Atlantic",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fphiladelphia-76ers.png?alt=media&token=ca3fdeaf-0d1d-47d5-ada7-44b0a8df5967',
    color: HexColor("006BB6"),
  ),
  NBATeamModel(
    id: 24,
    name: "Suns",
    city: "Phoenix",
    conference: "Pacific",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fphoenix-suns.png?alt=media&token=4df9055d-05e7-414c-8ac6-2b73fece0689',
    color: HexColor("E56020"),
  ),
  NBATeamModel(
    id: 25,
    name: "Trail Blazers",
    city: "Portland",
    conference: "Northwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fportland-trail-blazers.png?alt=media&token=dbd1982e-ab0a-48d9-b8d8-cf3d86aab6d4',
    color: HexColor("F0163A"),
  ),
  NBATeamModel(
    id: 26,
    name: "Kings",
    city: "Sacramento",
    conference: "Pacific",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fsacramento-kings.png?alt=media&token=b3bad0ff-bb8c-460d-9ce7-6bddb65d23b1',
    color: HexColor("724C9F"),
  ),
  NBATeamModel(
    id: 27,
    name: "Spurs",
    city: "San Antonio",
    conference: "Southwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fsan-antonio-spurs.png?alt=media&token=44fea440-2473-473d-aa84-09bba1bb1e64',
    color: HexColor("B6BFBF"),
  ),
  NBATeamModel(
    id: 28,
    name: "Raptors",
    city: "Toronto",
    conference: "Atlantic",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Ftoronto-raptors.png?alt=media&token=c9168811-ebb7-43d1-8746-c0624c22c6ad',
    color: HexColor("CE1141"),
  ),
  NBATeamModel(
    id: 29,
    name: "Jazz",
    city: "Utah",
    conference: "Northwest",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Futah-jazz.png?alt=media&token=790eb40d-5d77-406c-acc4-9e2e820e758e',
    color: HexColor("00471B"),
  ),
  NBATeamModel(
    id: 30,
    name: "Wizards",
    city: "Washington",
    conference: "Southeast",
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/score-square.appspot.com/o/Images%2FNBATeams%2Fwashington-wizards.png?alt=media&token=4afda2cf-947a-4d5d-ad9c-d9e83e9d74a8',
    color: HexColor("002566"),
  )
];

//FCM
const String cloudMessagingServerKey =
    'AAAA58Xkfzw:APA91bHmASsPD8AjaS3WEB6dKiUa6SXwinnUrpFRGJrjEnf2G-2jL666O5IqzDmYEVCGU2gZsRdBwRX-oFLOH4FHw6essi_pjdnYwDY5DKhPEWcbPJrDNQVrrN1pvkzxlwmgPdS7Ga66';

//OAuth
const String googleProviderConfigurationClientId =
    '237172304059-dmu4491ov8fiqloss7v7e11gb3smugil.apps.googleusercontent.com';

//Durations
const int transitionDuration = 500;

//Algolia
const String algoliaAppID = 'SUIQ4Z4MUA';
const String algoliaSearchOnlyAPIKey = '5ba403bd8af320d070ea6ff74b056865';
