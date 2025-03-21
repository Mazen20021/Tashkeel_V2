// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashkeelremake/Mobile/Config/Cubit.dart';
import 'package:tashkeelremake/Mobile/Config/States.dart';
import 'package:tashkeelremake/Mobile/Constants/AppColors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tashkeelremake/Mobile/Pages/Info.dart';
import 'package:tashkeelremake/Mobile/Pages/Login.dart';
import 'package:tashkeelremake/Mobile/Pages/MainPage.dart';
import 'package:tashkeelremake/Mobile/Pages/SettingsPage.dart';
import 'package:tashkeelremake/Mobile/Pages/Signup.dart';
import 'package:tashkeelremake/Mobile/Pages/TranslatePage.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

 

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenSize = screenHeight * screenWidth;

  return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()), 
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, states) {
          AppCubit appParams = AppCubit.get(context);
          
          return Scaffold(
            backgroundColor: ConstAppColors.backgroundDarkColor,
            appBar: AppBar(
              leading: 
                 IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, icon: Icon(Icons.logout_rounded , color: ConstAppColors.backgroundDarkColor, size: 35,)),
              backgroundColor: ConstAppColors.cardMainColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Text( "عن التطبيق", style: GoogleFonts.blaka(color: ConstAppColors.backgroundDarkColor , fontSize: 35),),
                         appParams.showTabs ? SizedBox(width: 50,):SizedBox(width: 70,),
                         GestureDetector(
                          onTap: () {
                            appParams.showAllTabs(context);
                            appParams.initializePages(context , 3 );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ConstAppColors.cardMainColor,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return RotationTransition(turns: animation, child: child);
                              },
                              child: Icon(
                                appParams.showTabs
                                    ? Icons.more_vert_rounded
                                    : Icons.more_horiz_rounded,
                                key: ValueKey<bool>(appParams.showTabs), // Ensures switch animation
                                size: 35,
                                color: ConstAppColors.backgroundDarkColor,
                              ),
                            ),
                          ),
                        ),
                   appParams.showTabs ? SizedBox(width: 20,):SizedBox()
                ],
              ),
            ),
            body: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 150), 
                         Container(
                          width: screenWidth ,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ConstAppColors.cardMainColor,
                          ),
                          child: Column(children: [
                            Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text("فريق العمل", style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 30),),
                                  ),
                                  Divider(color: ConstAppColors.backgroundDarkColor,thickness: 10,height: 10,),
                                 Padding(
                                     padding: const EdgeInsets.only(top: 0,bottom: 10),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                        SizedBox(height: 10,),
                                         Center(
                                           child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               Text("م: مازن أحمد عبد الخالق" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 15),),
                                               SizedBox(width: 25),
                                               Text("م: عمر علاء الدين" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 15),),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Center(
                                           child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               Text("م: محمد صالح" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 15),),
                                               SizedBox(width: 25),
                                               Text("م: أحمد محمد الديري  " , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 15),),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   Divider(color: ConstAppColors.backgroundDarkColor,thickness: 10,height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.only(top: 0,bottom: 10),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Center(
                                           child: Text("عن التطبيق" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 25),),
                                         ),
                                         SizedBox(height: 10,),
                                         Center(
                                           child: Text("هذا التطبيق الإصدار 1.0 لتشكيل اللغة العربية " , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 15),),
                                         ),
                                       ],
                                     ),
                                   ),
                                ],
                              ),
                            )
                          ],)
                        ),         

                         Padding(
                           padding: const EdgeInsets.only(top: 150 , bottom: 10),
                           child: Positioned(
                            bottom: 0,
                             child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ConstAppColors.cardMainColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 12),
                                    color: const Color.fromARGB(141, 0, 0, 0))
                                ]
                              ),
                               child: Image.asset(
                                  'assets/image/logov2.png',
                                 width: 100,
                                height: 100,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: 5.5,),
                         Positioned(
                          bottom: 0,
                           child: Container(
                             width: screenWidth,
                             height: 60,
                             decoration: BoxDecoration(
                               boxShadow: [
                               BoxShadow(
                                 blurRadius: 10,
                                 color: Colors.black,
                                 offset: Offset(0, 5)
                               )
                             ],
                               borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(colors:  [
                                 ConstAppColors.cardMainColor,
                                 ConstAppColors.cardBackColor
                               ],
                               begin: Alignment.topLeft,
                               end: Alignment.bottomRight
                               ),
                             ),
                             child: Positioned(
                               bottom: 0,
                               child: Center(child: Text("اللغة العربية كما يجب أن تكون",
                                                            style: GoogleFonts.blaka(
                                                           color: ConstAppColors.backgroundDarkColor,
                                                           fontSize: 40,
                                                           ),),
                               ),
                             )),
                         ),
                       
                      ],
                    ),
                    if (appParams.showTabs) 
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            color:const Color.fromARGB(255, 33, 31, 37).withOpacity(0.65),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  appParams.changeSelection("TSH");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                                },
                                child: buildOption(
                                  Icons.edit_note_rounded,
                                  "تشكيل",
                                  appParams.tashkeelChosen ? Colors.blueAccent : ConstAppColors.backgroundDarkColor,
                                  appParams.tashkeelChosen ? Colors.white : ConstAppColors.cardMainColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  appParams.changeSelection("TRS");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TransplatePage()));
                                },
                                child: buildOption(
                                  Icons.translate_rounded,
                                  "ترجمة",
                                  appParams.translateChosen ? Colors.blueAccent : ConstAppColors.backgroundDarkColor,
                                  appParams.translateChosen ? Colors.white : ConstAppColors.cardMainColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  appParams.changeSelection("SET");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                                },
                                child: buildOption(
                                  Icons.settings,
                                  "إعدادات",
                                  appParams.settingsChosen ? Colors.blueAccent : ConstAppColors.backgroundDarkColor,
                                  appParams.settingsChosen ? Colors.white : ConstAppColors.cardMainColor,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                  appParams.changeSelection("INFO");
                                },
                                child: buildOption(
                                  Icons.info_outline_rounded,
                                  " معلومات",
                                  appParams.infoChosen ? Colors.blueAccent : ConstAppColors.backgroundDarkColor,
                                  appParams.infoChosen ? Colors.white : ConstAppColors.cardMainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                            ],
                          ),
                        );

            }, listener: (BuildContext context, AppStates state) {},),);
      }
  }
  Widget buildOption(IconData icon, String text , Color backgroundColor , Color textColor) {
    return Container(
      width: 110,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: textColor, fontSize: 18)),
        ],
      ),
    );
  }
