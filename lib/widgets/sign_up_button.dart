import 'package:flutter/material.dart';

class AppCustomButtons extends StatelessWidget {
  AppCustomButtons({
    Key? key,
    this.ImagePath,
    required this.title,
    required this.ontap,
    this.buttonColor,
    this.textColor,
    this.fontsize,
    this.isLoading,
  }) : super(key: key);
  Function()? ontap;
  String? ImagePath;
  Widget title;
  Color? buttonColor;
  Color? textColor;
  double? fontsize;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: buttonColor??Colors.white,
              minimumSize: Size(100,
                  MediaQuery.of(context).size.height * 0.08),
              maximumSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.08)),
          onPressed: ontap,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child:ImagePath != null ? Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container()),
                Expanded(
                    flex: 7,
                    child: Center(
                        child: title
                    )
                ),
              ],
            ):
            Center(
                child: title
            ),
          )),
    );
  }
}
