import 'package:appdir/domain/address.dart';
import 'package:flutter/material.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({
    Key? key,
  }) : super(key: key);

  static const routeName = 'addresses';

  @override
  Widget build(BuildContext context) {
    final list = [
      Address(id: 1, name:"a", street:"b"),
      Address(id: 2, name:"aa", street:"bb"),
      Address(id: 3, name:"aaa", street:"bbb"),
      Address(id: 4, name:"aaaa", street:"bbbb"),
    ]; // context.watch<ContactController>().contacts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //appRouter.pushNamed(ContactEditView.routeNameCreate);
        },
        icon: const Icon(Icons.add),
        label: const Text('Create address'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        restorationId: 'sampleItemListView',
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          final address = list[index];

          return ListTile(
            title: Text('${address.name} ${address.street}'),
            leading: CircleAvatar(
              child: Text(address.postalCode.toString()),
            ),
            onTap: () {
              // appRouter.pushNamed(ContactDetailsView.routeName,
              //     params: {'id': contact.id.toString()});
            },
          );
        },
      ),
    );
  }
}
