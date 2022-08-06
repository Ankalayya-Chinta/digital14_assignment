part of 'performers_bloc.dart';

abstract class PerformersState extends Equatable {
  const PerformersState();

  @override
  List<Object?> get props => [];
}

class InitialPerformersState extends PerformersState {}

class LoadingPerformersState extends PerformersState {}

class LoadedPerformersState extends PerformersState {
  final List<PerformerEntity> data;

  const LoadedPerformersState({required this.data});

  @override
  List<Object?> get props => [data];
}

class LoadingPerformerDetailState extends PerformersState {}

class LoadedPerformerDetailState extends PerformersState {
  final PerformerEntity data;

  const LoadedPerformerDetailState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorPerformersState extends PerformersState {
  final String error;

  const ErrorPerformersState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdatedFavoriteState extends PerformersState {}

class RefreshedPerformersState extends PerformersState {}

class MovedToPageState extends PerformersState {
  final bool isSearch;

  const MovedToPageState({required this.isSearch});

  @override
  List<Object?> get props => [isSearch];
}
