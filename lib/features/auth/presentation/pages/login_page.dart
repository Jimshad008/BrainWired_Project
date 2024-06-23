
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/common/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    // Perform custom password validation here
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one numeric character";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()<>?/|}{~:]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  _launchURL() async {
    var url = "https://www.brainwired.in/terms-and-conditions";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisibility=true;
  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      

      body: SafeArea(
        child: BlocConsumer<AuthBloc,AuthState>(builder: (context, state) {
          if(state is AuthLoading){
            return const Loader();
          }
         return  SingleChildScrollView(
           physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Container(
                width: width,
                height: height,
                color:  Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(right: width*0.05,left: width*0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        width: width*0.5,
                        height: height*0.4,
                        child:Image.asset("assets/brainwierd.png",fit: BoxFit.contain,),

                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: width*0.02),
                        child: SizedBox(
                          width: width,
                          child: Text(
                            "Enter Email",style: TextStyle(
                              fontWeight: FontWeight.bold,fontFamily: "Montserrat",
                              fontSize: width*0.05
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      SizedBox(
                        width: width*0.9,
                        height: height*0.08,
                        child: TextFormField(
                          validator: (value) {
                            return  validateEmail(value);
                          },
                          cursorColor: Colors.grey,


                          controller: email,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Theme.of(context).hintColor,
                              fontSize: width*0.035,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: 'Enter Email *',
                            hintStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Theme.of(context).hintColor,

                              fontSize: width*0.035,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF565759),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF565759),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                color:Color(0xFF089446),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                          ),
                          style:TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Theme.of(context).hintColor,
                            fontSize: width*0.035,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: width*0.02),
                        child: SizedBox(
                          width: width,
                          child: Text(
                            "Enter Password",style: TextStyle(
                              fontWeight: FontWeight.bold,fontFamily: "Montserrat",
                              fontSize: width*0.05
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      SizedBox(
                        width: width*0.9,
                        height: height*0.08,
                        child: TextFormField(

                          validator: (value) {
                            return validatePassword(value);
                          },
                          cursorColor: Colors.grey,


                          controller: password,
                          obscureText: passwordVisibility,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passwordVisibility=!passwordVisibility;
                                });
                              },
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0xFF757575),
                                size: width*0.04,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Theme.of(context).hintColor,
                              fontSize: width*0.035,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: 'Enter Password *',
                            hintStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Theme.of(context).hintColor,

                              fontSize: width*0.035,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF565759),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF565759),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                color:Color(0xFF089446),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                          ),
                          style:TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Theme.of(context).hintColor,
                            fontSize: width*0.035,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width*0.9,
                        height: height*0.05,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("By Continuing, I agree to Brainwired ",style: TextStyle(fontSize: width*0.031),),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL();
                                  },
                                    child: Text(" Terms and condition ",style: TextStyle(fontSize: width*0.031,color: Colors.lightBlueAccent))),
                                Text("&",style: TextStyle(fontSize: width*0.031))

                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL();
                              },
                                child: Text("privacy policy",style: TextStyle(fontSize: width*0.031,color: Colors.lightBlueAccent),))
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      GestureDetector(
                        onTap: () {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLogin(email: email.text.trim(), context: context, password: password.text.trim()));
    }
                        },
                        child: Container(
                          width: width*0.9,
                          height: height*0.07,
                          decoration: BoxDecoration(
                           gradient: const LinearGradient(colors: [Color(0xFF565759),Color(0xFF089446)]),
                              borderRadius: BorderRadius.circular(width*0.08)
                          ),
                          child: Center(child: Text("Login",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold,fontFamily: "Montserrat",),)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            showSnackBar(context, "Login Successful!");
            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const HomePage(),), (route) => false);
            // telephony.requestSmsPermissions;


          }
        },),


      ),
    );
  }
}
