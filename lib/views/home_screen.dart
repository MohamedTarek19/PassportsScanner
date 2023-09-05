import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:streams_ex/app_cubits/database_cubit.dart';
import 'package:streams_ex/views/passports_list.dart';
import 'package:streams_ex/views/scanner_screen.dart';
import 'package:streams_ex/widgets/custom_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Center(child: Text("Home Screen")),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Text('Welcome to Passport scanner app!',
                      style: TextStyle(fontSize: 20),),
                    const Spacer(),
                    Lottie.asset('assets/pass3.json',
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.3
                    ),
                    const Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCustomButtons(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ScannerScreen();
                          }));
                    },
                    title: const Text('Scan a passport',style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                  BlocBuilder<DatabaseCubit, DatabaseState>(
                    builder: (context, state) {
                      return AppCustomButtons(
                        ontap: () async {
                          var res = await context.read<DatabaseCubit>().readData("SELECT * FROM 'passports' ");
                          print(res);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const PassportsList();
                                  }));
                        },
                        title: state is onGettingDataLoading?const Center(child: CircularProgressIndicator(color: Colors.purple,)):const Text('Get scanned Passports',style: TextStyle(color: Colors.black, fontSize: 15)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
