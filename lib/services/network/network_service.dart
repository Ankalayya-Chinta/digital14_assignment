import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkService {
  Future<bool> get isConnected;

  final bool debugEnabled;

  const NetworkService({this.debugEnabled = false});
}

class ConnectivityService extends NetworkService {
  Connectivity get _connectivity => Connectivity();

  @override
  Future<bool> get isConnected async =>
      _parseConnectionStatus(await _connectivity.checkConnectivity());

  /// Creates a [ConnectivityService] object.
  ///
  /// While [Connectivity] provides a [Stream] to listen to connection
  /// status changes, this is unreliable on Android SDK >= 26, so connectivity
  /// status must be checked every time via [NetworkService.isConnected].
  const ConnectivityService({
    bool debugEnabled = false,
  }) : super(debugEnabled: debugEnabled);

  bool _parseConnectionStatus(ConnectivityResult result) =>
      result != ConnectivityResult.none;
}
