import 'package:flutter/material.dart';
import 'package:my_lab_app/Resources/Constants/global_variables.dart';

class AppLogo extends StatelessWidget {
  final Size size;
  final String? type;
  const AppLogo({super.key, required this.size, this.type = 'black'});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.kPrimaryColor,
      child: Icon(Icons.person_rounded),
    );
    // return Container(
    //   width: size.width,
    //   height: size.height,
    //   padding: EdgeInsets.zero,
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(100),
    //     child: type == 'full'
    //         ? Image.asset("Assets/Images/full_logo.png")
    //         : Image.asset("Assets/Images/logo.png"),
    //   ),
    // );
  }
}

class DisplayImage extends StatelessWidget {
  final Size size;
  final String imagePath;
  final double radius;
  const DisplayImage({
    super.key,
    required this.size,
    required this.imagePath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(imagePath),
      ),
    );
  }
}
