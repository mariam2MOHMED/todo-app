import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytodoapp/theme.dart';

import '../component.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(

      listener: (context,state){},
      builder:  (context,state){
        var tasks=AppCubit.get(context).doneTasks;
        return       ListView.separated(itemBuilder: (context,index){
          print('task status ${tasks[index]['status']}');
          return buildTaskItem(tasks[index],context);},
            separatorBuilder:  (context,index)=>Container(
              width: MediaQuery.sizeOf(context).width,
              height: 3.h,
              color: AppColor.quantarycolor,
            ),
            itemCount: tasks.length).animate().fade(
          duration: 700.ms ,
        );

      },
    );
  }
}
