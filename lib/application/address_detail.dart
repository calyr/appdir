import 'package:appdir/domain/address.dart';
import 'package:flutter/material.dart';

class AddressDetailView extends StatelessWidget {
  const AddressDetailView({Key? key, required this.id}) : super(key: key);
  final int id;

  static const routeName = '/address-details';
  @override
  Widget build(BuildContext context) {
    final address = new Address(id: 1, name:"a", street: "b");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Details'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // appRouter.pushNamed(
          //   ContactEditView.routeNameEdit,
          //   params: {'id': id.toString()},
          // );
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Address'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        children: [
          ListTile(
            dense: true,
            title: const Text('Name'),
            subtitle: Text('${address.name} ${address.name}'),
          ),
          ListTile(
            dense: true,
            title: const Text('Street'),
            subtitle: Text(address.street.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Number'),
            subtitle: Text(address.numberOf.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Postal Code'),
            subtitle: Text(address.postalCode.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('State'),
            subtitle: Text(address.nameState.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Municipality'),
            subtitle: Text(address.municipality.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Settlement'),
            subtitle: Text(address.settlement.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Additional'),
            subtitle: Text(address.additional.toString()),
          ),
          ListTile(
            dense: true,
            title: const Text('Checked by default'),
            subtitle: Text(address.checkedBy.toString()),
          ),
        ],
      ),
    );
  }
}
