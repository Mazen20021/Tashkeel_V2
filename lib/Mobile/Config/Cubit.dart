import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tashkeelremake/Mobile/Config/States.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitalSiteStates());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  GlobalKey<FormState> key = GlobalKey();
  int currentIndex = 0;
  bool hidePasseword = true;

  void hidePassword(BuildContext context)
  {
    hidePasseword = !hidePasseword;
    emit(HidePassword());
  }
}