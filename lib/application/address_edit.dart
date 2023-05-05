import 'package:appdir/domain/address.dart';
import 'package:flutter/material.dart';

class AddressEditView extends StatefulWidget {
  const AddressEditView({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  static const routeNameEdit = '/address-edit';
  static const routeNameCreate = '/address-create';

  @override
  State<AddressEditView> createState() => _AddressEditViewState();
}

class _AddressEditViewState extends State<AddressEditView> {
  late final TextEditingController _nameController;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;
  late final TextEditingController _postalCodeController;

  // late final _contact = context
  //     .read<ContactController?>()
  //     ?.contacts
  //     .firstWhereOrNull((contact) => contact.id == widget.id);
  late final _address = new Address(id: 1, name:"a", street: "bstreet");

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _address?.name);
    _streetController = TextEditingController(text: _address?.street);
    _numberController = TextEditingController(text: _address?.numberOf);
    _postalCodeController = TextEditingController(text: _address?.postalCode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_address == null ? 'Create Address' : 'Edit Address'),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (Form.of(context)!.validate()) {}
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            children: [
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value?.isEmpty ?? true) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  label: Text('Street'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value?.isEmpty ?? true) ? 'Street is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numberController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  label: Text('Number'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value?.isEmpty ?? true) ? 'Number is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _postalCodeController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  label: Text('Postal Code'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                (value?.isEmpty ?? true) ? 'Postal Code is required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text("Checked"),
                  Checkbox(value: true, onChanged: (_) {

                  }),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Form.of(context)!.reset();
                },
                child: const Text('Reset'),
              )
            ],
          ),
        );
      }),
    );
  }
}
