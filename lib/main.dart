import 'package:appdir/application/address_edit.dart';
import 'package:appdir/application/address_list.dart';
import 'package:appdir/domain/address.dart';
import 'package:appdir/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/address_detail.dart';
import 'bloc/address_bloc_observer.dart';

void main() {
  Bloc.observer = AddressBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Address app',
      initialRoute: 'edit',
      routes: {
        'list' : ( BuildContext context) => AddressListView() ,
        'edit' : ( BuildContext context) => AddressEditView(id: 1) } ,
      // home: AddressDetailView(id: 1,),
      //home: AddressEditView(id: 1,),
      //home: AddressListView(),
    ) ;
  }

}
// class MyApp extends StatelessWidget {
//   final addressBloc = new AddressBloc();
//   @override
//   Widget build(BuildContext context ) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Address Direction",
//       home: Scaffold(
//         appBar: AppBar(
//           title: StreamBuilder(
//             stream: addressBloc.addressSizeStream,
//             builder: (BuildContext context, AsyncSnapshot snapshot){
//               return Container(
//                 child: Text("Cantidad de Direcciones ${snapshot.data ?? 0}"),
//               );
//             },
//           ),
//         ),
//         body:
//           StreamBuilder(
//             stream: addressBloc.getListAddress,
//             builder: (_, AsyncSnapshot<List<Address>> snapshot) {
//               final address = snapshot.data ?? [];
//               return ListView.builder(
//                   itemCount: address.length,
//                   itemBuilder:
//               ( _, i) {
//                 return ListTile(
//                   title: Text(address[i].name.toString()),
//                 );
//               }
//               );
//             } ,
//           )
//         ,
//       )
//     );
//
//   }
//
// }