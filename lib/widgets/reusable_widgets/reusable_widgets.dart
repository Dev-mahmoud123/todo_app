import 'package:flutter/material.dart';
import 'package:todo_app/constants/constant_components.dart';
import 'package:todo_app/shared/bloc_cubit/home_cubit/cubit.dart';

Widget defaultTextField({
  TextEditingController controller,
  TextInputType type,
  Function onChange,
  onSaved,
  validator,
  onTap,
  onFieldSubmitted,
  String label,
  Widget prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onChanged: onChange,
    onSaved: onSaved,
    onTap: onTap,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    direction: DismissDirection.endToStart,
    background: Container(
      color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.centerRight,
      child: Text('Delete' , style: TextStyle(fontSize: 18.0 , color: Colors.white),),
    ),
    onDismissed: (direction) {
      HomeCubit.get(context).deleteData(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey, fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          IconButton(
            onPressed: () {
              HomeCubit.get(context)
                  .updateData(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {
              HomeCubit.get(context)
                  .updateData(status: 'archive', id: model['id']);
            },
            icon: Icon(Icons.archive_rounded),
            color: Colors.black26,
          )
        ],
      ),
    ),
  );
}
