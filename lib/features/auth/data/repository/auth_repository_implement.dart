

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/Failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSource/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({required String email,required String password,required BuildContext context}) async {
    try {
      final userId = await authRemoteDataSource.loginWithEmailAndPassword(context: context,
           email: email,password: password);

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

}