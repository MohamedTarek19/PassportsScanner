
import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:streams_ex/app_cubits/database_cubit.dart';
import 'package:streams_ex/app_cubits/mrz_cubit.dart';
import 'package:streams_ex/models/passport_datamodel.dart';
import 'package:streams_ex/widgets/captured_tile.dart';

class PreviewData extends StatelessWidget {
  const PreviewData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Center(child: Text('Captured data')),
      ),
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Image.file(File(context.read<DatabaseCubit>().item?.image??'')),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Ok")),
                            ],
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                alignment: Alignment.center,
                                fit: BoxFit.fitWidth,
                                image: FileImage(
                                    File(context.read<DatabaseCubit>().item?.image??'')))),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CapturedTile(
                            title: 'Name',
                            data: context.read<DatabaseCubit>().item?.name ??
                                '',
                          ),
                          CapturedTile(
                            title: 'Gender',
                            data:
                            context.read<DatabaseCubit>().item?.sex ?? '',
                          ),
                          CapturedTile(
                            title: 'CountryCode',
                            data:
                            context.read<DatabaseCubit>().item?.countryCode ??
                                '',
                          ),
                          CapturedTile(
                            title: 'Date of Birth',
                            data: context.read<DatabaseCubit>().item?.birth.toString() ?? '',
                          ),
                          CapturedTile(
                            title: 'Expiry date',
                            data: context.read<DatabaseCubit>().item?.expire.toString() ?? '',
                          ),
                          CapturedTile(
                            title: 'DocNum',
                            data: context.read<DatabaseCubit>().item?.documentNo.toString() ?? '',
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
