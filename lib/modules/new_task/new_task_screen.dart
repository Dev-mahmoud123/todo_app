import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:todo_app/shared/bloc_cubit/state.dart';
import 'package:todo_app/widgets/reusable_widgets/reusable_widgets.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = HomeCubit.get(context).newTasks;
        if (tasks.length > 0) {
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemCount: tasks.length,
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                color: Colors.black45,
                size: 50.0,
              ),
              Text(
                'No Tasks yet , Please Add new Tasks',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black45),
              ),
            ],
          ),
        );
      },
    );
  }
}
