// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:streams_ex/app_cubits/database_cubit.dart';
// import 'package:streams_ex/camera_page.dart';
//
// void main() {
//   runApp(BlocProvider<DatabaseCubit>(
//     create: (context) =>
//     DatabaseCubit()
//       ..initializeDatabase(),
//     child: MyApp(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocBuilder<DatabaseCubit, DatabaseState>(
//         builder: (context, state) {
//           return Container(
//             color: Colors.white,
//             child: state is onDatabaseFail? Center(child: Text('${state.error}')):Center(child: Text('${state}')),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrz_scanner/mrz_scanner.dart';
import 'dart:ui' as ui;

import 'package:screenshot/screenshot.dart';
import 'package:streams_ex/app_cubits/database_cubit.dart';
import 'package:streams_ex/app_cubits/mrz_cubit.dart';
import 'package:streams_ex/views/home_screen.dart';

Future<void> main() async {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<MrzCubit>(create: (context) => MrzCubit()),
        BlocProvider<DatabaseCubit>(create: (context) =>DatabaseCubit()..initializeDatabase(),)

  ],
  child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "this app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomeScreen(),
    );
  }
}
