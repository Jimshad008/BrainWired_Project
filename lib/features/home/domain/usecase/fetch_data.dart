import 'package:fpdart/src/either.dart';
import '../../../../core/error/Failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_data.dart';
import '../repository/home_repository.dart';


class FetchData implements UseCase<List<UserData>,String>{
  final HomeRepository homeRepository;
  FetchData(this.homeRepository);
  @override
  Future<Either<Failure,List<UserData>>> call(String params) async {
    return await homeRepository.fetchData();
  }

}