import 'package:get_it/get_it.dart';
import 'package:score_square/services/bet_service.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/nba_service.dart';

import 'services/auth_service.dart';
import 'services/fcm_notification_service.dart';
import 'services/modal_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';
import 'services/util_service.dart';
import 'services/validation_service.dart';

GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => BetService());
  locator.registerLazySingleton(() => FCMNotificationService());
  locator.registerLazySingleton(() => GameService());
  locator.registerLazySingleton(() => ModalService());
  locator.registerLazySingleton(() => NBAService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => UtilService());
  locator.registerLazySingleton(() => ValidationService());
}
