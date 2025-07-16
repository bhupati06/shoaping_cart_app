import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver{
  @override
  void onEvent (Bloc bloc,Object? event){
    super.onEvent(bloc, event);
    log("${bloc.runtimeType} $event");
  }
  @override
  void onTrasition (Bloc bloc,Transition trasition){
    super.onTransition(bloc, trasition);
    log("$trasition");
  }
  @override
  void onError(BlocBase bloc, Object error,StackTrace stackTrace){
    super.onError(bloc, error, stackTrace);
    log("${bloc.runtimeType} $error");
  }

}