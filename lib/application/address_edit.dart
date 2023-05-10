import 'package:appdir/bloc/address_cubit.dart';
import 'package:appdir/bloc/address_state.dart';
import 'package:appdir/domain/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddressEditPage extends StatelessWidget{
  AddressEditPage({this.addressParam});
  Address? addressParam;

  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: (_) => AddressCubit(),
          child: AddressEditView(addressParam: this.addressParam),

    );
  }


}

class AddressEditView extends StatelessWidget {

  var uuid = Uuid();
  AddressEditView({
    Key? key,
    this.addressParam,
  }) : super(key: key) {
  }
  Address? addressParam;
  String optionSelected = '-';
  @override
  Widget build(BuildContext context) {
    if(this.addressParam != null) {
      context.read<AddressCubit>().findAddress(this.addressParam!.id!);
    }
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Form(
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(this.addressParam == null ? 'Create Address' : 'Edit Address'),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  if (Form.of(context)!.validate()) {
                    if( this.addressParam == null) {
                      context.read<AddressCubit>().addAddress();
                    } else {
                      context.read<AddressCubit>().updateAddress();
                    }
                    Navigator.pop(context);
                   }
                },
                icon: const Icon(Icons.save),
                label: Text( this.addressParam == null ? 'Save': 'Editar'),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              body: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                children: [
                  TextFormField(
                    initialValue: addressParam == null? "": addressParam!.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(128),
                    ],
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Name is required' : null,
                    onChanged: (value) =>
                      context.read<AddressCubit>().changeName(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(128),
                    ],
                    initialValue: addressParam == null? "": addressParam!.street,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Street'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Street is required' : null,
                    onChanged: (value) =>
                        context.read<AddressCubit>().changeStreet(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: addressParam == null? "": addressParam!.numberOf,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Number'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Number is required' : null,
                    onChanged: (value) =>
                        context.read<AddressCubit>().changeNumber(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                    ],
                    initialValue: addressParam == null? "": addressParam!.postalCode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Postal Code'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Postal Code is required' : null,
                    onChanged: (value) {
                      if(value.length>=5) {
                        context.read<AddressCubit>().getDataSource(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(children: [
                        Text("State: ", style: TextStyle(fontSize: 12),),
                        Text(state.address.nameState == null? "":state.address.nameState.toString())
                      ],),
                      Column(children: [
                        Text("Municipality: ", style: TextStyle(fontSize: 12),),
                        Text(state.address.municipality == null ? "": state.address.municipality.toString() )
                      ],),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(children: [
                    Text("Settlement: "),
                    DropdownButton<String>(
                      value: state.address.settlement,
                      items: state.settlementList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        context.read<AddressCubit>().changeSettlementList(newValue);
                      },
                    )
                  ],),
                  const SizedBox(height: 16),
                 Row(
                   children: [
                     Text("Default Address:"),
                     Checkbox(
                        checkColor: Colors.white,
                        value: state.address.checkedBy == null ? false: state.address.checkedBy,
                        onChanged: (bool? value) {
                          context.read<AddressCubit>().changeDefaultAddress(value);
                        },
                     ),
                   ],
                 ),
                  this.addressParam != null ? ElevatedButton(
                    onPressed: () {
                      context.read<AddressCubit>().deleteAddres();
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ): const SizedBox(height: 0)
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
