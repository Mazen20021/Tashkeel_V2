import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tashkeelremake/Mobile/Config/States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitalSiteStates());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  GlobalKey<FormState> key = GlobalKey();
  int currentIndex = 0;
  bool hidePasseword = true;
  bool hideConfirmPasseword = true;
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController userInputText = TextEditingController();
  final TextEditingController serverOutputText = TextEditingController();
  bool showTabs = false;
  bool tashkeelChosen = false;
  bool translateChosen = false;
  bool infoChosen = false;
  bool settingsChosen = false;
  bool isServerLoading = false;
  String? selectedValue;
  List<String> items = ["English", "العربية", "French", "German" , "Itally"];
  bool itemChanged = false;

  void checkServerStatus(BuildContext context)
  {
    isServerLoading = !isServerLoading;
    emit(CheckServerStatus());
  }
  void changeItems(BuildContext context){
      itemChanged = !itemChanged;
      emit(ChangeItem());
  }
  void initializePages(BuildContext context , int num ){
      switch(num){
            case 0 :
              tashkeelChosen = true;
              translateChosen = false;
              settingsChosen = false ;
              infoChosen = false;
            break;
            case 1 :
              tashkeelChosen = false;
              translateChosen = true;
              settingsChosen = false ;
              infoChosen = false;
            break;
            case 2 :
              tashkeelChosen = false;
              translateChosen = false;
              settingsChosen = true ;
              infoChosen = false ;
            break;
            case 3 :
             tashkeelChosen = false;
              translateChosen = false;
              settingsChosen = false ;
              infoChosen = true ;
            break;
    }
  }
  void changeSelection(String name)
  {
    switch (name){
      case "TSH" :
      tashkeelChosen = true;
      translateChosen = false;
      settingsChosen = false;
      infoChosen = false;
      emit(ChooseTashkeel());
      break;
      case "TRS" :
      tashkeelChosen = false;
      translateChosen = true;
      settingsChosen = false;
      infoChosen = false;
      emit(ChooseTranslate());
      break;
      case "SET" :
      tashkeelChosen = false;
      translateChosen = false;
      settingsChosen = true;
      infoChosen = false;
      emit(ChooseSettings());
      break;
      case "INFO":
      tashkeelChosen = false;
      translateChosen = false;
      settingsChosen = false;
      infoChosen = true;
      emit(ChooseInfo());
      break;
    }
  }
  void showAllTabs(BuildContext context)
  {
    showTabs = !showTabs;
    emit(ShowTab());
  }
  void hidePassword(BuildContext context)
  {
    hidePasseword = !hidePasseword;
    emit(HidePassword());
  }
   void hideConfirmPassword(BuildContext context)
  {
    hideConfirmPasseword = !hideConfirmPasseword;
    emit(HideConfirmPassword());
  }
  void updatePage(BuildContext context)
  {
    emit(UpdatePage());
  }
  void appLoading (BuildContext context)
  {
    isLoading = !isLoading;
    emit(AppLoading());
  }
}