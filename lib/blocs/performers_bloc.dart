import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:digital14/core/exceptions/app_exception.dart';
import 'package:digital14/domain/entities/performer_entity.dart';
import 'package:digital14/domain/repositories/seat_geek_repository.dart';
part 'performers_state.dart';

class PerformersBloc extends Cubit<PerformersState> {
  final _seatGeekRepo = GetIt.I<SeatGeekRepository>();

  PerformersBloc() : super(const MovedToPageState(isSearch: false)) {
    _seatGeekRepo.loadFavorites();
  }

  Future<void> getPerformers(int pageId, {String? searchText}) async {
    try {
      List<PerformerEntity> result;
      if (searchText == null) {
        result = await _seatGeekRepo.getPerformers(pageId);
      } else if (searchText.isEmpty) {
        result = [];
      } else {
        result =
            await _seatGeekRepo.getPerformers(pageId, searchText: searchText);
      }
      if (result.isEmpty) {
        emit(const ErrorPerformersState(error: 'No data to display'));
      } else {
        for (var e in result) {
          e.isFavorite = await _seatGeekRepo.isFavorite(e.id);
        }
        emit(LoadedPerformersState(data: result));
      }
      emit(LoadedPerformersState(data: result));
    } on AppException catch (e) {
      emit(ErrorPerformersState(error: e.error));
    } catch (e) {
      emit(ErrorPerformersState(error: e.toString()));
    }
  }

  Future<void> getPerformerDetail(int performerId) async {
    emit(LoadingPerformerDetailState());
    try {
      PerformerEntity result =
          await _seatGeekRepo.getPerformerDetail(performerId);
      result.isFavorite = await _seatGeekRepo.isFavorite(result.id);
      emit(LoadedPerformerDetailState(data: result));
    } on AppException catch (e) {
      emit(ErrorPerformersState(error: e.error));
    } catch (e) {
      emit(ErrorPerformersState(error: e.toString()));
    }
  }

  void updateFavorite(PerformerEntity item) async {
    if (state is LoadedPerformersState) {
      await _seatGeekRepo.updateFavorites(item.id);
      List<PerformerEntity> cData = [...(state as LoadedPerformersState).data];
      final index = cData.indexWhere((e) => e.id == item.id);
      cData[index].isFavorite = !item.isFavorite;
      emit(UpdatedFavoriteState());
      emit(LoadedPerformersState(data: cData));
    } else {
      await _seatGeekRepo.updateFavorites(item.id);
      emit(
        LoadedPerformerDetailState(
          data: PerformerEntity(
              id: item.id,
              name: item.name,
              type: item.type,
              isFavorite: !item.isFavorite),
        ),
      );
    }
  }

  void refresh() async {
    final cResult = [...(state as LoadedPerformersState).data];
    for (var e in cResult) {
      e.isFavorite = await _seatGeekRepo.isFavorite(e.id);
    }
    emit(RefreshedPerformersState());
    emit(LoadedPerformersState(data: cResult));
  }

  void goToHome() {
    emit(const MovedToPageState(isSearch: false));
  }

  void goToSearch() {
    emit(const MovedToPageState(isSearch: true));
  }
}
