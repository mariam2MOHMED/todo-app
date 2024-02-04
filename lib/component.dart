import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytodoapp/cubit/cubit.dart';

import 'theme.dart';

Widget buildTaskItem(Map model,context)=> Dismissible(
   key: Key(model['id'].toString()),
  onDismissed: (direction){
     AppCubit.get(context).deleteDate(id: model['id']);
  },
  child:   Padding(



    padding: const EdgeInsets.all(10.0),



    child:   Row(



      mainAxisAlignment: MainAxisAlignment.start,



      crossAxisAlignment: CrossAxisAlignment.start,



      children: [



        CircleAvatar(



          radius:40.r ,



          backgroundColor: AppColor.quantarycolor,



          child: Text("${model['time']}",style: TextStyle(



            color: Colors.white,



            fontWeight: FontWeight.bold,



            fontSize: 15.sp,



          ),),



        ),



        SizedBox(width: 20.w,),



        Expanded(



          child: Column(



            mainAxisSize: MainAxisSize.min,



            mainAxisAlignment: MainAxisAlignment.start,



            crossAxisAlignment: CrossAxisAlignment.start,



            children: [







              Text('${model['title']}',style: TextStyle(



                fontSize: 24.sp,



                fontWeight: FontWeight.bold,



                color: Colors.black,



              ),),



              SizedBox(height: 8.h,),



              Text('${model['desc']}',



                maxLines: 3,



                overflow: TextOverflow.ellipsis,



                style: TextStyle(



                  fontSize: 18.sp,



                  fontWeight: FontWeight.bold,



                  color: AppColor.primarycolor,



                ),),
              SizedBox(height: 8.h,),
              Text('${model['cat']}',style: TextStyle(



                fontSize: 18.sp,







                color: AppColor.secondarycolor,



              ),),

              SizedBox(height: 8.h,),



              Text('${model['date']}',style: TextStyle(



                fontSize: 18.sp,







                color: AppColor.secondarycolor,



              ),),




            ],



          ),



        ),



        SizedBox(width: 20.w,),



        IconButton(onPressed: (){



          AppCubit.get(context).editData(title: model['title'],
              time: model['time'],
              date: model['date'],
              desc: model['desc'], cat: model['cat']);



        }, icon: Icon(Icons.edit,color: AppColor.quantarycolor,)),



        SizedBox(width: 5.w,),



        IconButton(onPressed: (){



          AppCubit.get(context).updateDate(status: 'done',



              id: model['id']);



        }, icon: Icon(Icons.check_box_sharp,







          color: AppColor.quantarycolor,)),



      ],



    ),



  ),
);
