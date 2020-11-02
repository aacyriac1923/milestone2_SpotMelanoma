import 'package:get_it/get_it.dart';
import 'package:spotmelanoma/core/services/authentication_service.dart';
import 'package:spotmelanoma/core/viewmodels/login_model.dart';

import './core/services/api.dart';
import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api('ScanHistoryCollection'));
  locator.registerLazySingleton(() => CRUDModel());

  locator.registerFactory(() => LoginModel());
}
