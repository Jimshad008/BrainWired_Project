import '../../domain/entities/user_data.dart';

class UserModel extends UserData{
//<editor-fold desc="Data Methods">
  UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.street,
    required super.suite,
    required super.city,
    required super.zipcode,
    required super.lat,
    required super.log,
    required super.phone,
    required super.website,
    required super.companyName,
    required super.companyCatchPhrase,
    required super.companyBs,
  });







  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ??0,
      name: map['name']??"",
      username: map['username']??"",
      email: map['email']??"",
      street: map['address']['street']??"",
      suite: map['address']['suite']??"",
      city: map['address']['city']??"",
      zipcode: map['address']['zipcode']??"",
      lat: map['address']['geo']['lat']??"",
      log: map['address']['geo']['lng']??"",
      phone: map['phone']??"",
      website: map['website']??"",
      companyName: map['company']['name']??"",
      companyCatchPhrase: map['company']['catchPhrase']??"",
      companyBs: map['company']['bs']??"",
    );
  }

//</editor-fold>
}
