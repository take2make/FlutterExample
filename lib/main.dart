import 'package:flutter/material.dart';
//import 'counter/bloc/counter_cubit.dart';
//import 'counter/view/counter_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'customize/bloc/customize_cubit.dart';
import 'customize/view/customize.dart';
import 'customize/model/customize_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => CustomizeCubit(
          repository: CustomizeRepository(),
        ),
        child: Customize(),
      ),
    );
  }
}
