import 'package:fpdart/fpdart.dart';


import '../../../../core/error/Failure.dart';
import '../../data/model/user_model.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<UserModel>>>fetchData();
}