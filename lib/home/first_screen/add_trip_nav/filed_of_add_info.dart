import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiledOfAddInfo extends StatelessWidget {
   TextEditingController dateController;
   TextEditingController timeController;
   FiledOfAddInfo(this.dateController,this.timeController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                height: 45,
                child: TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                      labelText: "حدد المكان",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                ),
              ),
            ),
            SizedBox(width: 5,),
            Image.asset("assets/Component1.png"),
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                height: 45,
                child: TextFormField(
                  onTap: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate:DateTime.now() ,
                        lastDate: DateTime.utc(2090)).then((value) {
                      dateController.text=DateFormat.yMMMd().format(value);
                    });
                  },
                  controller: dateController,
                  decoration: InputDecoration(
                      labelText: "حدد الوقت",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                ),
              ),
            ),
            SizedBox(width: 5,),
          ],
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}
