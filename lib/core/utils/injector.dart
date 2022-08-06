import 'dart:async';

import 'package:digital14/core/consts/api_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:digital14/domain/repositories/seat_geek_repository.dart';
import 'package:digital14/infrastructure/network/seat_geek_api.dart';
import 'package:digital14/services/network/mobile_client.dart';
import 'package:digital14/services/network/network_service.dart';

typedef AppRunner = FutureOr<void> Function();

class Injector {
  static Future<void> init({required AppRunner appRunner}) async {
    _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    _injectRepositories();
    await _injectServices();
    _injectApis();
    await GetIt.I.allReady();
  }
}

void _injectRepositories() {
  GetIt.I.registerLazySingleton<SeatGeekRepository>(
      () => SeatGeekRepositoryImpl());
}

void _injectApis() {
  GetIt.I.registerLazySingleton<SeatGeekApi>(() => SeatGeekApi());
}

Future<void> _injectServices() async {
  GetIt.I.registerLazySingleton<NetworkService>(
      () => const ConnectivityService(debugEnabled: true));
  GetIt.I.registerLazySingleton<MobileClient>(
    () => MobileClient(
      baseUrl: ApiConstants.baseUrl,
      clientId: ApiConstants.clientId,
      clientSecert: ApiConstants.clientSecret,
    ),
    dispose: (param) => param.dispose(),
  );
}
