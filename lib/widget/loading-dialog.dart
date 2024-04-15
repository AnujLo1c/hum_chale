import 'package:flutter/material.dart';

class LoadingDialog {
  loadingDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0.4),
        barrierDismissible: false,

        builder: (context) =>  Container(
          color: Colors.white.withOpacity(.4),
              height: double.infinity,
              width: double.infinity,
              child: const Center(child: CircularProgressIndicator())),

    );
  }
}