import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';

class CustomPrimaryBottom extends StatelessWidget {
  const CustomPrimaryBottom({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
    this.onTap,
  });
  final String name;
  final String description;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
      color: const Color.fromARGB(255, 255, 255, 255),
      // shadowColor: Color.fromARGB(88, 28, 22, 22),
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        onTap: onTap,
        child: Container(
          width: width * .18, //width * .2,
          height: height * 0.3, //height * 0.3,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Icon(
                  icon,
                  color: AppColors.green1,
                  size: 55,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Styles.textStyle17DarkGreen,
                  ),
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Styles.textStyle12, //Styles.textStyle15DarkGreen,
                  // const TextStyle(
                  //   color: Color.fromARGB(170, 7, 46, 51),
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w500,
                  // ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
