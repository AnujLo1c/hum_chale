import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomSnackbar {
  customSnackbar(contenttype, title, message) {
    ContentType c;
    switch (contenttype) {
      case 0:
        c = ContentType.failure;
        break;
      case 1:
        c = ContentType.success;
        break;
      case 2:
        c = ContentType.help;
        break;
      case 3:
        c = ContentType.warning;
        break;
      default:
        c = ContentType.help;
    }
    return SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: c,
        ));
  }
}
