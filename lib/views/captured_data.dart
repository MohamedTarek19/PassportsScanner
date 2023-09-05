
import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:streams_ex/app_cubits/database_cubit.dart';
import 'package:streams_ex/app_cubits/mrz_cubit.dart';
import 'package:streams_ex/models/passport_datamodel.dart';
import 'package:streams_ex/widgets/captured_tile.dart';

class CapturedData extends StatelessWidget {
  const CapturedData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: () {
            context.read<MrzCubit>().flag = false;
            Navigator.popUntil(
                context,
                    (route) =>
                Navigator.canPop(context) == false);
          }, icon: Icon(Icons.arrow_back , color: Colors.white,),

          ),
          title: const Center(child: Text('Captured data')),
        ),
        body: BlocBuilder<MrzCubit, MrzState>(
          builder: (context, state) {

            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.97,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Image.memory(context.read<MrzCubit>().passportPhoto!),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Ok")),
                              ],
                            );
                          } );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                  image: MemoryImage(
                                      context.read<MrzCubit>().passportPhoto!))),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            CapturedTile(
                              title: 'Name',
                              data: context.read<MrzCubit>().result?.givenNames ??
                                  '',
                            ),
                            CapturedTile(
                              title: 'Gender',
                              data:
                                  context.read<MrzCubit>().result?.sex.name ?? '',
                            ),
                            CapturedTile(
                              title: 'CountryCode',
                              data:
                                  context.read<MrzCubit>().result?.countryCode ??
                                      '',
                            ),
                            CapturedTile(
                              title: 'Date of Birth',
                              data: context.read<MrzCubit>().result?.birthDate.toString() ?? '',
                            ),
                            CapturedTile(
                              title: 'Expiry date',
                              data: context.read<MrzCubit>().result?.expiryDate.toString() ?? '',
                            ),
                            CapturedTile(
                              title: 'DocNum',
                              data: context.read<MrzCubit>().result?.documentNumber.toString() ?? '',
                            ),
                            BlocBuilder<DatabaseCubit, DatabaseState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.of(context).size.width*0.5,40),
                                    maximumSize: Size(MediaQuery.of(context).size.width*0.5,40),
                                  ),
                                    onPressed: () async {
                                      final p = await getApplicationDocumentsDirectory();
                                      String path = p.path;
                                      var imageFile =
                                      await File('$path/${DateTime.now()}.jpg').writeAsBytes(context.read<MrzCubit>().passportPhoto!);

                                      context.read<DatabaseCubit>().passports.add(PassPortModel(
                                              name: context.read<MrzCubit>().result?.givenNames ?? '',
                                              countryCode: context.read<MrzCubit>().result?.countryCode ?? '',
                                              image: imageFile.path,
                                              birth: context.read<MrzCubit>().result?.birthDate.toString() ?? '',
                                              expire: context.read<MrzCubit>().result?.expiryDate.toString() ?? '',
                                              sex: context.read<MrzCubit>().result?.sex.name ?? '',
                                              documentNo: context.read<MrzCubit>().result?.documentNumber.toString() ?? ''));
                                      await context.read<DatabaseCubit>().
                                      insertData("""
                                      INSERT INTO 'passports' ('name','countryCode','image','birth','expire','sex','documentNo')
                                       VALUES
                                       ('${context.read<MrzCubit>().result?.givenNames ?? ''}',
                                       '${context.read<MrzCubit>().result?.countryCode ?? ''}',
                                       '${imageFile.path}',
                                       '${context.read<MrzCubit>().result?.birthDate.toString() ?? ''}',
                                       '${context.read<MrzCubit>().result?.expiryDate.toString() ?? ''}',
                                       '${context.read<MrzCubit>().result?.sex.name ?? ''}',
                                       '${context.read<MrzCubit>().result?.documentNumber.toString() ?? ''}'
                                       )
                                      """);
                                      context.read<MrzCubit>().flag = false;
                                      Navigator.popUntil(
                                          context,
                                          (route) =>
                                              Navigator.canPop(context) == false);
                                    },
                                    child: state is onInsertingDataLoading? Center(child: CircularProgressIndicator(color: Colors.white,))
                                        :Text('Save data'));
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
