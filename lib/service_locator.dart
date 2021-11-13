import 'package:get_it/get_it.dart';
import 'package:score_square/services/nba_service.dart';

import 'services/auth_service.dart';
import 'services/fcm_notification_service.dart';
import 'services/modal_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';
import 'services/util_service.dart';
import 'services/validation_service.dart';

GetIt locator = GetIt.I;

void setUpLocater() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FCMNotificationService());
  locator.registerLazySingleton(() => NBAService());
  locator.registerLazySingleton(() => ModalService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => UtilService());
  locator.registerLazySingleton(() => ValidationService());
}
