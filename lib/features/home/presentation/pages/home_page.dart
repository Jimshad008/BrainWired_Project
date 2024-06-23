import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/common/loader.dart';
import '../../../../core/constant/theme_bool/bloc/theme_bool_bloc.dart';
import '../../../../core/utils/logout_alert.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/home_bloc.dart';
import '../widgets/user_view.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchVideo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title:     BlocBuilder<ThemeBoolBloc,bool>(builder: (context, state) {
          return Row(
            children: [
              SizedBox(
                child: Center(
                  child: AdvancedSwitch(
                    height: height*0.035,
                    width: width*0.17,
                    initialValue: state,
                    onChanged: (value) async {

                      final SharedPreferences local=await SharedPreferences.getInstance();
                      local.setBool("theme", value);
                      context.read<ThemeBoolBloc>().add(ThemeBoolChange(theme: value));
                    },
                    inactiveChild: Icon(Icons.dark_mode),
                    activeChild: Icon(Icons.light_mode),
                  ),
                ),
              ),
            ],
          );
        },),
        actions: [

          GestureDetector(
            onTap: () {
              showLogoutDialog(context);
            },
              child: Icon(Icons.logout,color: Theme.of(context).hintColor,)),
          SizedBox(width: width*0.03,),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Loader();
            }
            if (state is HomeSuccess) {

              return Container(
                height: height,
                width: width,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(width*0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome !",style: TextStyle(
                fontWeight: FontWeight.bold,fontFamily: "Montserrat",
                fontSize: width*0.08
                ),
                              ),
                              SizedBox(height: height*0.01,),
                              Text("BrainWired...",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontFamily: "Montserrat",
                                  fontSize: width*0.07
                              ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width*0.25,
                            child:Image.asset("assets/brainwierd-transparent.png",fit: BoxFit.contain,),

                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                         viewportFraction:0.65,

                        height: height*0.5,


                      enlargeCenterPage: true),
                      items:List.generate(state.success.length, (index) => Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 300),
                              pageBuilder: (context, animation, secondaryAnimation) {
                              return ScaleTransition(
                              scale: animation,
                              child: UserView(userModel:state.success[index] ),
                              );
                              }
                              ));

                            },
                            child: Container(
                                width: width*0.8,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(tileMode: TileMode.mirror,
                                        colors: [Color(0xFF089446),Color(0xFF565759),]),
                                    borderRadius: BorderRadius.circular(width*0.04)
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:  EdgeInsets.all(width*0.03),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('#${state.success[index].id}', style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                                        SizedBox(height: height*0.02,),
                                        Container(
                                          width:width*0.56,
                                          height: height*0.3,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(image: AssetImage("assets/profile.jpg"),fit: BoxFit.cover),
                                              borderRadius: BorderRadius.circular(width*0.04)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02,),
                                        FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: AlignmentDirectional.topStart,
                                            child: Text(state.success[index].name, style: TextStyle(fontSize: width*0.06,fontWeight: FontWeight.bold),)),
                                        FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: AlignmentDirectional.topStart,
                                            child: Text(state.success[index].email, style: TextStyle(fontSize: width*0.04,fontWeight: FontWeight.bold),)),
                                        FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: AlignmentDirectional.topStart,
                                            child: Text(state.success[index].companyName, style: TextStyle(fontSize: width*0.055,fontWeight: FontWeight.bold),)),

                                      ],
                                    ),
                                  ),
                                )
                            ),
                          );
                        },
                      ))
                      // (state.success).map((i) {
                      //   return ;
                      // }).toList(),
                    ),
                    const SizedBox()
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is HomeFailure) {
              showSnackBar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
