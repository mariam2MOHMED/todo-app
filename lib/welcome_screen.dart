import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytodoapp/theme.dart';
import 'package:mytodoapp/todo-app.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondarycolor,
        centerTitle: true,
        title: Text("Todo App"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 450.h,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/7e/92/35/7e92355b0cfb3cf72ea27c89be3d8214.jpg')),
          ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.secondarycolor
            ),
            child: TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder:
    (context)=>TodoApp()));
            }, child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Orgnize tour time",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),),
            )),
          ).animate().fade(
            duration: 500.ms,
          )

        ],
      ),
    );
  }
}
