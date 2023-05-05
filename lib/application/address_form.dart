import 'package:flutter/material.dart';
enum SearchType {
  web,
  image,
  news,
  shopping
}

class AddressForm extends StatefulWidget {
  @override
  _ProperFormState createState() => _ProperFormState();
}

class _ProperFormState extends State<AddressForm> {

  final GlobalKey<FormState> _key = GlobalKey();

  final Map<String, dynamic> _contactForm = <String, dynamic> {
    'searchTerm': '',
    'searchType': SearchType.web,
    'safeSearchOn': true
  };

  var _valueDdb = 'a';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
          child: ListView(
              children: [
                TextFormField(
                    initialValue: _contactForm['searchTerm'],
                    decoration: InputDecoration(
                        labelText: 'Search terms',
                        icon: Icon(Icons.contact_mail)
                    ),
                    onChanged: (String value) {

                    }


                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Select option'),
                  value: _valueDdb,
                  items:['a','b', 'c'].map(
                          (e) {
                        return DropdownMenuItem(
                            value: e,
                            child: Text(e));
                      } ).toList(), onChanged: (String? value) {  },
                  ),

              ]
          )
      ),
    );
  }
}

