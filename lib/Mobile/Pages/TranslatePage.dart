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

class TransplatePage extends StatelessWidget {
  const TransplatePage({super.key});

 

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
                  
                   Text( "ترجم الكلمات", style: GoogleFonts.blaka(color: ConstAppColors.backgroundDarkColor , fontSize: 35),),
                         appParams.showTabs ? SizedBox(width: 50,):SizedBox(width: 70,),
                         GestureDetector(
                          onTap: () {
                            appParams.showAllTabs(context);
                            appParams.initializePages(context , 1);
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
                        const SizedBox(height: 10), 
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ConstAppColors.cardMainColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12), // Add padding for better spacing
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                style: TextStyle(
                                  color: ConstAppColors.backgroundDarkColor ,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                                dropdownColor: const Color.fromARGB(255, 224, 224, 224).withOpacity(0.9),
                                isExpanded: true, // Ensures the dropdown takes the full width of the container
                                hint: Text("إختر اللغة التي تريد أن تترجم لها"),
                                alignment: Alignment.centerRight,
                                value: appParams.selectedValue,
                                onChanged: (String? newValue) {
                                  appParams.selectedValue = newValue;
                                  appParams.changeItems(context);
                                },
                                items: appParams.items.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10), 
                        Container(
                          width: screenWidth ,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                            color: ConstAppColors.cardMainColor,
                          ),
                          child: TextFormField(
                            controller: appParams.userInputText,
                            enabled:  !appParams.isServerLoading,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              hintText: 'اكتب الجملة',
                              border: InputBorder.none,
                              hintTextDirection: TextDirection.rtl,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[\u0600-\u06FF\s]'),
                              ),
                            ],
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands:
                            true, // This makes the TextFormField expand vertically
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: screenWidth,
                          height: 280,
                        decoration: BoxDecoration(
                          color: ConstAppColors.cardBackColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  appParams.isServerLoading ? 
                                  GestureDetector(
                                    onTap: () { },
                                    child:TextFormField(
                                      enabled: false,
                                      style: GoogleFonts.mada(
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                      controller:appParams.serverOutputText,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.mada(
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                      hintText: appParams.isServerLoading ? '' : 'التشكيل', // Ensure hintText is always a String
                                      suffixIcon: appParams.isServerLoading 
                                          ? LoadingAnimationWidget.staggeredDotsWave(
                                              color: Colors.black,
                                              size: 40,
                                            ) 
                                          : null, // Show the loading animation as suffix
                                        border: InputBorder.none,
                                        hintTextDirection: TextDirection.rtl,
                                      ),
                                      textAlignVertical: TextAlignVertical.top,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),)
                                  : GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: appParams.serverOutputText.text)).then((_) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(
                                              children: [
                                                const Spacer(),
                                                const Icon(Icons.check_circle_outline_rounded , color: Colors.green , size: 35,),
                                                const SizedBox(width: 10,),
                                                Text('تـــم لســـق النـــص' , style: GoogleFonts.alexandria(color: Colors.white , fontSize: 15),),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      );
                                    },
                                    child:TextFormField(
                                      enabled: false,
                                      style: GoogleFonts.mada(
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                      controller:appParams.serverOutputText,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.mada(
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                      hintText: appParams.isServerLoading ? '' : 'الترجمة', // Ensure hintText is always a String
                                      suffixIcon: appParams.isServerLoading 
                                          ? LoadingAnimationWidget.staggeredDotsWave(
                                              color: Colors.black,
                                              size: 40,
                                            ) 
                                          : null, // Show the loading animation as suffix
                                        border: InputBorder.none,
                                        hintTextDirection: TextDirection.rtl,
                                      ),
                                      textAlignVertical: TextAlignVertical.top,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                          offset: Offset(0, -315),
                          child: appParams.isServerLoading ? 
                            GestureDetector(
                            onTap: (){
                              appParams.checkServerStatus(context);
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ConstAppColors.backgroundDarkColor
                              ),
                              child: Icon(Icons.cancel , color: const Color.fromARGB(255, 255, 104, 104),size: 60,),
                            ),
                          )
                          : GestureDetector(
                            onTap: (){
                              appParams.checkServerStatus(context);
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ConstAppColors.backgroundDarkColor
                              ),
                              child: Icon(Icons.translate_rounded , color: ConstAppColors.cardMainColor,size: 60,),
                            ),
                          ),
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
                                  " معلومات",
                                  appParams.infoChosen ? Colors.blueAccent : ConstAppColors.backgroundDarkColor,
                                  appParams.infoChosen ? Colors.white : ConstAppColors.cardMainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                     Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ConstAppColors.cardMainColor,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appParams.isServerLoading ? 
                               GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only(right: 25 , top: 10 , bottom: 10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.signal_cellular_no_sim_rounded , color: Colors.redAccent , size: 35,)),
                                ),
                              ):
                              GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only(right: 25 , top: 10 , bottom: 10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.file_present_rounded , color: Colors.redAccent , size: 35,)),
                                ),
                              ),
                              appParams.isServerLoading ? 
                              GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only( left:  25, right: 25 , top: 10 , bottom: 10),
                                child: Container(
                                   width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.mic_off_rounded, color: const Color.fromARGB(255, 255, 255, 255)  , size: 35,)),
                                ),
                              )
                              :GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only( left:  25, right: 25 , top: 10 , bottom: 10),
                                child: Container(
                                   width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.mic, color: const Color.fromARGB(255, 255, 255, 255)  , size: 35,)),
                                ),
                              ),
                              appParams.isServerLoading ? 
                              GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only( left:  25 , top: 10 , bottom: 10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.no_photography_rounded, color: ConstAppColors.mainTextColor , size: 38,)),
                                ),
                              )
                              :GestureDetector(
                                onTap: (){},
                                child: Padding(padding: EdgeInsets.only( left:  25 , top: 10 , bottom: 10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstAppColors.backgroundDarkColor
                                  ),
                                  child: Icon(Icons.camera_alt_rounded, color: ConstAppColors.mainTextColor , size: 35,)),
                                ),
                              ),
                            ],
                          ),
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