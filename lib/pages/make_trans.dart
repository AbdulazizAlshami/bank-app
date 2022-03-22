import 'dart:ffi';

import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/sqlite_repository.dart';
import '../model/my_transaction.dart';
import '../widgets/app_large_text.dart';

class MakeTrans extends StatefulWidget {
  const MakeTrans({Key? key}) : super(key: key);

  @override
  _MakeTransState createState() => _MakeTransState();
}

class _MakeTransState extends State<MakeTrans> {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black54,
    primary: Colors.blue,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
  TextEditingController? controller = TextEditingController();
  String? phone;

  final ContactPicker _contactPicker = new ContactPicker();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              AppLargeText(
                text: "Amount of money:",
                size: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller:  controller,
                  textAlign: TextAlign.center,
                  //maxLength: 50,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26, width: 2.0),
                    ),
                    hintText: "Enter a number",
                    icon: Icon(Icons.numbers),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AppLargeText(
                text: "Transfer the money to:",
                size: 30,
              ),
              Expanded(
                child:  Container(
                  margin: EdgeInsets.only(left: 80, right: 80),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new MaterialButton(
                        color: Colors.blue,
                        child: new Text("Choose a phone number:"),
                        onPressed: () async {
                          Contact contact = await _contactPicker.selectContact();
                          setState(() {

                            phone = contact.phoneNumber.number.toString();
                          });
                        },
                      ),
                      new Text(
                        phone == null ? 'No contact selected.' : phone??'',
                      ),
                    ],
                  ),
                ),
              ),
              //ResponsiveButton(),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 22, right: 22, bottom: 200),
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                     //print('phone number is: $phone amount is: ${controller?.text}');
                     final repository = SqliteRepository();
                     if(controller?.text != null && phone != null)
                     repository.insertTransaction(MyTransaction(id: 0, amount: double.parse(controller!.text), phone: phone!));
                    },
                    child: Text('OK'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
