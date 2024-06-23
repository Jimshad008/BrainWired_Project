import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/Failure.dart';




abstract interface class AuthRepository {


  Future<Either<Failure, String>> loginWithEmailAndPassword(
      {required String email,required String password,required BuildContext context});

}