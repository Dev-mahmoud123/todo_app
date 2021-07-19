import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/reusable_widgets/reusable_widgets.dart';

class BottomSheetComponents extends StatelessWidget {
  final TextEditingController titleController, timeController, dateController;

  const BottomSheetComponents(
      {Key key, this.titleController, this.timeController, this.dateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultTextField(
              controller: titleController,
              type: TextInputType.text,
              label: ' Task Title',
              prefixIcon: Icon(Icons.title),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Title must not be empty';
                }
                return null;
              }),
          SizedBox(
            height: 10.0,
          ),
          defaultTextField(
              controller: timeController,
              type: TextInputType.datetime,
              label: 'Task Time',
              prefixIcon: Icon(Icons.watch_later_outlined),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Time must not be empty';
                }
                return null;
              },
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then(
                        (value) => timeController.text = value.format(context));
              }),
          SizedBox(
            height: 10.0,
          ),
          defaultTextField(
              controller: dateController,
              type: TextInputType.datetime,
              label: 'Task Date',
              prefixIcon: Icon(Icons.calendar_today),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Date must not be empty';
                }
                return null;
              },
              onTap: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.parse('2021-12-30'))
                    .then((value) => dateController.text =
                        DateFormat.yMMMEd().format(value));
              }),
        ],
      ),
    );
  }
}
