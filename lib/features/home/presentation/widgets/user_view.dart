import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/user_model.dart';

class UserView extends StatelessWidget {
  final UserModel userModel;
  const UserView({super.key,required this.userModel});
  _launchURL(String url) async {

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> openMap(double latitude, double longitude) async {
    print(latitude);
    print(longitude);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {

      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch $googleUrl';
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

    body:SafeArea(child: Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF089446),Color(0xFF565759),])
      ),
      child: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                          child: Icon(CupertinoIcons.arrow_left)),
                      Text('#${userModel.id}', style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                    ],
                  ),
              SizedBox(height: height*0.02,),

              SizedBox(height: height*0.02,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:width*0.65,
                    height: height*0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/profile.jpg"),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(width*0.04)
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.03,),
              const Text("Personal Detail:"),
              const Divider(thickness: 2,),
              Row(
                children: [
                  Text("Name : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.name, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Username : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.username, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Email : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.email, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Phone : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.phone, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Website : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: GestureDetector(
                        onTap: () {
                          _launchURL("https://${userModel.website}");
                        },
                          child: Text("https://${userModel.website}", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold,color: Colors.blue,decoration: TextDecoration.underline),))),
                ],
              ),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Address:"),
                  GestureDetector(
                    onTap: () {
                      print(userModel.log);
                      print(double.tryParse(userModel.log));
                   openMap(double.parse(userModel.lat),double.parse(userModel.log) );
                    },
                    child: SizedBox(height: height*0.035,
                    child: Image.asset("assets/map.png"),),
                  ),

                ],
              ),
              const Divider(thickness: 2,),
              Row(
                children: [
                  Text("Street : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.street, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Suite : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.suite, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("City : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.city, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("ZipCode : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.zipcode, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              SizedBox(height: height*0.02,),
              const Text("Company Detail:"),
              const Divider(thickness: 2,),
              Row(
                children: [
                  Text("Name : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.companyName, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(

                children: [
                  Text("Catch Phrase : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: width*0.58,
                      child: Text(userModel.companyCatchPhrase, style: TextStyle(fontSize: width*0.032,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                children: [
                  Text("Bs : ", style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(userModel.companyBs, style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),)),
                ],
              ),
            ],
          ),
        ),
      ),
    )),
    );
  }
}
