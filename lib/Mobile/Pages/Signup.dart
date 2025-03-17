import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashkeelremake/Mobile/Config/Cubit.dart';
import 'package:tashkeelremake/Mobile/Config/States.dart';
import 'package:tashkeelremake/Mobile/Constants/AppColors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tashkeelremake/Mobile/Pages/Login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenSize = screenHeight * screenWidth;
  return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, states) {
          AppCubit appParams = AppCubit.get(context);
          return Scaffold(
            backgroundColor: ConstAppColors.backgroundDarkColor,
            body: Center(
              child: Transform.translate(
                offset: Offset(0, 55),
                child: Container(
                  width: screenWidth * 0.9,
                  height: appParams.key.currentState?.validate() == true ? screenHeight * 0.55 : (appParams.confirmPasswordController.text == appParams.passwordController.text)? screenHeight * 0.65 : screenHeight * 0.55   ,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(0, 8)
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ConstAppColors.cardMainColor,
                      ConstAppColors.cardBackColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Transform.translate(
                          offset: Offset(0, -380),
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
                              child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("العربية " ,style: GoogleFonts.blaka(color: ConstAppColors.backgroundDarkColor, fontSize: 50),),
                                  SizedBox(width: 140,),
                                   Text("اللغة " ,style: GoogleFonts.blaka(color: ConstAppColors.backgroundDarkColor, fontSize: 50),),
                                ],
                              ),
                              ),
                            )),
                        ),
                      ),
                      Center(
                        child: Transform.translate(
                          offset: Offset(0, -375),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(0, 10)
                              )
                            ],
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(colors:  [
                                ConstAppColors.cardMainColor,
                                ConstAppColors.cardBackColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                    child: Transform.translate(
                    offset: Offset(0, -375),
                    child: Image.asset(
                        'assets/image/logov2.png', // Replace with your logo asset path
                        width: 120, // Adjust the width as needed
                        height: 120, // Adjust the height as needed
                      ),
                  ),
                ),
                      Column(children: [
                         Text(" حساب جديد" , style: GoogleFonts.blaka(color:ConstAppColors.backgroundDarkColor, fontSize: 40 ,),),
                         Divider(color:ConstAppColors.backgroundDarkColor , thickness: 10,),
                         SizedBox(height: 20,),
                         Form(
                          key: appParams.key,
                          child: Column(children: [
                            SizedBox(
                              width: screenWidth * 0.85,
                              child: TextFormField(
                                controller: appParams.emailController,
                                validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return "خطأ في البيانات";
                                  }
                                },
                                  cursorColor: ConstAppColors.mainTextColor,
                                  style: TextStyle(color: ConstAppColors.mainTextColor), 
                                  decoration: InputDecoration(
                                    errorStyle: GoogleFonts.alexandria(
                                      color: ConstAppColors.backgroundDarkColor ,
                                       fontSize: 15 , 
                                       fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(color: ConstAppColors.mainTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: ConstAppColors.backgroundDarkColor,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: ConstAppColors.mainTextColor),
                                    suffixIcon: Icon(Icons.email_rounded,
                                      color: ConstAppColors.mainTextColor,
                                      size: 25,),
                                    hintText: "رقم الهاتف / البريد الإلكتروني",
                                    hintTextDirection: TextDirection.rtl,
                                    fillColor: ConstAppColors.backgroundDarkColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SizedBox(
                              width: screenWidth * 0.85,
                              child: TextFormField(
                                controller: appParams.passwordController,
                                 validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return "خطأ في البيانات";
                                  }
                                },
                                obscureText: appParams.hidePasseword,
                                  cursorColor: ConstAppColors.mainTextColor,
                                  style: TextStyle(
                                    color: ConstAppColors.mainTextColor), 
                                  decoration: InputDecoration(
                                    errorStyle: GoogleFonts.alexandria(
                                      color: ConstAppColors.backgroundDarkColor ,
                                       fontSize: 15 , 
                                       fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(color: ConstAppColors.mainTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: ConstAppColors.backgroundDarkColor,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: ConstAppColors.mainTextColor),
                                    prefixIcon: 
                                    GestureDetector(
                                      onTap: (){
                                        appParams.hidePassword(context);
                                      },
                                    child:Icon(
                                      appParams.hidePasseword ? 
                                      Icons.remove_red_eye_rounded:Icons.visibility_off_rounded,
                                      color: ConstAppColors.mainTextColor,
                                      ),
                                      ),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: ConstAppColors.mainTextColor,
                                      size: 25,
                                    ),
                                    hintText: "كلمـــــة الســــــر",
                                    hintTextDirection: TextDirection.rtl,
                                    fillColor: ConstAppColors.backgroundDarkColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SizedBox(
                              width: screenWidth * 0.85,
                              child: TextFormField(
                                controller: appParams.confirmPasswordController,
                                 validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return "خطأ في البيانات";
                                  }
                                  else if(appParams.passwordController.text != appParams.confirmPasswordController.text)
                                  {
                                    return "كلمة السر غير متطابقة";
                                  }
                                },
                                obscureText: appParams.hideConfirmPasseword,
                                  cursorColor: ConstAppColors.mainTextColor,
                                  style: TextStyle(
                                    color: ConstAppColors.mainTextColor), 
                                  decoration: InputDecoration(
                                    errorStyle: GoogleFonts.alexandria(
                                      color: ConstAppColors.backgroundDarkColor ,
                                       fontSize: 15 , 
                                       fontWeight: FontWeight.bold),
                                    labelStyle: TextStyle(color: ConstAppColors.mainTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: ConstAppColors.backgroundDarkColor,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: ConstAppColors.mainTextColor),
                                    prefixIcon: 
                                    GestureDetector(
                                      onTap: (){
                                        appParams.hideConfirmPassword(context);
                                      },
                                    child:Icon(
                                      appParams.hideConfirmPasseword ? 
                                      Icons.remove_red_eye_rounded:Icons.visibility_off_rounded,
                                      color: ConstAppColors.mainTextColor,
                                      ),
                                      ),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: ConstAppColors.mainTextColor,
                                      size: 25,
                                    ),
                                    hintText: "تأكيد كلمة السـر",
                                    hintTextDirection: TextDirection.rtl,
                                    fillColor: ConstAppColors.backgroundDarkColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: appParams.key.currentState?.validate() == true? 35 : 20,),
                              GestureDetector(
                                onTap: (){
                                  if(appParams.key.currentState?.validate() == true)
                                  {
                                    appParams.updatePage(context);
                                    appParams.appLoading(context);
                                  }
                                },
                                child: Container(
                                  width: screenWidth * 0.85,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black,
                                        offset: Offset(0, 8)
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    color:ConstAppColors.backgroundDarkColor,
                                  ),
                                  child: Center(child: 
                                  appParams.isLoading ? 
                                  LoadingAnimationWidget.staggeredDotsWave(
                                     color: ConstAppColors.cardMainColor,
                                     size: 40,
                                  ):Text("إنشاء حساب جديد" , style: GoogleFonts.alexandria(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.black,
                                        offset: Offset(0, 3)
                                      ),
                                    ],
                                    color:ConstAppColors.cardMainColor, fontSize: 30 , fontWeight: FontWeight.bold))),
                                ),
                              ),
                              SizedBox(height: 45,),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                    },
                                    child: Text("تسجيل الدخول" , style: GoogleFonts.alexandria(
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5,
                                        color: Colors.black,
                                        offset: Offset(0, 0)
                                        )
                                      ],
                                      color: ConstAppColors.backgroundDarkColor , fontSize: 15 , fontWeight: FontWeight.bold),),
                                  ),
                                  
                                  SizedBox(width: 225,),
                                ],),
                              )
                         ],))
                      ],),
                    ],
                  ),
                ),
              ),
            ),
          );
  }, listener: (BuildContext context, AppStates state) { },),);
  }
}