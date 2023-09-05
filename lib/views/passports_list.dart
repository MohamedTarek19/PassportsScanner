import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streams_ex/app_cubits/database_cubit.dart';
import 'package:streams_ex/views/preview_data.dart';

class PassportsList extends StatelessWidget {
  const PassportsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Saved passports'),
      ),
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.87,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: context
                      .read<DatabaseCubit>()
                      .passports
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Material(
                        elevation: 5,
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(context.read<DatabaseCubit>().passports[index].name ?? '',
                            style: const TextStyle(fontSize: 15),),
                          leading: Text('${context.read<DatabaseCubit>().passports[index].id ?? index}',
                            style: const TextStyle(fontSize: 15),),
                          onTap: (){
                            context.read<DatabaseCubit>().item = context.read<DatabaseCubit>().passports[index];
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return PreviewData();
                            }));
                          },
                        ),
                      ),
                    );
                  },),
              ),
            ],
          );
        },
      ),
    );
  }
}
