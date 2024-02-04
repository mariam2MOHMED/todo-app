// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mytodoapp/counter_screen/cubit.dart';
// import 'package:mytodoapp/counter_screen/states.dart';
//
// class CounterScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//
//         create: (BuildContext context) => CounterCubit(),
//         child: BlocConsumer<CounterCubit, CounterStates>(
//           listener: (context, state) {
//             if(state is CounterIncreaseState){
//               print('Plus State');
//             }   if(state is CounterDecreaseState){
//               print('Minus State');
//             }
//           },
//           builder: (context, state) {
//             return
//               Scaffold(
//                 body: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextButton(onPressed: () {
//                         CounterCubit.get(context).add();
//                       }, child: Text("Add")),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0,right: 10.0),
//                         child: Text("${CounterCubit.get(context).count}"
//                           , style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),),
//                       ),
//                       TextButton(onPressed: () {
//                         CounterCubit.get(context).minus();
//                       }, child: Text("Minus")),
//                     ],
//                   ),
//                 ),
//               );
//           }
//           ,
//         )
//
//     );
//   }
//
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytodoapp/counter_screen/cubit.dart';
import 'package:mytodoapp/counter_screen/states.dart';
import 'package:mytodoapp/theme.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,static){},
        builder:(context,static){
          return   Scaffold(
            body: Center(
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(

                      onPressed: (){
    CounterCubit.get(context).plus();
                      }, child: Text("Add",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),)),
                  SizedBox(width: 20.w,),
                  Text('${CounterCubit.get(context).count}',style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width: 20.w,),
                  TextButton(onPressed: (){
    CounterCubit.get(context).minus();
                  }, child: Text("Minus",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),)),
                ],
              ),
            ),    );
        } ,


      ),
    );
  }
}
