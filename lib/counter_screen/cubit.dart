// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mytodoapp/counter_screen/states.dart';
//
// class CounterCubit extends Cubit<CounterStates>{
//   CounterCubit():super (CounterIntialState());
//   int count=0;
//
// static CounterCubit get(context)=>BlocProvider.of(context);
// void add(){
//   count++;
//  emit( CounterIncreaseState(count));
// }
//   void minus(){
//     count--;
//   emit(  CounterDecreaseState(count));
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/counter_screen/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit():super(CounterIntialState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int count=0;
  void minus(){
    count--;
    emit(CounterDecreaseState());
  }
  void plus
      (){
    count++;
    emit(CounterIncreaseState());
  }
}