import 'package:appdir/application/address_list.dart';
import 'package:appdir/bloc/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/address_bloc_observer.dart';

void main() {
  Bloc.observer = AddressBlocObserver();
  runApp(AddressApp());
}

class AddressApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AddressCubit(),
        child: AddressListView(),
      )
    );
  }
}