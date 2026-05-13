import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<_Started>(_onStarted);
    on<_RefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(_Started event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    // TODO: load home data via use cases
    await Future.delayed(const Duration(milliseconds: 300));
    emit(const HomeState.loaded());
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    // TODO: refresh data
    emit(const HomeState.loaded());
  }
}
