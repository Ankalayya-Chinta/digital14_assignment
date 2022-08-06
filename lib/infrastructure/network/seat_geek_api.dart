import 'package:get_it/get_it.dart';
import 'package:digital14/core/exceptions/network_connection_exception.dart';
import 'package:digital14/domain/entities/performer_entity.dart';
import 'package:digital14/services/network/mobile_client.dart';
import 'package:digital14/services/network/network_service.dart';

class SeatGeekApi {
  final _httpClient = GetIt.I<MobileClient>();
  final _networkService = GetIt.I<NetworkService>();

  Future<List<PerformerEntity>> fetchPerformers(
      int pageId, String? searchText) async {
    final isConnected = await _networkService.isConnected;
    if (isConnected) {
      String searchParams = '';
      if (searchText != null) {
        searchParams = '&q=$searchText';
      }
      final result = await _httpClient.get(
        '/performers?page=$pageId&per_page=25$searchParams',
      );
      //print(result['performers']);
      try {
        return result['performers'] != null
            ? (result['performers'] as List<dynamic>)
                .map((e) => PerformerEntity.fromJson(e))
                .toList()
            : [];
      } catch (e) {
        rethrow;
      }
    } else {
      throw NetworkConnectionException();
    }
  }

  Future<PerformerEntity> fetchPerformerDetail(int performerId) async {
    final isConnected = await _networkService.isConnected;
    if (isConnected) {
      final result = await _httpClient.get('/performers/$performerId');
      try {
        return PerformerEntity.fromJson(result);
      } catch (e) {
        rethrow;
      }
    } else {
      throw NetworkConnectionException();
    }
  }
}
