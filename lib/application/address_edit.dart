import 'package:appdir/bloc/address_cubit.dart';
import 'package:appdir/bloc/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddressEditPage extends StatelessWidget{
  AddressEditPage({this.id});
  String? id;

  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: (_) => AddressCubit(),
          child: AddressEditView(id: this.id),

    );
  }


}

class AddressEditView extends StatelessWidget {

  var uuid = Uuid();
  AddressEditView({
    Key? key,
    this.id,
  }) : super(key: key) {
  }
  final String? id;
  String optionSelected = '-';
  @override
  Widget build(BuildContext context) {
    if(this.id != null) {
      context.read<AddressCubit>().findAddress(this.id!!);
    }
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Form(
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(id == null ? 'Create Address' : 'Edit Address'),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  if (Form.of(context)!.validate()) {
                    if( this.id == null) {
                      context.read<AddressCubit>().addAddress();
                    } else {
                      context.read<AddressCubit>().updateAddress();
                    }
                    Navigator.pop(context);
                   }
                },
                icon: const Icon(Icons.save),
                label: Text( id == null ? 'Save': 'Editar'),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              body: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                children: [
                  TextFormField(
                    initialValue: state.address.name,
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
                    initialValue: state.address.street,
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
                    initialValue: state.address.numberOf,
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
                    initialValue: state.address.postalCode,
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
                  Row(children: [
                    Text("State: "),
                    Text(state.address.nameState == null? "":state.address.nameState.toString())
                  ],),
                  const SizedBox(height: 16),
                  Row(children: [
                    Text("Municipality: "),
                    Text(state.address.municipality == null ? "": state.address.municipality.toString() )
                  ],),
                  const SizedBox(height: 16),
                  Row(children: [
                    Text("Settlement: "),
                    DropdownButton<String>(
                      // Step 3.
                      value: state.address.settlement,
                      // Step 4.
                      items: state.settlementList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {

                        context.read<AddressCubit>().changeSettlementList(newValue);
                        // setState(() {
                        //   dropdownValue = newValue!;
                        // });
                      },
                    )
                  ],),
                  id != null ? ElevatedButton(
                    onPressed: () {
                      context.read<AddressCubit>().deleteAddres();

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
