import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:todo_app/widgets/bott_sheet_components.dart';
import '../shared/bloc_cubit/state.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..createDatabase(),
      child: BlocConsumer<HomeCubit, AppState>(
          listener: (BuildContext context, state) {
        if (state is AppInsertDatabaseState) {
          Navigator.of(context).pop();
        }
      }, builder: (BuildContext context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'Archived',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fatIcon),
              onPressed: () {
                if (cubit.isBottomSheet) {
                  if (formKey.currentState.validate()) {
                    cubit
                        .insertToDatabase(
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text)
                        .then((value) {
                      titleController.clear();
                      timeController.clear();
                      dateController.clear();
                    });
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                          (context) => Form(
                                key: formKey,
                                child: BottomSheetComponents(
                                  titleController: titleController,
                                  timeController: timeController,
                                  dateController: dateController,
                                ),
                              ),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetIcon(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetIcon(isShow: true, icon: Icons.add);
                }
              }),
        );
      }),
    );
  }
}
