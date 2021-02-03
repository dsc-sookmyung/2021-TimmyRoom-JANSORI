import 'package:flutter/material.dart';

class YearMonthPicker extends StatefulWidget {
  @override
  _YearMonthPickerState createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  String year, month, yearMonthDay, yearMonthDayTime;
  TextEditingController yController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController ymdController = TextEditingController();
  TextEditingController ymdtController = TextEditingController();
  bool autovalidate = false;

  yearMonthDayTimePicker() async {
    final year = DateTime.now().year;
    String hour, min;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),
    );

    if (dateTime != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }

        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }

        ymdtController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }

  submit() {
    setState(() => autovalidate = true);

    if (!_fKey.currentState.validate()) {
      return;
    }

    _fKey.currentState.save();

    print('year: $year, month: $month');
    print('year-month-day: $yearMonthDay');
    print('year-month-day-time: $yearMonthDayTime');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _fKey,
        autovalidate: autovalidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: yearMonthDayTimePicker,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: ymdtController,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    decoration: InputDecoration(
                      labelText: '집중 타임(시간)을 선택해주세요',
                      labelStyle: TextStyle(
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(4, 4, 7, 0.7),
                        ),
                      ),
                      filled: false,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(56, 110, 218, 1)),
                      ),
                    ),
                    onSaved: (val) {
                      yearMonthDayTime = ymdtController.text;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Year-Month-Date-Time is necessary';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              // submit 버튼
              /*
              SizedBox(height: 10.0),
              MaterialButton(
                onPressed: submit,
                color: Colors.indigo,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'Year Picker',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
               */
            ],
          ),
        ),
      ),
    );
  }
}