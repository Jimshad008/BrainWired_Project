import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  });


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  const AuthRemoteDataSourceImpl();

  @override
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext  context
  }) async {
    try {


      final SharedPreferences local=await SharedPreferences.getInstance();
      String? a=local.getString(email);
      if(a==null){
        local.setString(email, password);

          local.setString("rememberMe", email);
        return "";

      }
      else{
        if(a==password){

            local.setString("rememberMe", email);

          return "";
        }
        else{
          throw const ServerException(message: "Incorrect Password,user already Exist");

        }
      }

      // return "";
    }
    catch (e) {
      throw ServerException(message: e.toString());
    }
  }


}
