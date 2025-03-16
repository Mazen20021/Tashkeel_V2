// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashkeelremake/Mobile/Config/Cubit.dart';
import 'package:tashkeelremake/Mobile/Config/States.dart';
import 'package:tashkeelremake/Mobile/Constants/AppColors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                   Text( "عن البرنامج", style: GoogleFonts.blaka(color: ConstAppColors.backgroundDarkColor , fontSize: 35),),
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
                        const SizedBox(height: 35), 
                         Container(
                          width: screenWidth ,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            color: ConstAppColors.cardMainColor,
                          ),
                          child: Column(children: [
                            Center(
                              child: Column(
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, -20),
                                    child: Icon(Icons.info_sharp , color: ConstAppColors.backgroundDarkColor,size: 100,)),
                                  Text("فريق العمل ", style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 30),),
                                  SizedBox(height: 10,),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text("م: عمر علاء الدين" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(" م: مازن أحمد عبدالخالق" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                  ],),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 26),
                                        child: Text(" م: محمد صالح " , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 1),
                                        child: Text("م: أحمد محمد الديري " , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                  ],),
                                ],
                              ),
                            )
                          ],)
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: screenWidth ,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                            color: ConstAppColors.cardMainColor,
                          ),
                          child: Column(children: [
                            Center(
                              child: Column(
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, -20),
                                    child: Icon(Icons.supervised_user_circle_rounded , color: ConstAppColors.backgroundDarkColor,size: 100,)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("test1@test.com" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(" : البريد الإليكتروني" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                  ],),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: (){}, icon: Icon(Icons.change_circle_rounded , color: ConstAppColors.backgroundDarkColor , size: 30,)),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("0041212514" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(" :  كلمـــــــة الســـــــر" , style: GoogleFonts.alexandria(color: ConstAppColors.backgroundDarkColor , fontSize: 20),),
                                      ),
                                  ],),
                                ],
                              ),
                            )
                          ],)
                        ),
                         Transform.translate(
                          offset: Offset(0, 10),
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
                                'assets/image/logo v2.png',
                               width: 150,
                              height: 150,
                             ),
                           ),
                         ),
                         Transform.translate(
                          offset: Offset(0, 30),
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
                              borderRadius: BorderRadius.circular(10),
                               gradient: LinearGradient(colors:  [
                                ConstAppColors.cardMainColor,
                                ConstAppColors.cardBackColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                              ),
                            ),
                            child: Transform.translate(
                              offset: Offset(0, -5),
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
                      Transform.translate(
                       offset: Offset(293, 0),
                        child:  Container(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InfoPage()));
                                },
                                child: buildOption(
                                  Icons.info_outline_rounded,
                                  " البرنامج",
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
