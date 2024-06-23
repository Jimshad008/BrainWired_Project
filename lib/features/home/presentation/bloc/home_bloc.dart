import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_model.dart';
import '../../domain/usecase/fetch_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchData _fetchData;
  HomeBloc({required FetchData fetchData}):_fetchData=fetchData,super(HomeInitial()) {
    on<HomeFetchVideo>((event, emit) async {
      emit(HomeLoading());
      final res=await _fetchData.homeRepository.fetchData();
      res.fold(
              (l) => emit(HomeFailure( l.message)),
      (uid) => emit(HomeSuccess( uid)));
    });
  }
}
