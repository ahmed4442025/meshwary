import 'dart:ui';

import 'package:flutter/material.dart';

import 'image_assets.dart';

class WidgetHelp {
  // -------- background image for body -----------
  static Widget bg_img_with_gradien(Widget child,
          {String imgPath = 'assets/images/bg/1.jpg'}) =>
      Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                imgPath,
              ),
            ),
          ),
          height: double.infinity,
        ),
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0), // todo
                    Colors.black.withOpacity(.7), // todo
                  ],
                  stops: const [
                    0.0, // todo
                    1.0 // todo
                  ])),
          child: child,
        )
      ]);

  // -------- blure image for body -----------
  static Widget bg_img_blure(
          {Widget? child, String imgPath = 'assets/images/bg/1.jpg'}) =>
      Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: ExactAssetImage(imgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: child,
        ),
      );

  // ------------- main body --------------
  static Widget baseLoginBody(List<Widget> columnChildren, {required formKey}) {
    columnChildren.insert(0, Image.asset(ImageAssets.splashLogo));
    columnChildren.insert(1, box20());
    // blur image
    return bg_img_blure(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: columnChildren,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------ textFieldForm ------------
  static Widget textFieldForm({
    String? hint,
    String? label,
    TextEditingController? controller,
  }) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hint, label: Text(label ?? '')),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "this field can't be empty";
          }
          return null;
        },
      );

  // ----------- textLink ----------
  static Widget textLink({VoidCallback? onPressed, String? txt}) =>
      TextButton(onPressed: onPressed, child: Text(txt ?? ''));

  // ------- button ----------
  static button({VoidCallback? onPressed, Widget? child}) => ElevatedButton(
        onPressed: onPressed,
        child: child,
      );

  // ----------  fixed box  -------------
  static Widget box20() => const SizedBox(height: 20);

  static Widget box15() => const SizedBox(height: 15);
}
