import 'package:fpdart/src/either.dart';
import '../../../../core/error/Failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repository/home_repository.dart';
import '../dataSource/home_remote_data_source.dart';
import '../model/user_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  const HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure,List<UserModel>>> fetchData() async {
    try {
      final res = await homeRemoteDataSource.fetchData();

      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

}