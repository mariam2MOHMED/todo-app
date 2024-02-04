import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/cubit/cubit.dart';
import 'package:mytodoapp/models/archived.dart';
import 'package:mytodoapp/models/done_tasks.dart';
import 'package:mytodoapp/models/new_tasks.dart';
import 'package:mytodoapp/theme.dart';
import 'package:sqflite/sqflite.dart';

import 'component.dart';
import 'cubit/states.dart';
// i hope it will done

//me as
class TodoApp extends StatelessWidget {

  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();


  var titlecontroller=TextEditingController();
  var timecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  var statuscontroller=TextEditingController();
  var desccontroller=TextEditingController();
  var categorycontroller=TextEditingController();
  @override
  // void initState() {
  //   // TODO: implement initState
  //   createDatabase();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (BuildContext context,AppState state){
          if(state is AppInsertIntoDatabaseState){
            Navigator.pop(context);
          }
        },
        builder:  (BuildContext context,AppState state){
         return        Scaffold(
           key: scaffoldkey,
           appBar: AppBar(
             backgroundColor: AppColor.secondarycolor,
             centerTitle: true,
             title: Text("${AppCubit.get(context).title[AppCubit.get(context).currindex]}",style:  TextStyle(
                 fontSize: 24.sp,
                 color: Colors.white
             ),),
           ),
           floatingActionButton:
           FloatingActionButton(
             backgroundColor: AppColor.secondarycolor,
             onPressed: (){

               if (AppCubit.get(context).isBottomSheet){
                 if(formkey!.currentState!.validate()){
                   AppCubit.get(context).insertToDatabase(title: titlecontroller.text,
                       time: timecontroller.text,
                       date: datecontroller.text,
                       desc: desccontroller.text, cat: categorycontroller.text);
                   // insertToDatabase(
                   //     title: titlecontroller.text,
                   //     desc:desccontroller.text ,
                   //     time: timecontroller.text,
                   //     date: datecontroller.text
                   // ).then((value) {
                   //   getDataFromDatbase(database).then((value) {
                   //     Navigator.pop(context);
                   //     isBottomSheet=false;
                   //     // setState(() {
                   //     //   tasks=value;
                   //     //   fabIcon=Icons.edit;
                   //     // });
                   //
                   //     print("tasks from database ${tasks}");
                   //   });
                   //
                   //
                   // });

                 }

               }else{
                 scaffoldkey!.currentState?.showBottomSheet((context)
                 =>

                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Form(
                         key: formkey,
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             TextFormField(
                               keyboardType: TextInputType.text,
                               controller: titlecontroller,
style: TextStyle(
  color: Colors.black
),
                               decoration: InputDecoration(
                                   labelText: 'Title',

                                   floatingLabelStyle: TextStyle(
                                     color: Colors.black
                                   ),
                                   fillColor: Colors.black,
                                   helperStyle: TextStyle(
                                      color: Colors.black
                                   ),

                                   hoverColor: Colors.black,
                                   hintStyle: TextStyle(
                                       color: Colors.black
                                   ),
                                   prefixIcon: Icon(Icons.title),
                                   border: OutlineInputBorder()
                               ),

                               validator: (value){
                                 if(value!.isEmpty){
                                   return "title must not be empty ";
                                 }else{
                                   return null;
                                 }
                               },

                             ),
                             ///mara
                             SizedBox(height: 20.h,),
                             TextFormField(
                               keyboardType: TextInputType.text,
                               controller: desccontroller,
                               style: TextStyle(
                                   color: Colors.black
                               ),
                               decoration: InputDecoration(
                                   labelText: 'Description',

                                   labelStyle: TextStyle(
                                       color: Colors.black
                                   ),
                                   hintStyle: TextStyle(
                                       color: Colors.black
                                   ),
                                   prefixIcon: Icon(Icons.description),
                                   border: OutlineInputBorder()
                               ),

                               validator: (value){
                                 if(value!.isEmpty){
                                   return "Description must not be empty ";
                                 }else{
                                   return null;
                                 }
                               },

                             ),
                             SizedBox(height: 20.h,),
                             TextFormField(
                               keyboardType: TextInputType.text,
                               controller: categorycontroller,
                               style: TextStyle(
                                   color: Colors.black
                               ),
                               decoration: InputDecoration(
                                   labelText: 'Category',

                                   labelStyle: TextStyle(
                                       color: Colors.black
                                   ),
                                   hintStyle: TextStyle(
                                       color: Colors.black
                                   ),
                                   prefixIcon: Icon(Icons.category),
                                   border: OutlineInputBorder()
                               ),

                               validator: (value){
                                 if(value!.isEmpty){
                                   return "Description must not be empty ";
                                 }else{
                                   return null;
                                 }
                               },

                             ),
                             SizedBox(height: 20.h,),
                             TextFormField(
                               keyboardType: TextInputType.number,
                               controller: timecontroller,
                               style: TextStyle(
                                   color: Colors.black
                               ),
                               decoration: InputDecoration(

                                 labelText: 'Time Task',
                                 labelStyle: TextStyle(
                                     color: Colors.black
                                 ), hintStyle: TextStyle(
                                   color: Colors.black
                               ),
                                 prefixIcon: Icon(Icons.watch_later_outlined),
                                 border: OutlineInputBorder(),

                               ),
                               onTap: (){
                                 showTimePicker(context: context,
                                     initialTime: TimeOfDay.now()).then((value){
                                   timecontroller.text=value!.format(context).toString();
                                   print("${value!.format(context)}");
                                 });

                               },
                               validator: (value){
                                 if(value!.isEmpty){
                                   return "Time must not be empty ";
                                 }else{
                                   return null;
                                 }
                               },

                             ),
                             SizedBox(height: 20.h,),
                             TextFormField(
                               keyboardType: TextInputType.datetime,

                               controller: datecontroller,
                               style: TextStyle(
                                   color: Colors.black
                               ),
                               decoration: InputDecoration(
                                 labelText: 'Date',
                                 hintStyle: TextStyle(
                                     color: Colors.black
                                 ),
                                 labelStyle: TextStyle(
                                     color: Colors.black
                                 ),
                                 prefixIcon: Icon(Icons.calendar_month),
                                 border: OutlineInputBorder(),

                               ),
                               onTap: (){

                                 showDatePicker(context: context,
                                     initialDate: DateTime.now(),
                                     firstDate: DateTime.now(),
                                     lastDate: DateTime.parse('2024-08-08')).then((value) {
                                   datecontroller.text=DateFormat?.yMMMd().format(value!);
                                   print(DateFormat.yMMMd().format(value!));
                                 });
                               },
                               validator: (value){
                                 if(value!.isEmpty){
                                   return "Data must not be empty ";
                                 }else{
                                   return null;
                                 }
                               },

                             ),

                           ],
                         ),
                       ),
                     )


                 ).closed.then((value) {
                   AppCubit.get(context).changeBottomSheet(isShow: false,
                       iconData: Icons.edit);
                 });
                 AppCubit.get(context).changeBottomSheet(isShow: true,
                     iconData: Icons.add);
                 // setState(() {
                 //   fabIcon=Icons.add;
                 // });
               }

             },
             child: Icon(AppCubit.get(context).fabIcon,color: Colors.white,),
           ),
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: AppCubit.get(context).currindex,
             onTap: (index){
               AppCubit.get(context).changeNav(index);

               AppCubit.get(context).currindex=index;
               // setState(() {
               //   currindex=index;
               // });
             },
             type: BottomNavigationBarType.fixed,
             selectedItemColor: AppColor.secondarycolor,
             items: [
               BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Tasks'),
               BottomNavigationBarItem(icon: Icon(Icons.edit_calendar),label: 'EditTasks'),
               BottomNavigationBarItem(icon: Icon(Icons.check_circle),label: 'Done'),
             ],
           ),
           body: ConditionalBuilder(condition:state is! AppGetDatabaseLoadingState,
               fallback: (context)=>Center(child: CircularProgressIndicator()),
               builder:(context)=> AppCubit.get(context).screens[AppCubit.get(context).currindex]),
           // bottomNavigationBar: BottomNavigationBar(
           //   items: [
           //     BottomNavigationBarItem(
           //       icon: Icon(
           //
           //       ),
           //     ),
           //   ],
           //   ],
           // ),
         );
        },


      ),
    );
  }
  //mkl

}
