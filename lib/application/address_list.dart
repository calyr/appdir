import 'package:appdir/application/address_edit.dart';
import 'package:appdir/bloc/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/address_cubit.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
          Navigator.push<bool>(context, MaterialPageRoute<bool>(
            builder: (BuildContext context) => AddressEditPage()
          )).then((value) => context.read<AddressCubit>().loading())
        ,
        icon: const Icon(Icons.add),
        label: const Text('Create address'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if(state is AddressListSuccess) {
            context.read<AddressCubit>().loading();

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              itemCount: state.list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (BuildContext context, int index) {
                final address = state.list[index];

                return ListTile(
                  title: Text('Checked ${address.checkedBy}, Name: ${address.name}, Street: ${address.street},"#: ${address.numberOf}'),
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: address.checkedBy == null ? false: address.checkedBy,
                    onChanged: (bool? value) {
                    },
                  ),
                  leading:
                  Column(
                    children: [
                      Text(address.postalCode.toString()),

                    ],
                  ),
                  subtitle: Text('State: ${address.nameState.toString()}, Settlement: ${address.settlement}' ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressEditPage(addressParam: address)));
                  },
                );
              },
            );
          } else {
            return Container();
          }

        },
      )
    );
  }

}
