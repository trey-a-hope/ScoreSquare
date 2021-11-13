import 'package:score_square/extensions/hex_color.dart';

const String DUMMY_POSTER_IMG_URL =
    'https://payload.cargocollective.com/1/23/758880/13104445/NO-MOVIE-POSTERS-02-03-03_2000_c.png';
const String DUMMY_PROFILE_PHOTO_URL =
    'https://firebasestorage.googleapis.com/v0/b/hidden-gems-e481d.appspot.com/o/Images%2FUsers%2FDummy%2FProfile.jpg?alt=media&token=99cd4cbd-7df9-4005-adef-b27b3996a6cc';

//These are set in main().
String? version;
String? buildNumber;
double? screenWidth;
double? screenHeight;

const String ALGOLIA_APP_ID = 'GGXI4MP1WJ';
const String ALGOLIA_SEARCH_API_KEY = '01be9bb46f445fa21cdba2c7197d84bf';

const String CLOUD_FUNCTIONS_ENDPOINT =
    'https://us-central1-critic-a9e44.cloudfunctions.net/';

final HexColor colorNavy = HexColor('#09487e');

const String ASSET_LOGIN_BG = 'assets/images/login_bg.jpg';
const String ASSET_APP_ICON = 'assets/images/app_icon.png';

const String TREY_HOPE_UID = 'OkiieQJ7LhbyQwrCEFtOOP9b3Pt2';

const int CRITIQUE_CHAR_LIMIT = 225;

const int PAGE_FETCH_LIMIT = 10;

const String EMAIL = 'thope@imabigcritic.com';

const String MESSAGE_EMPTY_CRITIQUES = 'No critiques at this moment.';
const String MESSAGE_EMPTY_WATCHLIST = 'No movies in your watchlist.';
const String MESSAGE_EMPTY_COMMENTS = 'No comments at this moment.';

//Hive Boxes Names
const String HIVE_BOX_LOGIN_CREDENTIALS = 'HIVE_BOX_LOGIN_CREDENTIALS';
