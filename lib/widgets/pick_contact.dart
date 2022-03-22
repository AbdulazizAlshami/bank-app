import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';

class PickContact extends StatefulWidget {
  const PickContact({Key? key}) : super(key: key);

  @override
  _PickContactState createState() => _PickContactState();
}

class _PickContactState extends State<PickContact> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact? _contact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      _contact = contact;
                    });
                  },
                ),
                new Text(
                  _contact == null ? 'No contact selected.' : _contact.toString(),
                ),
              ],
            ),
          ),
    );
  }
}
