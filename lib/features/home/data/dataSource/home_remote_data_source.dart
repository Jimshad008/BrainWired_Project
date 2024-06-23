import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../model/user_model.dart';
abstract interface class HomeRemoteDataSource {
  Future<List<UserModel>> fetchData();

}
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  @override
  Future<List<UserModel>>fetchData() async {


    try {
     List<UserModel> result=[];
      const String apiUrl =
          'https://jsonplaceholder.typicode.com/users';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        for(var i in jsonData){
         result.add(UserModel.fromMap(i));
        }

        return result;
      } else {
        throw const ServerException( message: 'Failed to load data');
      }

    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}