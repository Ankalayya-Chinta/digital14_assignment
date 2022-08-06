import 'package:get_it/get_it.dart';
import 'package:digital14/domain/entities/performer_entity.dart';
import 'package:digital14/infrastructure/network/seat_geek_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SeatGeekRepository {
  Future<List<PerformerEntity>> getPerformers(int pageId, {String? searchText});
  Future<PerformerEntity> getPerformerDetail(int performerId);
  Future<void> loadFavorites();
  Future<bool> isFavorite(int performerId);
  Future<void> updateFavorites(int performerId);
}

class SeatGeekRepositoryImpl implements SeatGeekRepository {
  final _favoritesListKey = 'favorites';
  final _favoritesLocalStore = <String>[];
  final Future<SharedPreferences> _dataStore = SharedPreferences.getInstance();
  final _seatGeekApi = GetIt.I<SeatGeekApi>();

  @override
  Future<List<PerformerEntity>> getPerformers(int pageId,
      {String? searchText}) async {
    return await _seatGeekApi.fetchPerformers(pageId, searchText);
  }

  @override
  Future<PerformerEntity> getPerformerDetail(int performerId) {
    return _seatGeekApi.fetchPerformerDetail(performerId);
  }

  @override
  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await _dataStore;
    _favoritesLocalStore.clear();
    _favoritesLocalStore.addAll(prefs.getStringList(_favoritesListKey) ?? []);
  }

  @override
  Future<bool> isFavorite(int performerId) async {
    return _favoritesLocalStore.contains('$performerId');
  }

  @override
  Future<void> updateFavorites(int performerId) async {
    final SharedPreferences prefs = await _dataStore;
    final cData = [..._favoritesLocalStore.toSet().toList()];
    _favoritesLocalStore.clear();
    if (cData.contains('$performerId')) {
      cData.remove('$performerId');
    } else {
      cData.add('$performerId');
    }
    _favoritesLocalStore.addAll(cData);
    await prefs.setStringList(_favoritesListKey, _favoritesLocalStore);
  }
}
